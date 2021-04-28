//
//  DiseaseInfoViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/28/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit

class DiseaseInfoViewController: UIViewController {

    // MARK: - Properties

    
    @IBOutlet weak var Diseaselabel: UILabel!
    
    @IBOutlet weak var SymptomsLabel: UILabel!
    
    
    @IBOutlet weak var SymptomsTextView: UITextView!
    
    @IBOutlet weak var PrecautionLabel: UILabel!
    
    
    @IBOutlet weak var PrecautionTextView: UITextView!
    
    
    @IBOutlet weak var RateButton: UIButton!
    
    
    // MARK: - Lifecycale
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
 // MARK: - Functions
    
    func setupUI()   {
        RateButton.layer.cornerRadius = 10
        RateButton.layer.masksToBounds = true
      }
    
}
