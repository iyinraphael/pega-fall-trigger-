//
//  FallMonitorViewController.swift
//  PegaFallTrigger
//
//  Created by Iyin Raphael on 9/15/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion
import CoreLocation

class FallMonitorViewController: UIViewController {

    // MARK: -  properties
    
    var accelContainerView: UIView!
    var gyroContainerView: UIView!
    var statusLabel: UILabel!
    var accelXaxisLabel: UILabel!
    var accelYaxisLabel: UILabel!
    var accelZaxisLabel: UILabel!
    var gyroXaxisLabel: UILabel!
    var gyroYaxisLabel: UILabel!
    var gyroZaxisLabel: UILabel!
    var switchFallButton: UISwitch!

    var isFalling: Bool = false
    var status = "Normal"
    var motionManager  = CMMotionManager()
    let locationManager = CLLocationManager()
    let noticationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = "Status : \(status)"
        statusLabel.textColor = .white
        statusLabel.backgroundColor = Appearance.darkColor
        statusLabel.layer.masksToBounds = true
        statusLabel.layer.cornerRadius = 10
        statusLabel.textAlignment = .center
        statusLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        view.addSubview(statusLabel)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
    
        accelContainerView = UIView()
        accelContainerView.backgroundColor = Appearance.color
        stackView.addArrangedSubview(accelContainerView)
        
        gyroContainerView = UIView()
        gyroContainerView.backgroundColor = Appearance.color
        stackView.addArrangedSubview(gyroContainerView)
        
        let accelStackView = UIStackView()
        accelStackView.translatesAutoresizingMaskIntoConstraints = false
        accelStackView.axis = .vertical
        accelStackView.spacing = 20
        accelStackView.distribution = .fillEqually
        accelContainerView.addSubview(accelStackView)
        
        accelXaxisLabel = UILabel()
        accelXaxisLabel.adjustsFontSizeToFitWidth = true
        accelXaxisLabel.backgroundColor = Appearance.darkColor
        accelXaxisLabel.textColor = .white
        accelXaxisLabel.text = "Accel - X : 0.00"
        accelXaxisLabel.layer.masksToBounds = true
        accelXaxisLabel.layer.cornerRadius = 10
        accelStackView.addArrangedSubview(accelXaxisLabel)
        
        accelYaxisLabel = UILabel()
        accelYaxisLabel.adjustsFontSizeToFitWidth = true
        accelYaxisLabel.backgroundColor = Appearance.darkColor
        accelYaxisLabel.textColor = .white
        accelYaxisLabel.text = "Accel - Y : 0.00"
        accelYaxisLabel.layer.masksToBounds = true
        accelYaxisLabel.layer.cornerRadius = 10
        accelStackView.addArrangedSubview(accelYaxisLabel)
        
        accelZaxisLabel = UILabel()
        accelZaxisLabel.adjustsFontSizeToFitWidth = true
        accelZaxisLabel.backgroundColor = Appearance.darkColor
        accelZaxisLabel.textColor = .white
        accelZaxisLabel.text = "Accel - Z : 0.00"
        accelZaxisLabel.layer.masksToBounds = true
        accelZaxisLabel.layer.cornerRadius = 10
        accelStackView.addArrangedSubview(accelZaxisLabel)
        
        
        let gyroStackView = UIStackView()
        gyroStackView.translatesAutoresizingMaskIntoConstraints = false
        gyroStackView.axis = .vertical
        gyroStackView.spacing = 20
        gyroStackView.distribution = .fillEqually
        gyroContainerView.addSubview(gyroStackView)
        
        gyroXaxisLabel = UILabel()
        gyroXaxisLabel.adjustsFontSizeToFitWidth = true
        gyroXaxisLabel.backgroundColor = Appearance.darkColor
        gyroXaxisLabel.textColor = .white
        gyroXaxisLabel.text = "Gyro - X : 0.00"
        gyroXaxisLabel.layer.masksToBounds = true
        gyroXaxisLabel.layer.cornerRadius = 10
        gyroStackView.addArrangedSubview(gyroXaxisLabel)
        
        gyroYaxisLabel = UILabel()
        gyroYaxisLabel.adjustsFontSizeToFitWidth = true
        gyroYaxisLabel.backgroundColor = Appearance.darkColor
        gyroYaxisLabel.textColor = .white
        gyroYaxisLabel.text = "Gyro - Y : 0.00"
        gyroYaxisLabel.layer.masksToBounds = true
        gyroYaxisLabel.layer.cornerRadius = 10
        gyroStackView.addArrangedSubview(gyroYaxisLabel)
        
