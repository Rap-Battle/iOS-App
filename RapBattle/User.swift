//
//  User.swift
//  RapBattle
//
//  Created by Deep S Randhawa on 3/23/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit
import Firebase

class User {
    
    //var username:String?
    var email: String?
    var name : String?

    private static let _userDefaultsKey: String = "RapBattleCurrentUser"
    
    //create singleton user object
    static let currentUser = User()
    
    func getUsername() -> String {
        let periodIndex = self.email!.characters.index(of: "@")!
        return String(self.email!.characters.prefix(upTo: periodIndex))
    }
    
    func getName() -> String {
        return name!
    }
    
    convenience init(json: NSDictionary?){
        self.init()
        email = json?["email"] as? String
        name = json?["name"] as? String
    }
    func getAsDictionary() -> Dictionary<String, Any> {
            return ["email": self.email!,
                    "name" : self.name!]
        
    }
}
