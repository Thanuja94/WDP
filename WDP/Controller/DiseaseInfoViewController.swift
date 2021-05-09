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
    
    @IBOutlet weak var backButton: UIButton!
    
    var diseasename = ""
    
    // MARK: - Lifecycale
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        showDiseaseDetails()
    }
    
    // MARK: - Functions
    
    func setupUI()   {
        RateButton.layer.cornerRadius = 10
        RateButton.layer.masksToBounds = true
    }
    
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ratingButtonTapped(_ sender: Any) {
        let newView = self.storyboard?.instantiateViewController(withIdentifier: "DiseaseRatingVC") as! DiseaseRatingViewController
        newView.diseasename = Diseaselabel.text ?? ""
        self.navigationController?.pushViewController(newView, animated: true)
    }
    
    func showDiseaseDetails()  {
        Service.shared.fetchDiseaseData(diseaseName: diseasename ){(disease)in
            self.Diseaselabel.text = disease.diseaseName
            self.SymptomsTextView.text = disease.symptoms
            self.PrecautionTextView.text = disease.precautions
        }
    }
}
