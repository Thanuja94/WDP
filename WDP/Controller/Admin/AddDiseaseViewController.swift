//
//  AddDiseaseViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/27/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit
import MapKit

class AddDiseaseViewController: UIViewController {

   // MARK: - Properties
    
    @IBOutlet weak var AddDiseaseLabel: UILabel!
    
    
    @IBOutlet weak var DiseaseNameTextField: UITextField!
    
    
    @IBOutlet weak var SymptomsLabel: UILabel!
    
   
    @IBOutlet weak var SymptomsTextView: UITextView!
    
    
    @IBOutlet weak var PrecautionLabel: UILabel!
    
    
    @IBOutlet weak var PrecautionTextView: UITextView!
    
    @IBOutlet weak var AddButton: UIButton!
    
    // MARK: - Lifecycale
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
 // MARK: - Functions

    func setupUI()   {
           Utilities.filledButton(button: AddButton)
            
       }
}
