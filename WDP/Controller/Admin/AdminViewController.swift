//
//  AdminViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/22/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController, FireAuthAccesable {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var LoggedAsAdminLabel: UILabel!
    
    
    @IBOutlet weak var ManageUsersButton: UIButton!
    
    
    @IBOutlet weak var AddDiseaseButton: UIButton!
    
    
    @IBOutlet weak var EditDiseaseButton: UIButton!
    
    
    @IBOutlet weak var ViewHomePageButton: UIButton!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    internal lazy var loading: LoadingView = {
        let lv = LoadingView(frame: self.view.bounds)
        return lv
    }()
    
    // MARK: - Lifecycale
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - Functions
    
    func setupUI()   {
        Utilities.filledButton(button: ManageUsersButton)
        Utilities.filledButton(button: AddDiseaseButton)
        Utilities.filledButton(button: EditDiseaseButton)
        Utilities.filledButton(button: ViewHomePageButton)
        Utilities.filledButton(button: logoutButton)
    }
    
    @IBAction func HandleAddDiseases(_ sender: Any) {
        let newView = self.storyboard?.instantiateViewController(withIdentifier: "AddDiseaseVC") as! AddDiseaseViewController
        self.navigationController?.pushViewController(newView, animated: true)
    }
    
    
    @IBAction func HandleEditDiseases(_ sender: Any) {
        let newView = self.storyboard?.instantiateViewController(withIdentifier: "DiseaseListVC") as! DiseaseListViewController
        self.navigationController?.pushViewController(newView, animated: true)
    }
    
    
    @IBAction func HandleViewHomePage(_ sender: Any) {
        
        let newView = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        self.navigationController?.pushViewController(newView, animated: true)
        
    }
    
    
    @IBAction func HandleManageUsers(_ sender: Any) {
        let newView = self.storyboard?.instantiateViewController(withIdentifier: "UserListVC") as! UserListViewController
        self.navigationController?.pushViewController(newView, animated: true)
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        self.loading.start(in: self.view, withBackground: true)
        logOut { [weak self] completed in
            self?.loading.stop()
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
