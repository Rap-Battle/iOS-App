//
//  FirebaseClient.swift
//  RapBattle
//
//  Created by Kinshuk Juneja on 4/11/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase

class FirebaseClient {
    let battleFirebaseReference = FIRDatabase.database().reference().child("battles")
    let rapAudioStorageReference = FIRStorage.storage().reference().child("rap_audio")
    static let currentDB = FirebaseClient()
    
    func createNewAudioFileOnFirebase(with localAudioFilePath: URL) -> Audio {
        let audioFile = Audio(localAudioURL: localAudioFilePath, userID: User.currentUser)
        rapAudioStorageReference.child("\(audioFile.firebaseAudioURL)").putFile(audioFile.localAudioURL, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error ?? "Error while uploading")
            } else {
                print("Successfully posted new audiofile")
            }
        }
        return audioFile
    }
    
    func bindTable(observer: @escaping (_ battles: [String : AnyObject]) -> Void){
                _ = battleFirebaseReference.observe(FIRDataEventType.value, with: { (snapshot) in
        
                    observer(snapshot.value as? [String : AnyObject] ?? [:])
        
                })
            }
}

//class FirebaseClient {
//    let battleFirRef = FIRDatabase.database().reference()
//    let battlesRef = FIRDatabase.database().reference().child("battles")
//    static let currentDB = FirebaseClient()
//    private init() {}
//    
//    func postAudioFile(with audioFileUrl : URL) {
//        
//        let fileName = NSUUID().uuidString + ".m4a"
//        
//        FIRStorage.storage().reference().child("rap_audio").child(fileName).putFile(audioFileUrl, metadata: nil) { (metadata, error) in
//            if error != nil {
//                print(error ?? "error")
//            }
//            
//            if let downloadUrl = metadata?.downloadURL()?.absoluteString {
//                print(downloadUrl)
//                //let values: [String : Any] = ["audioUrl": downloadUrl]
//                // self.sendMessageWith(properties: values)
//                
//                //Create a new battle object
//                
//                let newBattle = Battle()
//                let newBattle = Battle.init()
//                newBattle.audioFileURL = downloadUrl
//                newBattle.userId = User.currentUser.email
//                
//                //Upload to firebase
//                self.battleFirRef.child("battles").child(newBattle.battleId!).setValue(newBattle.getBattleDic())
//            }
//        }
//    }
//    
//    func bindTable(observer: @escaping (_ battles: [String : AnyObject]) -> Void){
//        _ = battlesRef.observe(FIRDataEventType.value, with: { (snapshot) in
//            
//            observer(snapshot.value as? [String : AnyObject] ?? [:])
//            
//        })
//    }
//    private func getCurrentDateTime() -> String {
//        let date = Date()
//        let calendar = Calendar.current
//        let day = calendar.component(.day, from: date)
//        let hour = calendar.component(.hour, from: date)
//        let minutes = calendar.component(.minute, from: date)
//        
//        return "\(day) \(hour) \(minutes)"
//    }
//}
