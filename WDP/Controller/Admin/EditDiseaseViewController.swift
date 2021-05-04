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
        //DiseaseNameTextField.text = diseasename
        showDiseaseDetails()
        
    }
    
    // MARK: - Functions
    
    
    
    @IBAction func HandleSaveChanges(_ sender: Any) {
        
        
        saveChangeData()
    }
    
    
    
    
    @IBAction func HandleDelete(_ sender: Any) {
    }
    
    
    
    @IBAction func HandleBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)

    }
    
    func setupUI()   {
        Utilities.filledButton(button: DeleteDiseaseButton)
        Utilities.filledButton(button: SaveChangesButton)
         
    }
    
    
    func showDiseaseDetails()  {
        Service.shared.fetchDiseaseData(diseaseName: diseasename ){(disease)in

            self.DiseaseNameTextField.text = disease.diseaseName
            self.SymptomTextView.text = disease.symptoms
            self.PrecautionTextView.text = disease.precautions
        
         
         
        }
    }
    
    
    func saveChangeData()  {
        guard
            let name = DiseaseNameTextField.text,
                                let symptoms = SymptomTextView.text,
                                let precautions = PrecautionTextView.text else {
                                    
                                    return
                                    
        }
        
        let values = [
              "diseasename": name,
              "symptoms": symptoms,
              "precautions": precautions
              
              ] as [String : Any]
        
        
        
        
        REF_DISEASE.child(name).updateChildValues(values){ (error, ref) in
               
               print("DEBUG: Upadate successfully ")
               
               
               if let error = error {
                                        print("DEBUG: failto save \(error)")
                                        return
                                    }
               
              
               
           }
        
    }
}
