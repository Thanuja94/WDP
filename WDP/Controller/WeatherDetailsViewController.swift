//
//  WeatherDetailsViewController.swift
//  WDP
//
//  Created by Thathsara Senarathne on 2021-05-08.
//  Copyright © 2021 NIBM. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class WeatherViewController: UIViewController {
    @IBOutlet weak var tempretureLable: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var diseaseTableView: UITableView!
    
    var weatherData: Weather!
    let ref = REF_DISEASE
    var diseaseList = [DiseaseList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        updateUIWithNewData(with: weatherData)
        retrieveDiseases(with: weatherData)
    }
    
    func setupTableView() {
        diseaseTableView.delegate = self
        diseaseTableView.dataSource = self
    }
    
    func updateUIWithNewData(with data: Weather) {
        tempretureLable.text = String(Utilities.calculateCelsius(fahrenheit: data.temperature)) + " °C"
        humidityLabel.text = String(data.humidity) + " %"
        windSpeedLabel.text = String(data.windSpeed)
    }
    
    func retrieveDiseases(with data: Weather) {
        let tempretureValue = Utilities.calculateCelsius(fahrenheit: data.temperature)
        ref.observe(DataEventType.value, with:{(snapshot) in
            self.diseaseList.removeAll()
            if(snapshot.childrenCount > 0) {
                for diseases in snapshot.children.allObjects as![DataSnapshot]{
                    let userObject = diseases.value as? [String:AnyObject]
                    let diseasename = userObject?["diseasename"] as? String ?? ""
                    let lowerMargin = userObject?["lowerMargin"] as? Double ?? 0
                    let higherMargin = userObject?["higherMargin"] as? Double ?? 0
                    
                    self.diseaseList.append(DiseaseList(diseaseName: diseasename, lowerMargin: lowerMargin, higherMargin: higherMargin))
                }
                self.diseaseList = self.diseaseList.filter { tempretureValue >= $0.lowerMargin && tempretureValue <= $0.higherMargin }
                
                DispatchQueue.main.async {
                    self.diseaseTableView.reloadData()
                }
            }
        })
    }
    
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diseaseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiseaseCell", for: indexPath)
        cell.textLabel?.text = diseaseList[indexPath.row].diseaseName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let VC = self.storyboard?.instantiateViewController(withIdentifier: "DiseaseInfoVC") as? DiseaseInfoViewController {
            VC.diseasename = diseaseList[indexPath.row].diseaseName
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
