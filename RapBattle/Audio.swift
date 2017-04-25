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
    
    var localAudioURL: URL?         // A link to the audio file on device
    var firebaseAudioURL: URL?
    var audioID: String?             // A unique ID for this file
    var user: User?                // User that created this file
    var createdAt: Date?             // Timestamp
    
    convenience init(localAudioURL: URL, user: User) {
        self.init()
        self.localAudioURL = localAudioURL
        self.user = user
        self.createdAt = Date()
        self.audioID = UUID().uuidString
        self.firebaseAudioURL = URL.init(string: "\(self.audioID).m4a")!
    }
    
    convenience init(json: NSDictionary){
        self.init()
        audioID = json["audioID"] as? String
        
        if let firebaseUrlString = json["firebaseAudioURL"] as? String {
            firebaseAudioURL = URL(fileURLWithPath: firebaseUrlString)
        }
        
        if let localUrlString = json["localAudioURL"] as? String {
            localAudioURL = URL(fileURLWithPath: localUrlString)
        }
        
        user = User(json: json["recorder"] as? NSDictionary)
        
    }
    
    func getAsDictionary() -> [String: Any] {
        return ["localAudioURL"     : localAudioURL!.absoluteString,
                "firebaseAudioURL"  : firebaseAudioURL!.absoluteString,
                "audioID"           : audioID!,
                "recorder"            : user!.getAsDictionary()]
    }
}
