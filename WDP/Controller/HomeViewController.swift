//
//  HomeViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/22/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    

    @IBOutlet weak var MapView: MKMapView!
    
    @IBOutlet weak var AgeTextField: UITextField!
    
    
    @IBOutlet weak var LocationTextField: UITextField!
    
    @IBOutlet weak var CheckButton: UIButton!
    
    @IBOutlet weak var DiseaseLibraryButton: UIButton!
    
    @IBOutlet weak var ProfileButton: UIButton!
    
    // MARK: - Lifecycale

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
    }
    

    // MARK: - Functions

    func setupUI()   {
           Utilities.filledButton(button: CheckButton)
            Utilities.filledButton(button: DiseaseLibraryButton)
        
                ProfileButton.layer.cornerRadius = ProfileButton.frame.width/2
        ProfileButton.layer.masksToBounds = true
       }
}
