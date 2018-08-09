//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by Robert Chen on 12/23/15.
//  Copyright © 2015 Thorn Technologies. All rights reserved.
//
import UIKit
import MapKit
protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}
class PesquisarViewController : UIViewController {
    var selectedPin:MKPlacemark? = nil
    var resultSearchController:UISearchController? = nil
    
    let locationManager = CLLocationManager()    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Procure por algum lugar"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.navigationItem.setHidesBackButton(false, animated:true);
    }
}
    
    
    







extension PesquisarViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
}
extension PesquisarViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        
        dao.denuncia.address = placemark.title!
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.03, 0.03)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}

