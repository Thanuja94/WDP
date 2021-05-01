//
//  LoginViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/16/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    // MARK: - Properties

    
    
    
    @IBOutlet weak var EmalTextField: UITextField!
    
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var SignInButton: UIButton!
    
    @IBOutlet weak var NeedAccButton: UIButton!
    
    // MARK: - Lifecycale
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    

    // MARK: - Functions
    
    func setupUI()   {
        Utilities.filledButton(button: SignInButton)
         Utilities.filledButton(button: NeedAccButton)
    }
    
    
    
    @IBAction func HandleSignIn(_ sender: Any) {
        
        guard let email = EmalTextField.text else { return }
        guard let password = PasswordTextField.text else { return }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Faild to login user with error \(error)")
                return
            }
            
            
            print("DEBUG: login successfully ")
            
           let homeViewController = HomeViewController()
           self.navigationController?.pushViewController(homeViewController, animated: true)
        }
        
        
    }
    

}
