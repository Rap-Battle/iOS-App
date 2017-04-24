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
    
    var localAudioURL: URL          // A link to the audio file on device
    var firebaseAudioURL: URL       // A link to the audio file in Firebase
    var audioID: String             // A unique ID for this file
    var userID: User                // User that created this file
    var createdAt: Date             // Timestamp
    
    init(localAudioURL: URL, userID: User) {
        self.localAudioURL = localAudioURL
        self.userID = userID
        self.createdAt = Date()
        self.audioID = UUID().uuidString
        self.firebaseAudioURL = URL.init(string: "\(self.audioID).m4a")!
    }
    
    func getAsDictionary() -> [String: Any] {
        return ["localAudioURL"     : localAudioURL.absoluteString,
                "firebaseAudioURL"  : firebaseAudioURL.absoluteString,
                "audioID"           : audioID,
                "userEmail"            : userID.email!]
    }
}
