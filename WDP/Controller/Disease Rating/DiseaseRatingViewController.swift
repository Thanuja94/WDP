//
//  DiseaseRatingViewController.swift
//  WDP
//
//  Created by Thathsara Senarathne on 2021-05-09.
//  Copyright © 2021 NIBM. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class DiseaseRatingViewController: UIViewController {
    
    @IBOutlet weak var diseaseName: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    internal lazy var loading: LoadingView = {
        let lv = LoadingView(frame: self.view.bounds)
        return lv
    }()
    
    
    var diseaseData: DiseaseList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUIWithNewData(with: diseaseData)
    }
    
    
    func setupUI()   {
        submitButton.layer.cornerRadius = 10
        submitButton.layer.masksToBounds = true
    }
    
    func updateUIWithNewData(with data: DiseaseList) {
        self.diseaseName.text = data.diseaseName
        self.ratingView.text = String("(\(data.noOfUsersRate))")
        if data.ratingValue == 0.0 && data.noOfUsersRate == 0.0 {
            self.ratingView.rating = 0.0
        } else {
            self.ratingView.rating = (data.ratingValue / data.noOfUsersRate)
        }
    }
    
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        saveChangeData(with: self.diseaseData)
    }
    
    func saveChangeData(with data: DiseaseList)  {
        let name = data.diseaseName
        let ratingValue = data.ratingValue + ratingView.rating
        let noOfUsersRate = data.noOfUsersRate + 1
        
        let values: [String : Any] = ["diseasename": name,
                                      "ratingValue": ratingValue,
                                      "noOfUsersRate": noOfUsersRate]
        
        self.loading.start(in: self.view, withBackground: true)
        REF_DISEASE.child(name).updateChildValues(values){ (error, ref) in
            self.loading.stop()
            if let error = error {
                print("DEBUG: failto save \(error)")
                return
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
