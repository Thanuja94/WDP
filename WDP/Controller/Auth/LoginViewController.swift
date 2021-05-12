//
//  LoginViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/16/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, FireAuthAccesable {
    
    // MARK: - Properties
    @IBOutlet weak var EmalTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var SignInButton: UIButton!
    
    @IBOutlet weak var NeedAccButton: UIButton!
    
    internal lazy var loading: LoadingView = {
        let lv = LoadingView(frame: self.view.bounds)
        return lv
    }()
    
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
        PasswordTextField.isSecureTextEntry = true
    }
    
    
    
    
    
    @IBAction func HandleSignIn(_ sender: Any) {
        guard let email = EmalTextField.text else { return }
        guard let password = PasswordTextField.text else { return }
        
        self.loading.start(in: self.view, withBackground: true)
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.loading.stop()
            if let error = error {
                print("DEBUG: Faild to login user with error \(error)")
                return
            }
            print("DEBUG: login successfully ")
            self.checkUserRole(with: result?.user.uid)
        }
    }
    
    
    func checkUserRole(with userId: String?)  {
        self.loading.start(in: self.view, withBackground: true)
        fetchUserData(uid: currentUser ?? "") { user in
            self.loading.stop()
            let role = user.role
            if(role == "Normal"){
                let newView = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                newView.userRole = role
                self.navigationController?.pushViewController(newView, animated: true)
            }
            if (role == "Admin") {
                let newView = self.storyboard?.instantiateViewController(withIdentifier: "AdminVC") as! AdminViewController
                newView.userRole = role
                self.navigationController?.pushViewController(newView, animated: true)
            }
        }
    }
}
