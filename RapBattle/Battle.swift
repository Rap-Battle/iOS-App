//
//  Battle.swift
//  RapBattle
//
//  Created by Deep S Randhawa on 3/23/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit
import EVReflection

class Battle: EVObject {
    
    var organizer: User?             // User which created this battle
    var cyphers: [Audio?] = []       // Replies to this battle, including the original cypher
    var battleID: String?          // Unique URL/ID in Firebase
    
    required init() {
        //self.organizer = User.currentUser
        //self.battleID = UUID().uuidString
        //we initialize Battle objects that are fetched from db.
    }
    
    convenience init(json: NSDictionary){
        self.init()
        battleID = json["battleID"] as! String
        organizer = User(json: json["organizer"] as! NSDictionary)
        if let jsonCyphers = json["cyphers"] as? Array<NSDictionary> {
            var initCyphers = [Audio]()
            for audioJson in jsonCyphers {
                initCyphers.append(Audio(json: audioJson))
            }
        }
        
        
    }
    func addCyperToBattle(new cypher: Audio) {
        self.cyphers.append(cypher)
    }
    
    
}
