//
//  AdminUserProfileViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/29/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit
import DLRadioButton

class AdminUserProfileViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var ProfileNameLabel: UILabel!
    
    @IBOutlet weak var adminButton: DLRadioButton!
    
    @IBOutlet weak var normalButton: DLRadioButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var saveChangeButton: UIButton!
    
    internal lazy var loading: LoadingView = {
        let lv = LoadingView(frame: self.view.bounds)
        return lv
    }()
    
    var uid = ""
    
    // MARK: - Lifecycale
    override func viewDidLoad() {
        super.viewDidLoad()
        showProfileDetails()
    }
    
    @IBAction func deleteButtontapped(_ sender: Any) {
        self.loading.start(in: self.view, withBackground: true)
        REF_USERS.child(uid).removeValue { error, ref in
            self.loading.stop()
            if let error = error {
                print("DEBUG: failto save \(error)")
                return
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    @IBAction func saveChangesButtonTapped(_ sender: Any) {
        var role: String = ""
        if adminButton.isSelected {
            role = "Admin"
        } else if normalButton.isSelected {
            role = "Normal"
        }
        
        let values: [String : Any] = ["role": role]
        
        self.loading.start(in: self.view, withBackground: true)
        REF_USERS.child(uid).updateChildValues(values){ (error, ref) in
            self.loading.stop()
            if let error = error {
                print("DEBUG: failto save \(error)")
                return
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK: - Functions
    func showProfileDetails()  {
        self.loading.start(in: self.view, withBackground: true)
        Service.shared.fetchUserData(uid: uid){(user) in
            self.loading.stop()
            self.ProfileNameLabel.text = user.firstName + " " + user.lastName
            if user.role == "Admin" {
                self.adminButton.isSelected = true
                self.normalButton.isSelected = false
            } else if user.role == "Normal" {
                self.normalButton.isSelected = true
                self.adminButton.isSelected = false
            }
        }
    }
}
