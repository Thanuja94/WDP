//
//  DiseaseLibraryViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 5/3/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit
import Firebase

class DiseaseLibraryViewController: UIViewController {

        // MARK: - Properties
    
    @IBOutlet weak var DiseaseLibraryLabel: UILabel!
    
    
    @IBOutlet weak var DiseaseLibTableView: UITableView!
    
    
    let ref = REF_DISEASE
       
        var diseaseList = [DiseaseList]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       tabelDataSetup()
        retrieveDiseases()
    }
    

    // MARK: - Functions

       func tabelDataSetup()  {
           DiseaseLibTableView.delegate = self
           DiseaseLibTableView.dataSource = self
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
            
            self.DiseaseLibTableView.reloadData()
            
        }
    })
    
    }
    
    
    @IBAction func HandleBack(_ sender: Any) {
        
        
    }
    

}



extension DiseaseLibraryViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print("Tapped")
        
      if let VC = self.storyboard?.instantiateViewController(withIdentifier: "DiseaseLibInfoVC") as? DiseaseLibInfoViewController{
        VC.diseasename = diseaseList[indexPath.row].diseaseName ?? ""
        self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}



extension  DiseaseLibraryViewController: UITableViewDataSource{
    
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
