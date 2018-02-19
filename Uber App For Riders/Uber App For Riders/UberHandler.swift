//
//  UberHandler.swift
//  Uber App For Riders
//
//  Created by 真田雄太 on 2018/01/28.
//  Copyright © 2018年 yutaSanada. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol UberController: class {
    func canCallUber(delegateCalled: Bool);
    func driverAcceptedRequest(requestAccepted: Bool, driverName: String);
    func updateDriversLocation(lat: Double, long: Double);
}

class UberHandler {
    private static let _instance = UberHandler();
    
    weak var delegate: UberController?;
    
    var rider = "";
    var driver = "";
    var rider_id = "";
    
    
    static var Instance: UberHandler {
        return _instance;
    }
    
    func observeMessagesForRider() {
        //Rider Requested Uber
        DBProvider.Instance.requestRef.observe(DataEventType .childAdded) {(snapshot: DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let name = data[Constants.NAME] as? String {
                    if name == self.rider {
                        self.rider_id = snapshot.key;
                        self.delegate?.canCallUber(delegateCalled: true);
                    }
                }
            }
        }
        //Rider Cancelled Uber
        DBProvider.Instance.requestRef.observe(DataEventType .childRemoved){(snapshot: DataSnapshot)in
            if let data = snapshot.value as? NSDictionary {
                if let name = data[Constants.NAME] as? String {
                    if name == self.rider {
                        self.delegate?.canCallUber(delegateCalled: false);
                    }
                }
            }
        }
        
        //Driver accepted Uber
        DBProvider.Instance.requestAcceptRef.observe(DataEventType.childAdded) {(snapshot: DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let name = data[Constants.NAME] as? String {
                    if self.driver == "" {
                        self.driver = name;
                        self.delegate?.driverAcceptedRequest(requestAccepted: true, driverName: self.driver);
                    }
                }
                    
            }
        }
        
        //
        DBProvider.Instance.requestAcceptRef.observe(DataEventType .childRemoved){(snapshot: DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let name = data[Constants.NAME] as? String {
                    if name == self.driver {
                        self.driver = "";
                        self.delegate?.driverAcceptedRequest(requestAccepted: true, driverName: name);
                    }
                }
            }
        }
        
        //Driver updating location
        DBProvider.Instance.requestAcceptRef.observe(DataEventType .childChanged) {(snapshot: DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                if let name = data[Constants.NAME] as? String {
                    if name == self.driver {
                        if let lat = data[Constants.LATITUDE] as? Double {
                            if let long = data[Constants.LONGITUDE] as? Double {
                                self.delegate?.updateDriversLocation(lat: lat, long: long);
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func requestUber(latitude: Double, longitude: Double){
        let data: Dictionary<String, Any> = [
            Constants.NAME: rider,
            Constants.LATITUDE: latitude,
            Constants.LONGITUDE: longitude
        ];
        
        DBProvider.Instance.requestRef.childByAutoId().setValue(data);
    
    }//request uber
    
    
    func cancellUber() {
        DBProvider.Instance.requestRef.child(rider_id).removeValue();
    }
    
    func updateRiderLocation(lat: Double, long: Double) {
        DBProvider.Instance.requestRef.child(rider_id).updateChildValues([Constants.LATITUDE: lat, Constants.LONGITUDE: long]);
    }
}





























