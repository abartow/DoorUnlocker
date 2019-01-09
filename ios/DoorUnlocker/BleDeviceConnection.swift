//
//  BleDeviceConnection.swift
//  DoorUnlocker
//
//  Created by Andrew Bartow on 1/8/19.
//  Copyright © 2019 Andrew Bartow. All rights reserved.
//

import Foundation
import CoreBluetooth
import CoreLocation

class BleDeviceConnection: NSObject, CBCentralManagerDelegate {
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case CBManagerState.unauthorized:
            print("This app is not authorised to use Bluetooth low energy")
        case CBManagerState.poweredOff:
            print("Bluetooth is currently powered off.")
        case CBManagerState.poweredOn:
            print("Bluetooth is currently powered on and available to use.")
        default:
            break
        }
    }
}
