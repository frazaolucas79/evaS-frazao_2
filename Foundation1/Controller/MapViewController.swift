//
//  MapViewController.swift
//  Foundation1
//
//  Created by Foundation_28 on 6/12/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextViewDelegate  {
    
    //Varibles
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pin: UIImageView!
    @IBOutlet weak var denunciaView: UIView!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var searchMap: UIButton!
    @IBOutlet weak var searchIconMap: UIButton!
    @IBOutlet weak var titleDenun: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var obsView: UITextView!
    
    var mainLabel = ""
    var colorDenun = ""
    
    var coreLocationManager = CLLocationManager()
    var locationManager:LocationManager!
    
    @IBAction func updateLocation(_ sender: Any) {
        getLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboardDismissRecognizer()
        
        self.obsView.delegate = self
        obsView.text = "Adicione suas observações. Elas são importantes na resolução da denúncia."
        obsView.textColor = .lightGray
        obsView.textContainerInset = UIEdgeInsetsMake(10, 5, 0, 5)
        obsView.layer.cornerRadius = 10
        //Keyboard Functions
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        /*
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        */
        //-----------------------------------------
        
        
        pin.layer.shadowColor = UIColor.black.cgColor
        pin.layer.shadowRadius = 1
        pin.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        pin.layer.shadowOpacity = 0.5
        
        
        denunciaView.layer.cornerRadius = 10
        
        dao.denuncia.obsUsuario = obsView.text
        
        titleDenun.text! = dao.denuncia.tipoDenuncia
        //labelAddress.text = dao.denuncia.address
        
        print(type(of: colorDenun))
        
        print("\(colorDenun)")
        
        print(titleDenun.text)
        
        print(mainLabel)
        
        // descView.layer.cornerRadius = 10
        
        coreLocationManager.delegate = self as! CLLocationManagerDelegate
        
        locationManager = LocationManager.sharedInstance
        
        mapView.delegate = self as! MKMapViewDelegate
        mapView.showsScale = true
        mapView.showsPointsOfInterest = true
        mapView.showsUserLocation = true
        
        coreLocationManager.requestAlwaysAuthorization()
        coreLocationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            coreLocationManager.delegate = self as! CLLocationManagerDelegate
            coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            coreLocationManager.startUpdatingLocation()
        }
        getLocation()
        
        if titleDenun.text == "Conexão Ilegal" {
            
            denunciaView.backgroundColor = UIColor(named: "water")
            imageIcon.image = UIImage(named: "cancel")
            
        } else if titleDenun.text == "Vazamento" {
            
            denunciaView.backgroundColor = UIColor(named: "green")
            imageIcon.image = UIImage(named: "drop")
            
        } else if titleDenun.text == "Falta d'Água" {
            
            denunciaView.backgroundColor = UIColor(named: "purple")
        } else {
            
            denunciaView.backgroundColor = UIColor(named: "redish")
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func getLocation(){
        locationManager.startUpdatingLocationWithCompletionHandler({ (latitude, longitude, status, verboseMessage, error) in
            self.displayLocation(location: CLLocation(latitude: latitude, longitude: longitude))
        })
    }
    func displayLocation(location:CLLocation){
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), span: MKCoordinateSpanMake(0.02, 0.02)), animated: true)
        
        let locationPinCoord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationPinCoord
        
        //mapView.addAnnotation(annotation)
        //mapView.showAnnotations([annotation], animated: true)
        
        locationManager.reverseGeocodeLocationWithCoordinates(location, onReverseGeocodingCompletionHandler: { (reverseGeocodeInfo, placemark, error) -> Void in
            
            let address = reverseGeocodeInfo?.object(forKey: "formattedAddress") as! String
            dao.denuncia.address = address
            
        })
    }
    
    
    func locationManager(manager:CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        if status != CLAuthorizationStatus.notDetermined || status != CLAuthorizationStatus.denied || status != CLAuthorizationStatus.restricted{
            getLocation()
        }
        
    }
    
    // Keyboard Functions
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 235
        searchMap.isUserInteractionEnabled = false
        searchIconMap.isUserInteractionEnabled = false
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 235
        searchMap.isUserInteractionEnabled = true
        searchIconMap.isUserInteractionEnabled = true
        
    }
    
    /*
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        obsView.resignFirstResponder()
    }
    */
    
    func setupKeyboardDismissRecognizer(){
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(MapViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissKeyboard()
    {

        view.endEditing(true)
        
    }
    
    
    
    //----------------------------------
    
    func textViewDidBeginEditing(_ obsView: UITextView) {
        if obsView.textColor == .lightGray {
            obsView.text = nil
            obsView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ obsView: UITextView) {
        if obsView.text.isEmpty {
            obsView.text = "Adicione suas observações. Elas são importantes na resolução da denúncia."
            obsView.textColor = .lightGray
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
