//
//  LoginViewController.swift
//  RapBattle
//
//  Created by Aditya Dhingra on 3/23/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    
    
    @IBAction func login(_ sender: Any) {
        let email = email_field.text!
        let password = password_field.text!
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("SignedIn Successful")
            }
        }
    }
    
    @IBAction func signup(_ sender: Any) {
       

        let email = email_field.text!
        let password = password_field.text!
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("Created User!")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColor = UIColor(red: 0, green: 205, blue: 0, alpha: 1)
        
        email_field.layer.borderColor = borderColor.cgColor
        email_field.layer.cornerRadius = 5
        email_field.layer.masksToBounds = true
        
        password_field.layer.borderColor = borderColor.cgColor
        password_field.layer.cornerRadius = 5
        password_field.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
