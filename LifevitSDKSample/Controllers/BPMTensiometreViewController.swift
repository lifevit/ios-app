//
//  BPMTensiometreViewController.swift
//  LifevitSDKSample
//
//  Created by Marc on 31/7/24.
//  Copyright © 2024 Lifevit. All rights reserved.
//

import UIKit
import LifevitSPM
import LSBluetoothPlugin

class BPMTensiometreViewController: UIViewController {
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDiastolic: UILabel!
    @IBOutlet weak var lblSystolic: UILabel!
    @IBOutlet weak var lblPulse: UILabel!
    @IBOutlet weak var lblUUID: UILabel!
    
    let bpmManager = BPMManager()
    var bpmDevice: LSDeviceInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bpmManager.delegate = self
    }
    
    
    @IBAction func onConnect(_ sender: UIButton) {
        bpmManager.scanConnectAndRetrieveData()
    }
    
    @IBAction func onStartMeasurement(_ sender: UIButton) {
        guard let device = bpmDevice else { return }
        
        bpmManager.connectAndRetrieveData(for: device)
    }
    
    
    @IBAction func onConnectByMac(_ sender: UIButton) {
        guard let macAddress = bpmDevice?.macAddress, !macAddress.isEmpty else { return }

        bpmManager.connectAndRetrieveData(withMacAddress: macAddress)
    }
}

extension BPMTensiometreViewController: BPMDelegate {
    func onDeviceInfo(deviceInfo: LSDeviceInfo) {
        bpmDevice = deviceInfo
        DispatchQueue.main.async {
            self.lblUUID.text = deviceInfo.macAddress ?? ""
        }
    }
    
    func onStatusChanged(state: LSConnectState, description: String) {
        DispatchQueue.main.async {
            self.lblStatus.text = description
        }
    }
    
    func onDataReceived(data: LSBloodPressure) {
        DispatchQueue.main.async {
            self.lblSystolic.text = "\(data.systolic)"
            self.lblDiastolic.text = "\(data.diastolic)"
            self.lblPulse.text = "\(data.pluseRate)"
        }
    }
}