        gyroZaxisLabel = UILabel()
        gyroZaxisLabel.adjustsFontSizeToFitWidth = true
        gyroZaxisLabel.backgroundColor = Appearance.darkColor
        gyroZaxisLabel.textColor = .white
        gyroZaxisLabel.text = "Gyro - Z : 0.00"
        gyroZaxisLabel.layer.masksToBounds = true
        gyroZaxisLabel.layer.cornerRadius = 10
        gyroStackView.addArrangedSubview(gyroZaxisLabel)
        
        let switchView  = UIView()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.backgroundColor = Appearance.lightColor
        switchView.layer.cornerRadius = 10
        view.addSubview(switchView)
        
        switchFallButton =  UISwitch()
        switchFallButton.isOn = false
        switchFallButton.addTarget(self, action: #selector(updateAccAndGyro), for: .valueChanged)
        switchFallButton.translatesAutoresizingMaskIntoConstraints = false
        switchFallButton.thumbTintColor = .black
        switchFallButton.onTintColor = Appearance.color
        switchView.addSubview(switchFallButton)
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.widthAnchor.constraint(equalToConstant: 150),
            statusLabel.heightAnchor.constraint(equalToConstant: 44),
            
            stackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 300),
            
            switchView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            switchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            switchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            switchView.heightAnchor.constraint(equalToConstant: 50),
            
            switchFallButton.topAnchor.constraint(equalTo: switchView.topAnchor, constant: 10),
            switchFallButton.centerXAnchor.constraint(equalTo: switchView.centerXAnchor),
            
            accelStackView.centerXAnchor.constraint(equalTo: accelContainerView.centerXAnchor),
            accelStackView.topAnchor.constraint(equalTo: accelContainerView.topAnchor, constant: 10),
            accelStackView.centerYAnchor.constraint(equalTo: accelContainerView.centerYAnchor),
            
            gyroStackView.centerXAnchor.constraint(equalTo: gyroContainerView.centerXAnchor),
            gyroStackView.topAnchor.constraint(equalTo: gyroContainerView.topAnchor, constant: 10),
            gyroStackView.centerYAnchor.constraint(equalTo: gyroContainerView.centerYAnchor)
            
        ])
        
    }
    
    // MARK: - Methods
    
    @objc func updateAccAndGyro() {
        
        if switchFallButton.isOn == true {
            
            noticationCenter.requestAuthorization(options: [.sound, .badge, .badge]) { granted, error in
                if granted {
                    
                    if self.motionManager.isAccelerometerAvailable {
                        self.motionManager.startAccelerometerUpdates(to: .main) { data, error in
                            if let data = data {
                                self.accelXaxisLabel.text = "Accel - X : \(String(format: "%.2f", data.acceleration.x))"
                                self.accelYaxisLabel.text = "Accel - Y : \(String(format: "%.2f", data.acceleration.y))"
                                self.accelZaxisLabel.text = "Accel - Z : \(String(format: "%.2f", data.acceleration.z))"
                                
                                if (abs(data.acceleration.x) + abs(data.acceleration.y) + abs(data.acceleration.z)) >= 2.25 {
                                    self.alertUserOfFall()
                                    
                                    self.motionManager.stopAccelerometerUpdates()
                                    self.motionManager.stopGyroUpdates()
                                }
                            }
                            
                        }
                    }
        
                }
                
    
            }
            
            motionManager.startGyroUpdates(to: OperationQueue.current!) { data, error in
                if let data = data {
                    self.gyroXaxisLabel.text = "Gyro - X : \(String(format: "%.2f", data.rotationRate.x))"
                    self.gyroYaxisLabel.text = "Gyro - Y : \(String(format: "%.2f", data.rotationRate.y))"
                    self.gyroZaxisLabel.text = "Gyro - Z : \(String(format: "%.2f", data.rotationRate.z))"
                }
            }
        }
    
    }
    
    func alertUserOfFall() {
        noticationCenter.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Fall Detected", options: .foreground)
        let category = UNNotificationCategory(identifier: "alert", actions: [show], intentIdentifiers: [])
        
        noticationCenter.setNotificationCategories([category])
        
    }
    

}

