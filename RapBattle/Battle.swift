//
//  Battle.swift
//  RapBattle
//
//  Created by Deep S Randhawa on 3/23/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit
import EVReflection

class Battle {
    
    var organizer: User?             // User which created this battle
    var cyphers: [Audio?] = []       // Replies to this battle, including the original cypher
    var battleID: String?          // Unique URL/ID in Firebase
    
    required init() {
        self.organizer = User.currentUser
        self.battleID = UUID().uuidString
        // we initialize Battle objects that are fetched from db.
    }
    
    func addCyperToBattle(new cypher: Audio) {
        self.cyphers.append(cypher)
    }
    
    convenience init(json: NSDictionary){
        self.init()
        battleID = json["battleID"] as? String
        organizer = User(json: json["organizer"] as? NSDictionary)
        let fetchedCyphers = json["cyphers"] as! NSDictionary
        
        for (_, audioJson) in fetchedCyphers {
            let oneAudio = Audio(json: audioJson as! NSDictionary)
            cyphers.append(oneAudio)
        }
    }
    func getAsDictionary() -> [String: Any] {
        var dict = Dictionary<String, Any>()
        
        dict["organizer"]     = organizer!.getAsDictionary()
        dict["battleID"]              = battleID
        var cypherDict = Dictionary<String, Any>()
        for audioFile in cyphers {
            cypherDict[(audioFile?.audioID)!] = audioFile?.getAsDictionary()
        }
        
        dict["cyphers"] = cypherDict
        return dict
    }
    
}
