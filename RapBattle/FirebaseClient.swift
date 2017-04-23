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
        battleFirebaseReference.child(battle.battleID).setValue(battle.toJsonString())
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
}
