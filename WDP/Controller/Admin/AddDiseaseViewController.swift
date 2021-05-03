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
    
    
    
    @IBAction func HandleAdd(_ sender: Any) {
        
        guard let diseasename = DiseaseNameTextField.text else { return }
        
        guard let symptoms = SymptomsTextView.text else { return }

        guard let precautions = PrecautionTextView.text else { return }

        
        let values = [
              "diseasename": diseasename,
              "symptoms": symptoms,
              "precautions": precautions
              
              ] as [String : Any]
        
        
        
        DB_REF.child("diseases").child(diseasename).updateChildValues(values){ (error, ref) in
            
            print("DEBUG: Successfully save data ")
            
            
            if let error = error {
                                     print("DEBUG: failto save \(error)")
                                     return
                                 }
            
           
            
        }
          navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    
}
