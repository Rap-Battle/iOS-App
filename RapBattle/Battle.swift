//
//  Battle.swift
//  RapBattle
//
//  Created by Deep S Randhawa on 3/23/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit

class Battle: NSObject {
    
    let user1: User?
    let user2: User?
    var barsPaths: [String] = []
    
    init(user1: User, user2: User) {
        self.user1 = user1
        self.user2 = user2
    }
    
    func addNewBar(barPath: String) {
        self.barsPaths.append(barPath)
    }
    
}
