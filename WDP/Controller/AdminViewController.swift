//
//  AdminViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/22/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var LoggedAsAdminLabel: UILabel!
    
    
    @IBOutlet weak var ManageUsersButton: UIButton!
    
    
    @IBOutlet weak var AddDiseaseButton: UIButton!
    
    
    @IBOutlet weak var EditDiseaseButton: UIButton!
    
    
    @IBOutlet weak var ViewHomePageButton: UIButton!
    
    // MARK: - Lifecycale


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - Functions

   func setupUI()   {
            Utilities.filledButton(button: ManageUsersButton)
            Utilities.filledButton(button: AddDiseaseButton)
            Utilities.filledButton(button: EditDiseaseButton)
            Utilities.filledButton(button: ViewHomePageButton)

      }

}
