//
//  HomeViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 4/22/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    
    @IBOutlet weak var MapView: MKMapView!
    
    @IBOutlet weak var AgeTextField: UITextField!
    
    @IBOutlet weak var LocationTextField: UITextField!
    
    @IBOutlet weak var CheckButton: UIButton!
    
    @IBOutlet weak var DiseaseLibraryButton: UIButton!
    
    @IBOutlet weak var ProfileButton: UIButton!
    
    internal lazy var loading: LoadingView = {
        let lv = LoadingView(frame: self.view.bounds)
        return lv
    }()
    
    let locationManager = CLLocationManager()
    var resultSearchController: UISearchController! = nil
    var selectedPin: MKPlacemark? = nil
    var selectedLocation: CLLocationCoordinate2D!
    
    // MARK: - Lifecycale
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        
        MapView.showsUserLocation = true
        MapView.userTrackingMode = .follow
        
    }
    
    
    // MARK: - Functions
    
    func setupUI()   {
        Utilities.filledButton(button: CheckButton)
        Utilities.filledButton(button: DiseaseLibraryButton)
        
        ProfileButton.layer.cornerRadius = ProfileButton.frame.width/2
        ProfileButton.layer.masksToBounds = true
        
        let locationSearchVC = storyboard!.instantiateViewController(withIdentifier: "LocationSearchViewController") as! LocationSearchViewController
        locationSearchVC.mapView = MapView
        locationSearchVC.delegate = self
        resultSearchController = UISearchController(searchResultsController: locationSearchVC)
        resultSearchController.searchResultsUpdater = locationSearchVC
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
    @IBAction func locationTextViewTapped(_ sender: Any) {
        resultSearchController.searchBar.delegate = self
        present(resultSearchController, animated: true, completion: nil)
    }
    
    
    @IBAction func HandleCheck(_ sender: Any) {
        guard let ageValue = AgeTextField.text,
              let locationValue = LocationTextField.text else {
            return
        }
        if ageValue.isEmpty || locationValue.isEmpty {
            showAlert()
        } else {
            loadData(with: self.selectedLocation)
        }
        
    }
    
    @IBAction func HandleDiseaseLibrary(_ sender: Any) {
        let newView = self.storyboard?.instantiateViewController(withIdentifier: "DiseaseLibraryVC") as! DiseaseLibraryViewController
        self.navigationController?.pushViewController(newView, animated: true)
    }
    
    @IBAction func userProfileButtontapped(_ sender: Any) {
        let newView = self.storyboard?.instantiateViewController(withIdentifier: "NormalUserProfileVC") as! NormalUserProfileViewController
        self.navigationController?.pushViewController(newView, animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Required Fields!", message: "Please enter all required fields.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadData(with location: CLLocationCoordinate2D) {
        self.loading.start(in: self.view, withBackground: true)
        CLoudRequest.loadWeatherData(lat: location.latitude, lng: location.longitude) { [weak self] data, error in
            self?.loading.stop()
            let newView = self?.storyboard?.instantiateViewController(withIdentifier: "WeatherDetalsVC") as! WeatherViewController
            newView.weatherData = data
            self?.navigationController?.pushViewController(newView, animated: true)
        }
    }
    
}

//MARK:- Location magaer delegate
extension HomeViewController : CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            MapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}

//MARK:- UISearchBar delegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

//MARK:- HandleMapSearch delegate
extension HomeViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        MapView.removeAnnotations(MapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        LocationTextField.text = placemark.name
        MapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        MapView.setRegion(region, animated: true)
        selectedLocation = placemark.coordinate
        locationManager.stopUpdatingLocation()
    }
}

//MARK:- MKMapView delegate
extension HomeViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
        button.setBackgroundImage(UIImage.init(systemName: "search"), for: .normal)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
}
