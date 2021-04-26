//
//  SignUpViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/22/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit

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
    }
    
    
}
