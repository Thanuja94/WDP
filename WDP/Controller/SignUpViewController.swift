//
//  SignUpViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/22/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
     // MARK: - Properties
    
   
    
    @IBOutlet weak var FirstNameTextField: UITextField!
    
    @IBOutlet weak var LastNameTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    @IBOutlet weak var OccupationTextField: UITextField!
    
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var AlreadyHaveButton: UIButton!
    
    // MARK: - Lifecycale
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - Functions
    func setupUI()   {
        Utilities.filledButton(button: SignUpButton)
         Utilities.filledButton(button: AlreadyHaveButton)
    }
    
    
    @IBAction func HandleSignUP(_ sender: Any) {
        
        guard let firstname = FirstNameTextField.text else { return }
        guard let lastname = LastNameTextField.text else { return }
        guard let email = EmailTextField.text else { return }
        guard let password = PasswordTextField.text else { return }
        guard let occupation = OccupationTextField.text else { return }
        

        
        let values = [
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "occuption": occupation
        
        
        ] as [String : Any]
        
         print("DEBUG: Sign up click")
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                           print("DEBUG: Faild to register user with error \(error)")
                           return
                       }
             guard let uid = result?.user.uid else { return }
            
            Database.database().reference().child("users").child(uid).updateChildValues(values){ (error, ref) in
                
                print("DEBUG: Successfully registered and save data ")
                
                if let error = error {
                                         print("DEBUG: failto save \(error)")
                                         return
                                     }
            }
            
        }
        
//        print("DEBUG: user ", values)
    }
    
    
}
