//
//  DiseaseListViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 5/2/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit
import Firebase

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
                       let diseasename = userObject?["diseasename"]
                       
                       
                    let disease = DiseaseList(diseaseName: diseasename as! String?)
                       self.diseaseList.append(disease)
                   }
                   
                   self.DiseaseTableView.reloadData()
                   
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
