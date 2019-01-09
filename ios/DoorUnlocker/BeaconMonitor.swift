//
//  BeaconMonitor.swift
//  DoorUnlocker
//
//  Created by Andrew Bartow on 1/8/19.
//  Copyright © 2019 Andrew Bartow. All rights reserved.
//

import Foundation
import CoreLocation

protocol BeaconMonitorDelegate {
    func onNearBeacon()
}

class BeaconMonitor: NSObject, CLLocationManagerDelegate {
    let locationManager: CLLocationManager
    var delegate: BeaconMonitorDelegate?
    let kRegionID : String = "Lock"
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        locationManager.requestAlwaysAuthorization()
        
        // Based on:
        // https://developer.apple.com/documentation/corelocation/determining_the_proximity_to_an_ibeacon
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            // Match all beacons with the specified UUID
            let proximityUUID = UUID(uuidString: "426C7565-4368-6172-6D42-6561636F6E73")
            
            let region = CLBeaconRegion(proximityUUID: proximityUUID!,
                                        identifier: kRegionID)
            self.locationManager.startMonitoring(for: region)
            
            print("Initialized region monitoring")
        }
        
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered region \(region)")
        if (region.identifier == kRegionID) {
            delegate?.onNearBeacon()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exiting region \(region)")
    }
}
