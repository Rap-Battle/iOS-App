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

    private static let _userDefaultsKey: String = "RapBattleCurrentUser"
    
    //create singleton user object
    static let currentUser = User()
    
    func getUsername() -> String {
        let periodIndex = self.email!.characters.index(of: ".")!
        return String(self.email!.characters.prefix(upTo: periodIndex))
    }
    
    convenience init(json: NSDictionary?){
        self.init()
        email = json?["email"] as? String
    }
    func getAsDictionary() -> Dictionary<String, Any> {
        return ["email": self.email!]
    }
    
    /*private func getUserDataAsDict() -> [String: Any] {
        return ["username"          : self.username,
                "first_name"        : self.firstName,
                "last_name"         : self.lastName,
                //  "provider_id"       : self.providerID,
            // "photo_url"         : self.photoURL!.absoluteString,
            //"firebase_uid"      : self.firebaseUID,
            "email"             : self.email]
        //"experience_level"  : self.experienceLevel!.rawValue]
    }*/
    //private static var _currentUser: User?
    /*static var currentUser: User? {
        get {
            if (_currentUser == nil) {
                if FIRAuth.auth()?.currentUser != nil {
                    let defaults = UserDefaults.standard
                    if let userData = defaults.object(forKey: _userDefaultsKey) as? Data {
                        let dict = try! JSONSerialization.jsonObject(with: userData, options: [])
                        _currentUser = User.init(userData: dict as! Dictionary<String, Any>)
                    }
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.getUserDataAsDict(), options: [])
                defaults.set(data, forKey: _userDefaultsKey)
            } else {
                defaults.removeObject(forKey: _userDefaultsKey)
            }
            defaults.synchronize()
        }
    }*/
    
  /*  private init(userData dict: Dictionary<String, Any>) {
        self.username = dict["username"] as! String?
        self.firstName = dict["first_name"] as! String?
        self.lastName = dict["last_name"] as! String?
        self.providerID = dict["provider_id"] as! String?
        // self.photoURL = URL.init(string: (dict["photo_url"] as! String?)!)
        self.firebaseUID = dict["firebase_uid"] as! String?
        self.email = dict["email"] as! String?
        self.experienceLevel = Experience.init(rawValue: (dict["experience_level"] as! String?)!)
    }*/
    
   /* init(userInfo: FIRUserInfo, firstName: String, lastName: String, experienceLevel: Experience) {
        self.username = userInfo.displayName
        self.firstName = firstName
        self.lastName = lastName
        self.providerID = userInfo.providerID
        // self.photoURL = userInfo.photoURL
        self.firebaseUID = userInfo.uid
        self.email = userInfo.email
        self.experienceLevel = experienceLevel
    }
    */
    
    
}
