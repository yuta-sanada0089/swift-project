//
//  UberHandler.swift
//  Uber App For Driver
//
//  Created by 真田雄太 on 2018/01/29.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol UberController: class {
    func acceptUber(lat: Double, long: Double);
    func riderCanceledUber();
    func uberCanceled();
    func updateRiderLocation(lat: Double, long: Double);
    
}// protocol

class UberHandler {
    private static let _instance = UberHandler();
    
    weak var delegate: UberController?;
    
    var rider = "";
    var driver = "";
    var driver_id = "";
    
    
    static var Instance: UberHandler {
        return _instance;
    }
    
    func observeMessagesForDriver() {
        //Rider REQUESTED An Uber
        DBProvider.Instance.requestRef.observe(DataEventType.childAdded) {
            (snapshot: DataSnapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                if let latitude = data[Constants.LATITUDE] as? Double {
                    if let longitude = data[Constants.LONGITUDE] as? Double {
                        //inform the driver VC
                        self.delegate?.acceptUber(lat: latitude, long: longitude);
                    }
                }
                
                if let name = data[Constants.NAME] as? String {
                    self.rider = name;
                }
            }
            //Rider canceled Uber
            DBProvider.Instance.requestRef.observe(DataEventType.childRemoved, with: {(snapshot: DataSnapshot) in
               
                if let data = snapshot.value as? NSDictionary {
                    if let name = data[Constants.NAME] as? String {
                        if name == self.rider {
                            self.rider = "";
                            self.delegate?.riderCanceledUber();
                        }
                    }
                }
                
            });
        }
        
        //Rider Updating Location
        DBProvider.Instance.requestRef.observe(DataEventType.childChanged) {(snapshot: DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let lat = data[Constants.LATITUDE] as? Double {
                    if let long = data[Constants.LONGITUDE] as? Double {
                        self.delegate?.updateRiderLocation(lat: lat, long: long);
                    }
                }
            }
        }
        
        
        //Driver accepts uber
        DBProvider.Instance.requestAcceptedRef.observe(DataEventType .childAdded){(snapshot: DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let name = [Constants.NAME] as? String {
                    if name == self.driver {
                        self.driver_id = snapshot.key;
                    }
                }
            }
        }
        
        //Driver canceled uber
        DBProvider.Instance.requestAcceptedRef.observe(DataEventType .childRemoved) {(snapshot: DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let name = [Constants.NAME] as? String {
                    if name == self.driver {
                        self.delegate?.uberCanceled();
                    }
                }
            }
        }
        
    }//observeMessageForDriver
    
    func uberAccepted(lat: Double, long: Double) {
        let data: Dictionary<String, Any> = [Constants.NAME: driver, Constants.LATITUDE: lat, Constants.LONGITUDE: long];
        DBProvider.Instance.requestAcceptedRef.childByAutoId().setValue(data);
    }
    
    func cancelUberForDriver() {
        DBProvider.Instance.requestRef.child(driver_id).removeValue();
    }
    
    func updateDriverLocation(lat: Double, long: Double) {
        DBProvider.Instance.requestRef.child(driver_id).updateChildValues([Constants.LATITUDE: lat, Constants.LONGITUDE: long]);
    }
    
}//class
