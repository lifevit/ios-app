//
//  AOJThermometerViewController.swift
//  LifevitSDKSample
//
//  Created by Marc on 8/8/24.
//  Copyright © 2024 Lifevit. All rights reserved.
//

import UIKit
import LifevitSPM

class AOJThermometerViewController: UIViewController {

    @IBOutlet weak private var statusLabel: UILabel!
    @IBOutlet weak private var infoLabel: UILabel!
    @IBOutlet weak private var valueLabel: UILabel!
    @IBOutlet weak private var modeImageView: UIImageView!
    
    let manager = AOJManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        manager.delegate = self
        manager.scanConnectAndRetrieveData()
        
        DispatchQueue.main.async {
            self.statusLabel.text = "Connecting..."
            self.infoLabel.text = ""
        }
    }
    
    @IBAction func onUpdateInfo(_ sender: UIButton) {
        manager.retrieveDeviceInfo()
    }
    
    
    @IBAction func onRetrieveLastMeasure(_ sender: UIButton) {
        manager.retrieveLastMeasure()
    }
}


extension AOJThermometerViewController: AOJDelegate {
    func onDeviceInfo(deviceInfo: AOJDeviceInfo) {
        DispatchQueue.main.async {
            self.statusLabel.text = "Connected ✅"
            self.infoLabel.text = "Battery: \(deviceInfo.battery ?? "-")\nSoftware: \(deviceInfo.version ?? "-")"
        }
    }
    
    func onDataReceived(data: AOJData) {
        DispatchQueue.main.async {
            self.valueLabel.text = data.value ?? "-º"
            
            switch data.mode ?? .AdultForehead {
            case .AdultForehead:
                self.modeImageView.image = UIImage(systemName: "person.circle")
            
            case .ChildrenForehead:
                self.modeImageView.image = UIImage(systemName: "stroller")
                
            case .Ear:
                self.modeImageView.image = UIImage(systemName: "ear")
                
            case .Object:
                self.modeImageView.image = UIImage(systemName: "house.circle")
            }
        }
    }
}
