//
//  AdminUserProfileViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/29/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit

class AdminUserProfileViewController: UIViewController {

    // MARK: - Properties

    
    @IBOutlet weak var ProfileNameLabel: UILabel!
    
    var uid = ""

    
     // MARK: - Lifecycale
    override func viewDidLoad() {
        super.viewDidLoad()

        //showProfileDetails()
        showProfileDetails()
        
    }
    
    // MARK: - Functions

    func showProfileDetails()  {
        Service.shared.fetchUserData(uid: uid){(user) in
            
            self.ProfileNameLabel.text = user.firstName + " " + user.lastName
            
            
        }
        
        
    }

}
