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
                CRNotifications.showNotification(type: .error, title: "Error", message: "Something went wrong with login!", dismissDelay: 3)
            }
            else {
                print("SignedIn Successful")
                User.currentUser.email = email
                self.performSegue(withIdentifier: "signedInSegue", sender: nil)

            }
        }
    }
    
    @IBAction func signup(_ sender: Any) {
       

        let email = email_field.text!
        let password = password_field.text!
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                 CRNotifications.showNotification(type: .error, title: "Error", message: error.localizedDescription, dismissDelay: 3)
                print(error.localizedDescription)
            }
            else {
                print("Created User!")
                User.currentUser.email = email
                self.performSegue(withIdentifier: "signedInSegue", sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColor = UIColor(red: 0, green: 150, blue: 0, alpha: 1)
        
        email_field.attributedPlaceholder = NSAttributedString(string: "Email", attributes:[NSForegroundColorAttributeName: UIColor.gray])
        password_field.attributedPlaceholder = NSAttributedString(string: "Password", attributes:[NSForegroundColorAttributeName: UIColor.gray])
        
        
        email_field.layer.borderColor = borderColor.cgColor
        email_field.layer.cornerRadius = 5
        email_field.layer.masksToBounds = true
        email_field.layer.borderWidth = 1.0
        
        password_field.layer.borderColor = borderColor.cgColor
        password_field.layer.cornerRadius = 5
        password_field.layer.masksToBounds = true
        password_field.layer.borderWidth = 1.0
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
