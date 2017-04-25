//
//  Audio.swift
//  RapBattle
//
//  Created by monus on 4/8/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit

class Audio {
    private let formatter = DateFormatter()
    
    private var localAudioURL: URL?         // A link to the audio file on device
    var firebaseFileName: String?
    var audioID: String?             // A unique ID for this file
    var user: User?                // User that created this file
    var createdAt: Date?             // Timestamp
    
    convenience init(localAudioURL: URL, user: User) {
        self.init()
        self.localAudioURL = localAudioURL
        self.user = user
        self.createdAt = Date()
        self.audioID = UUID().uuidString
        self.firebaseFileName = "\(self.audioID!).m4a"
    }
    
    convenience init(json: NSDictionary){
        self.init()
        audioID = json["audioID"] as? String
        
        firebaseFileName = json["firebaseFileName"] as? String
        
        if let localUrlString = json["localAudioURL"] as? String {
            localAudioURL = URL(fileURLWithPath: localUrlString)
        }
        
        user = User(json: json["recorder"] as? NSDictionary)
        
    }
    func getLocalAudioURL(completion: @escaping (URL) -> (), failure: @escaping (Error) -> ()) {
        if localAudioURL == nil {
            download(completion: { 
                completion(self.localAudioURL!)
            }, failure: { (error: Error) in
                failure(error)
            })
        } else {
            completion(self.localAudioURL!)
        }
    }
    func download(completion: @escaping () -> (), failure: @escaping (Error) -> ()){
        FirebaseClient.currentDB.downloadAudioFiles(file: self, completion: { (localUrl: URL) in
            self.localAudioURL = localUrl
            completion()
        }) { (error: Error) in
            failure(error)
        }
    }
    func getAsDictionary() -> [String: Any] {
        return ["firebaseFileName"  : firebaseFileName!,
                "audioID"           : audioID!,
                "recorder"            : user!.getAsDictionary()]
    }
}
