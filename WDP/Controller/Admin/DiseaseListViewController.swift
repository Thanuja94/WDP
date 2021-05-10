//
//  DiseaseListViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 5/2/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DiseaseListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var DiseaseListLabel: UILabel!
    
    @IBOutlet weak var DiseaseTableView: UITableView!
    
    let ref = REF_DISEASE
    
    var diseaseList = [DiseaseList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelDataSetup()
        retrieveDiseases()
        
        
    }
    
    // MARK: - Functions
    
    func tabelDataSetup()  {
        DiseaseTableView.delegate = self
        DiseaseTableView.dataSource = self
    }
    
    
    
    func retrieveDiseases(){
        
        ref.observe(DataEventType.value, with:{(snapshot) in
            
            if(snapshot.childrenCount>0){
                self.diseaseList.removeAll()
                
                for diseases in snapshot.children.allObjects as![DataSnapshot]{
                    let userObject = diseases.value as? [String:AnyObject]
                    let diseasename = userObject?["diseasename"] as? String ?? ""
                    let lowerMargin = userObject?["lowerMargin"] as? Double ?? 0
                    let higherMargin = userObject?["higherMargin"] as? Double ?? 0
                    let ratingValue = userObject?["ratingValue"] as? Double ?? 0
                    let noOfUsersRate = userObject?["noOfUsersRate"] as? Double ?? 0
                    
                    self.diseaseList.append(DiseaseList(diseaseName: diseasename, lowerMargin: lowerMargin, higherMargin: higherMargin, ratingValue: ratingValue, noOfUsersRate: noOfUsersRate))
                }
                
                DispatchQueue.main.async {
                    self.DiseaseTableView.reloadData()
                }
            }
        })
    }
    
    
    @IBAction func HandleBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension DiseaseListViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
        
        if let VC = self.storyboard?.instantiateViewController(withIdentifier: "EditDiseaseVC") as? EditDiseaseViewController{
            VC.diseasename = diseaseList[indexPath.row].diseaseName ?? ""
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}


extension  DiseaseListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diseaseList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiseaseCell", for: indexPath)
        
        
        var disease:  DiseaseList
        
        disease = diseaseList[indexPath.row]
        
        cell.textLabel?.text = disease.diseaseName
        
        return cell
    }
    
    
    
    
    
    
}
