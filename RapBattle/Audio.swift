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
    
    var privateAudioURL: String?    // A link to the audio file on device
    var firebaseAudioURL: String    // A link to the audio file in Firebase
    var audioID: String             // A unique ID for this file
    var userID: User                // User that created this file
    var createdAt: Date             // Timestamp
    
    init(privateAudioURL: String, firebaseAudioURL: String, userID: User) {
        self.privateAudioURL = privateAudioURL
        self.firebaseAudioURL = firebaseAudioURL
        self.audioID = UUID().uuidString
        self.userID = userID
        self.createdAt = Date()
    }
    
    convenience init(firebaseAudioURL: String, userID: User) {
        self.init(privateAudioURL: "", firebaseAudioURL: firebaseAudioURL, userID: userID)
    }
    
    private func downloadAudioFile() -> Audio? {
        // TODO - Downloads the audiofile to the device
        return nil
    }
    
    func getAudioFile() -> Audio? {
        // TODO - Returns the audio file, downloads it if necessary
        return nil
    }
}
