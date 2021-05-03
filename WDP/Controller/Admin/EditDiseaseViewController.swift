//
//  EditDiseaseViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/28/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit

class EditDiseaseViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var DiseaseNameLabel: UILabel!
    
    
    @IBOutlet weak var DiseaseNameTextField: UITextField!
    
    
    @IBOutlet weak var SymptomLabel: UILabel!
    
    @IBOutlet weak var SymptomTextView: UITextView!
    
    
    @IBOutlet weak var PrecautionLabel: UILabel!
    
    
    @IBOutlet weak var PrecautionTextView: UITextView!
    
    @IBOutlet weak var DeleteDiseaseButton: UIButton!
    
    
    @IBOutlet weak var SaveChangesButton: UIButton!
    
    
    var diseasename = ""
    
    
    // MARK: - Lifecycale
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        DiseaseNameTextField.text = diseasename
        
    }
    
    // MARK: - Functions
    
    func setupUI()   {
        Utilities.filledButton(button: DeleteDiseaseButton)
        Utilities.filledButton(button: SaveChangesButton)
         
    }
}
