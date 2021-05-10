//
//  NormalUserProfileViewController.swift
//  WDP
//
//  Created by Thathsara Senarathne on 2021-05-10.
//  Copyright © 2021 NIBM. All rights reserved.
//

import Foundation
import UIKit

class NormalUserProfileViewController: UIViewController {
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var occupationLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var occupationTextField: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    internal lazy var loading: LoadingView = {
        let lv = LoadingView(frame: self.view.bounds)
        return lv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    func setupUI() {
        updateButton.layer.cornerRadius = 10
        updateButton.layer.masksToBounds = true
        
        logoutButton.layer.cornerRadius = 10
        logoutButton.layer.masksToBounds = true
    }
    
    @IBAction func handleBacktapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        guard let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text,
              let occupation = occupationTextField.text
        else {
            showAlert()
            return
        }
        
        let values: [String : Any] = ["firstname": firstName,
                                      "lastname": lastName,
                                      "occuption": occupation]
        
        self.loading.start(in: self.view, withBackground: true)
        REF_USERS.child(Service.shared.currentUserID ?? "").updateChildValues(values){ (error, ref) in
            self.loading.stop()
            if let error = error {
                print("DEBUG: failto save \(error)")
                return
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        self.loading.start(in: self.view, withBackground: true)
        Service.shared.logOut { completed in
            self.loading.stop()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Required Fields!", message: "Please enter all required fields.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func fetchData() {
        self.loading.start(in: self.view, withBackground: true)
        Service.shared.fetchUserData(uid: Service.shared.currentUserID ?? ""){(user) in
            self.loading.stop()
            self.updateUIWithNewData(with: user)
        }
    }
    
    func updateUIWithNewData(with data: User) {
        fullNameLabel.text = "\(data.firstName) \(data.lastName)"
        occupationLabel.text = data.occupation
        firstNameTextField.text = data.firstName
        lastNameTextField.text = data.lastName
        occupationTextField.text = data.occupation
    }
}
