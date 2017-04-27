//
//  RegisterViewController.swift
//  RapBattle
//
//  Created by Kinshuk Juneja on 4/27/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit
import FirebaseAuth
import ALCameraViewController

class RegisterViewController: UIViewController {

    var email = ""
    var password = ""
    var name = ""
    var imageUrl : URL!
    
    @IBOutlet weak var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapAddPicture(_ sender: UIButton) {
        let croppingEnabled = true
        let cameraViewController = CameraViewController(croppingEnabled: croppingEnabled) { [weak self] image, asset in
            // Do something with your image here.
            // If cropping is enabled this image will be the cropped version
            
            //Store it on firebase 
            //Get firebase id and store it under users on firebase
            
            if image != nil{
                print("image is not nil ***************")
            }
            
            
            FirebaseClient.currentDB.createNewUserImageOnFirebase(with: image!, completion: { (imageUrl: URL) in
                self?.imageUrl = imageUrl
            })
            
            
            self?.dismiss(animated: true, completion: nil)
        }
        
        present(cameraViewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapCancel(_ sender: UIButton) {
        
         self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func didTapRegister(_ sender: UIButton) {
       
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                CRNotifications.showNotification(type: .error, title: "Error", message: error.localizedDescription, dismissDelay: 3)
                print(error.localizedDescription)
            }
            else {
                print("Created User!")
                
                //Get image
                
                //Store it on firebase
                
                //Get firebase id and store it under users on firebase
                
            
                User.currentUser.email = self.email
                User.currentUser.name = self.nameField.text ?? "John Doe"
                User.currentUser.imageUrl = self.imageUrl
                
                FirebaseClient.currentDB.createNewUser()
              //  User.currentUser.dpUrl
                
                FirebaseClient.currentDB.createNewUser()
                
                self.performSegue(withIdentifier: "registerSuccessfulSegue", sender: nil)
            }
        }

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
