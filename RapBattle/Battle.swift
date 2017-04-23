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
    
    var organizer: User             // User which created this battle
    var cyphers: [Audio] = []       // Replies to this battle, including the original cypher
    var battleID: String            // Unique URL/ID in Firebase
    
    required init() {
        self.organizer = User.currentUser
        self.battleID = UUID().uuidString
    }
    
    func addCyperToBattle(new cypher: Audio) {
        self.cyphers.append(cypher)
    }
}
