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
    
    func createNewBattle(with audioFile: Audio) -> Battle {
        let battle = Battle.init()
        battle.addCyperToBattle(new: audioFile)
        battleFirebaseReference.child(battle.battleID!).setValue(battle.getAsDictionary())
        return battle
    }
    
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
    
    func bindTimelineWithTableView(observer: @escaping (_ battles: Dictionary<String, String>) -> Void) {
        battleFirebaseReference.observe(FIRDataEventType.value, with: { (snapshot) in
            observer(snapshot.value as? Dictionary<String, String> ?? [:])
        })
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    // Returns the local URL of the audio file
    func downloadAudioFiles(file: Audio) -> URL {
        let fileFirebaseRef = rapAudioStorageReference.child(file.firebaseAudioURL.absoluteString)
        let fileLocalRef = getDocumentsDirectory().appendingPathComponent("\(file.audioID).m4a")
        
        fileFirebaseRef.write(toFile: fileLocalRef) { (url, error) in
            if let error = error {
                print("Error: \(error)")
            }
        }
        return fileLocalRef
    }
}
