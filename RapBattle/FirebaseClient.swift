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
import UIKit

class FirebaseClient {
    let usersFirebaseReference = FIRDatabase.database().reference().child("Users")
    let battleFirebaseReference = FIRDatabase.database().reference().child("battles")
    let rapAudioStorageReference = FIRStorage.storage().reference().child("rap_audio")
    let userImageStorageReference = FIRStorage.storage().reference().child("userImage")
    
    static let currentDB = FirebaseClient()
    
    func createNewUser(){
        let userId = User.currentUser.getUsername()
        let userName = User.currentUser.getName()
        let imageUrl = "\(User.currentUser.imageUrl!)"
        
        usersFirebaseReference.child(userId).child("name").setValue(userName)
        usersFirebaseReference.child(userId).child("imageUrl").setValue(imageUrl)
    }
    
    func createNewReply(with audioFile: Audio, battleRepliedTo: Battle?) -> Battle {
        let battle = battleRepliedTo ?? Battle()
        battle.addCyperToBattle(new: audioFile)
        battleFirebaseReference.child(battle.battleID!).setValue(battle.getAsDictionary())
        return battle
    }
    
    func createNewUserImageOnFirebase(with image : UIImage, completion: @escaping (_ imageUrl: URL)->()) {
        
        
        let imageData: Data = UIImagePNGRepresentation(image)! as Data
        
        // Upload the file to the path "images/rivers.jpg"
        
        let imageId = UUID().uuidString
        var imageUrl : URL!
        
        userImageStorageReference.child(imageId).put(imageData as Data, metadata: nil) { (metadata, error) in
            
            if error != nil {
                  print(error ?? "Error while uploading")
            }
            else {
                // Metadata contains file metadata such as size, content-type, and download URL.
             //   imageUrl = metadata.
                imageUrl = metadata!.downloadURL()
                completion(imageUrl)
            }
        }
        
        
    }
    
    func createNewAudioFileOnFirebase(with localAudioFilePath: URL) -> Audio {
        let audioFile = Audio(localAudioURL: localAudioFilePath, user: User.currentUser)
        rapAudioStorageReference.child("\(audioFile.firebaseFileName!)").putFile(localAudioFilePath, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error ?? "Error while uploading")
            } else {
                print("Successfully posted new audiofile")
            }
        }
        return audioFile
    }
    
    func bindTimelineWithTableView(observer: @escaping (_ battles: NSDictionary) -> Void) {
        battleFirebaseReference.observe(FIRDataEventType.value, with: { (snapshot) in
            observer(snapshot.value as? NSDictionary ?? [:])
        })
    }
    
    func bindSpecificBattle(rootBattle: Battle, observer: @escaping (_ battle: NSDictionary) -> Void) {
        
        battleFirebaseReference.child(rootBattle.battleID!).observe(FIRDataEventType.value, with: { (snapshot) in
            observer(snapshot.value as? NSDictionary ?? [:])
        })
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    // Returns the local URL of the audio file
    func downloadAudioFiles(file: Audio, completion: @escaping (URL) -> (), failure: @escaping (Error) -> ()) {
        let fileFirebaseRef = rapAudioStorageReference.child(file.firebaseFileName!)
        let fileLocalRef = getDocumentsDirectory().appendingPathComponent("\(file.audioID!).m4a")
        
        fileFirebaseRef.write(toFile: fileLocalRef) { (url, error) in
            if let error = error {
                print("Error: \(error)")
                failure(error)
            } else {
                completion(fileLocalRef)
            }
        }
    }
}
