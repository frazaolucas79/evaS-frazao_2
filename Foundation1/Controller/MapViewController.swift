//
//  MapViewController.swift
//  Foundation1
//
//  Created by Foundation_28 on 6/12/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    //Varibles
    
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pin: UIImageView!
    @IBOutlet weak var denunciaView: UIView!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var searchMap: UIButton!
    @IBOutlet weak var searchIconMap: UIButton!
    @IBOutlet weak var titleDenun: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var obsView: UITextView!
    @IBOutlet weak var cameraOutlet: UIButton!
    @IBOutlet weak var imageUpload: UIImageView!
    @IBOutlet weak var nextPage: UIButton!
    
    @IBOutlet weak var topConstNext: NSLayoutConstraint!
    
    var mainLabel = ""
    var colorDenun = ""
    var hasButtonMoved = false
    var coreLocationManager = CLLocationManager()
    var locationManager:LocationManager!
    
    @IBAction func unwindToLocation(segue: UIStoryboardSegue) {
        //nothing goes here
    }
    
    
    @IBAction func updateLocation(_ sender: Any) {
       
    }
    
    @IBAction func camera(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(vc, animated: true)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("No image found")
            return
        }
        dao.denuncia.fotoData = image.data
        imageUpload.image = image
        imageUpload.layer.cornerRadius = 10
        if (!hasButtonMoved) {
            topConstNext.constant += 92
            heightScrollView.constant += 92
            hasButtonMoved = true
        }
        // print out the image size as a test
        print(image.size)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
      
            self.labelAddress.text = dao.denuncia.address
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboardDismissRecognizer()
        
        self.obsView.delegate = self
        obsView.text = "Adicione suas observações. Elas são importantes na resolução da denúncia."
        obsView.textColor = .lightGray
        obsView.textContainerInset = UIEdgeInsetsMake(10, 5, 0, 5)
        obsView.layer.cornerRadius = 10
        obsView.layer.shadowColor = UIColor.black.cgColor
        obsView.layer.shadowRadius = 3
        obsView.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        obsView.layer.shadowOpacity = 0.5

       // getLocation()
        
        
        //Keyboard Functions
      
        /*
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        */
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
        
        labelAddress.text = "Buscando localização..."
        
        print(type(of: colorDenun))
        
        print("\(colorDenun)")
        
        print(titleDenun.text)
        
        print(mainLabel)
        
        // descView.layer.cornerRadius = 10
        
        coreLocationManager.delegate = self as CLLocationManagerDelegate
        
        locationManager = LocationManager.sharedInstance
        
        mapView.delegate = self as MKMapViewDelegate
        mapView.showsScale = true
        mapView.showsPointsOfInterest = true
        mapView.showsUserLocation = true
        
        coreLocationManager.requestAlwaysAuthorization()
        coreLocationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            coreLocationManager.delegate = self as CLLocationManagerDelegate
            coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
            coreLocationManager.startUpdatingLocation()
        }
        
        print(dao.denuncia.address)
        
        getLocation()
        
        print(dao.denuncia.address)
        
        
        if titleDenun.text == "Conexão Ilegal" {
            
            denunciaView.backgroundColor = UIColor(named: "water")
            imageIcon.image = UIImage(named: "cancel")
            
        } else if titleDenun.text == "Vazamento" {
            
            denunciaView.backgroundColor = UIColor(named: "green")
            imageIcon.image = UIImage(named: "drop")
            
        } else if titleDenun.text == "Falta d'Água" {
            
            denunciaView.backgroundColor = UIColor(named: "purple")
            imageIcon.image = UIImage(named: "ink")
        } else {
            
            denunciaView.backgroundColor = UIColor(named: "redish")
            imageIcon.image = UIImage(named: "question")
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
        var address = "";
        locationManager.reverseGeocodeLocationWithCoordinates(location, onReverseGeocodingCompletionHandler: { (reverseGeocodeInfo, placemark, error) -> Void in
            
            if (!CLLocationManager.locationServicesEnabled()){
                print("----------> GPS INATIVO")
            }
            if (reverseGeocodeInfo == nil) {
                self.labelAddress.text = "Sinal de GPS não encontrado"
                self.nextPage.isUserInteractionEnabled = false
            } else {
                address = reverseGeocodeInfo?.object(forKey: "formattedAddress") as! String
                dao.denuncia.address = address
                self.labelAddress.text = dao.denuncia.address
            }
        })
    }
    
    private func locationManager(manager:CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        if status != CLAuthorizationStatus.notDetermined || status != CLAuthorizationStatus.denied || status != CLAuthorizationStatus.restricted{
            getLocation()
        }
        
    }
    
    // Keyboard Functions

    
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
        } else {
            dao.denuncia.obsUsuario = obsView.text
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*
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
     */
    /*
     @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
     obsView.resignFirstResponder()
     }
     */
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
