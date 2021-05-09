//
//  DiseaseRatingViewController.swift
//  WDP
//
//  Created by Thathsara Senarathne on 2021-05-09.
//  Copyright © 2021 NIBM. All rights reserved.
//

import Foundation
import UIKit

class DiseaseRatingViewController: UIViewController {
    
    @IBOutlet weak var diseaseName: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var diseasename = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.diseaseName.text = diseasename
    }
    
    func setupUI()   {
        submitButton.layer.cornerRadius = 10
        submitButton.layer.masksToBounds = true
    }
    
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
