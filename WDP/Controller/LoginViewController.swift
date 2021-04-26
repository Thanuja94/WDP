//
//  LoginViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/16/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit

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

}
