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
    
    func createNewReply(with audioFile: Audio, battleRepliedTo: Battle?) -> Battle {
        let battle = battleRepliedTo ?? Battle()
        battle.addCyperToBattle(new: audioFile)
        battleFirebaseReference.child(battle.battleID!).setValue(battle.getAsDictionary())
        return battle
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
