//
//  DiseaseLibInfoViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 5/3/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit

class DiseaseLibInfoViewController: UIViewController, FireAuthAccesable {
    
    
    // MARK: - Properties
    @IBOutlet weak var DiseasenameLabel: UILabel!
    
    
    @IBOutlet weak var SymptomsLabel: UILabel!
    
    
    @IBOutlet weak var SymptomTextView: UITextView!
    
    
    @IBOutlet weak var PrecaationLebel: UILabel!
    
    
    @IBOutlet weak var PrecautionTextView: UITextView!
    
    
    @IBOutlet weak var BackButton: UIButton!
    
    var diseasename = ""
    
    
    
    
    // MARK: - Lifecycale
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDiseaseDetails()
    }
    
    // MARK: - Functions
    func showDiseaseDetails()  {
        
        fetchDiseaseData(diseaseName: diseasename) { [weak self] disease in
            self?.DiseasenameLabel.text = disease.diseaseName
            self?.SymptomTextView.text = disease.symptoms
            self?.PrecautionTextView.text = disease.precautions
        }
    }
    
    @IBAction func HandleBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
