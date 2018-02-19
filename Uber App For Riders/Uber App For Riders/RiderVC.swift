//
//  RiderVC.swift
//  Uber App For Riders
//
//  Created by 真田雄太 on 2018/01/24.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import UIKit
import MapKit

class RiderVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate,UberController {

    
    @IBOutlet weak var myMap: MKMapView!
    private var locationManager = CLLocationManager();
    private var userLocation: CLLocationCoordinate2D?;
    private var driverLocation: CLLocationCoordinate2D?;
    
    private var timer = Timer();
    
    @IBOutlet weak var callUberBtn: UIButton!
    
    private var canCallUber = true;
    private var riderCancelledRequest = false;
    
    private var appStartedForTheFirstTime = true;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeLocationManager();
        UberHandler.Instance.observeMessagesForRider();
        UberHandler.Instance.delegate = self;
    }
    
    func initializeLocationManager() {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locationManager.location?.coordinate {
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            let region = MKCoordinateRegion(center: userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01));
            
            myMap.setRegion(region, animated: true);
            
            myMap.removeAnnotations(myMap.annotations);
            
            
            if driverLocation != nil {
                if !canCallUber {
                    let driverAnnotation = MKPointAnnotation();
                    driverAnnotation.coordinate = driverLocation!;
                    driverAnnotation.title = "Driver Location";
                    myMap.addAnnotation(driverAnnotation);
                }
            }
            
            let annotation = MKPointAnnotation();
            annotation.coordinate = userLocation!;
            annotation.title = "Riders Location";
            myMap.addAnnotation(annotation)
        }
    }
    
    @objc func updateRiderLocation() {
        UberHandler.Instance.updateRiderLocation(lat: userLocation!.latitude, long: userLocation!.longitude);
    }
    
    
    func canCallUber(delegateCalled: Bool) {
        if delegateCalled {
            callUberBtn.setTitle("Cancell Uber", for: UIControlState.normal);
            canCallUber = false;
        } else {
            callUberBtn.setTitle("Call Uber", for: UIControlState.normal);
            canCallUber = true;
        }
    }
    
    func driverAcceptedRequest(requestAccepted: Bool, driverName: String) {
        if !riderCancelledRequest {
            if requestAccepted {
                alertTheUser(title: "Uber Accepted", message: "\(driverName) Accepted Your Uber Request")
            } else {
                UberHandler.Instance.cancellUber();
                timer.invalidate();
                alertTheUser(title: "Uber Canceled", message: "\(driverName) Canceled Uber Request")
            }
        }
        riderCancelledRequest = false;
    }
    
    func updateDriversLocation(lat: Double, long: Double) {
        driverLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    
    @IBAction func callUber(_ sender: Any) {
        
        if userLocation != nil {
            UberHandler.Instance.requestUber(latitude: Double(userLocation!.latitude), longitude: Double(userLocation!.longitude))
            
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(10), target: self, selector: #selector(RiderVC.updateRiderLocation), userInfo: nil,repeats: true)
        } else {
            riderCancelledRequest = true;
            UberHandler.Instance.cancellUber();
            timer.invalidate();
        }
    }
    
    
    
    
    @IBAction func logout(_ sender: Any) {
        if AuthProvider.Instance.logOut() {
            if !canCallUber {
                UberHandler.Instance.cancellUber();
                timer.invalidate();
            }
            
             dismiss(animated: true, completion: nil)
            
        } else {
            alertTheUser(title: "Could Not Logout", message: "We could not logout at the moment, please try again later" );
        }
        
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    

}//class
