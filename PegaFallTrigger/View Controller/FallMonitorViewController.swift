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
    var switchView: UIView!
    
    var statusLabel: UILabel!
    var accelXaxisLabel: UILabel!
    var accelYaxisLabel: UILabel!
    var accelZaxisLabel: UILabel!
    var gyroXaxisLabel: UILabel!
    var gyroYaxisLabel: UILabel!
    var gyroZaxisLabel: UILabel!
    
    var switchFallButton: UISwitch!
    var sendInfoButton: UIButton!
    
    var isFalling: Bool = false
    var status = "Normal"
    var motionManager  = CMMotionManager()
    let locationManager = CLLocationManager()
    let fallModelController = FallModelController()
    
    
    var name: String?
    var model: String?
    var email: String?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
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
        accelContainerView.backgroundColor = .white
        stackView.addArrangedSubview(accelContainerView)
        
        gyroContainerView = UIView()
        gyroContainerView.backgroundColor = .white
        stackView.addArrangedSubview(gyroContainerView)
        
        let accelStackView = UIStackView()
        accelStackView.translatesAutoresizingMaskIntoConstraints = false
        accelStackView.axis = .vertical
        accelStackView.spacing = 20
        accelStackView.distribution = .fillEqually
        accelContainerView.addSubview(accelStackView)
        
        accelXaxisLabel = UILabel()
        accelXaxisLabel.translatesAutoresizingMaskIntoConstraints = false
        accelXaxisLabel.font = .systemFont(ofSize: 14)
        accelXaxisLabel.textAlignment = .center
        accelXaxisLabel.backgroundColor = Appearance.darkColor
        accelXaxisLabel.textColor = .white
        accelXaxisLabel.text = "Accel - X : 0.00"
        accelXaxisLabel.layer.masksToBounds = true
        accelXaxisLabel.layer.cornerRadius = 10
        accelStackView.addArrangedSubview(accelXaxisLabel)
        
        accelYaxisLabel = UILabel()
        accelYaxisLabel.font = .systemFont(ofSize: 14)
        accelYaxisLabel.textAlignment = .center
        accelYaxisLabel.backgroundColor = Appearance.darkColor
        accelYaxisLabel.textColor = .white
        accelYaxisLabel.text = "Accel - Y : 0.00"
        accelYaxisLabel.layer.masksToBounds = true
        accelYaxisLabel.layer.cornerRadius = 10
        accelStackView.addArrangedSubview(accelYaxisLabel)
        
        accelZaxisLabel = UILabel()
        accelZaxisLabel.font = .systemFont(ofSize: 14)
        accelZaxisLabel.textAlignment = .center
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
        gyroXaxisLabel.font = .systemFont(ofSize: 14)
        gyroXaxisLabel.textAlignment = .center
        gyroXaxisLabel.backgroundColor = Appearance.darkColor
        gyroXaxisLabel.textColor = .white
        gyroXaxisLabel.text = "Gyro - X : 0.00"
        gyroXaxisLabel.layer.masksToBounds = true
        gyroXaxisLabel.layer.cornerRadius = 10
        gyroStackView.addArrangedSubview(gyroXaxisLabel)
        
        gyroYaxisLabel = UILabel()
        gyroYaxisLabel.font = .systemFont(ofSize: 14)
        gyroYaxisLabel.textAlignment = .center
        gyroYaxisLabel.backgroundColor = Appearance.darkColor
        gyroYaxisLabel.textColor = .white
        gyroYaxisLabel.text = "Gyro - Y : 0.00"
        gyroYaxisLabel.layer.masksToBounds = true
        gyroYaxisLabel.layer.cornerRadius = 10
        gyroStackView.addArrangedSubview(gyroYaxisLabel)
        
        gyroZaxisLabel = UILabel()
        gyroZaxisLabel.font = .systemFont(ofSize: 14)
        gyroZaxisLabel.textAlignment = .center
        gyroZaxisLabel.backgroundColor = Appearance.darkColor
        gyroZaxisLabel.textColor = .white
        gyroZaxisLabel.text = "Gyro - Z : 0.00"
        gyroZaxisLabel.layer.masksToBounds = true
        gyroZaxisLabel.layer.cornerRadius = 10
        gyroStackView.addArrangedSubview(gyroZaxisLabel)
        
        switchView  = UIView()
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
        
        showButton()
        
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
            
            accelStackView.topAnchor.constraint(equalTo: accelContainerView.topAnchor),
            accelStackView.leadingAnchor.constraint(equalTo: accelContainerView.leadingAnchor),
            accelStackView.trailingAnchor.constraint(equalTo: accelContainerView.trailingAnchor),
            accelStackView.bottomAnchor.constraint(equalTo: accelContainerView.bottomAnchor),
        
            gyroStackView.topAnchor.constraint(equalTo: gyroContainerView.topAnchor),
            gyroStackView.leadingAnchor.constraint(equalTo: gyroContainerView.leadingAnchor),
            gyroStackView.trailingAnchor.constraint(equalTo: gyroContainerView.trailingAnchor),
            gyroStackView.bottomAnchor.constraint(equalTo: gyroContainerView.bottomAnchor),
            
        ])
        
    }
    
    // MARK: - Methods
    
    @objc func updateAccAndGyro() {
        let noticationCenter = UNUserNotificationCenter.current()
        
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
                                    
                                    self.status = "Fall"
                                    self.statusLabel.text = "Status : \(self.status)"
                                    self.showButton()
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
        let noticationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Fall Detected"
        content.body = "Comfirm if phone fell and is damaged?"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        noticationCenter.add(request)
    }
    
    func showButton() {
        
        let buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = .black
        buttonView.layer.cornerRadius = 33
        buttonView.clipsToBounds = true
        view.addSubview(buttonView)
        
        sendInfoButton = UIButton()
        sendInfoButton.translatesAutoresizingMaskIntoConstraints = false
        sendInfoButton.backgroundColor = Appearance.color
        sendInfoButton.layer.cornerRadius = 20
        sendInfoButton.setTitle("Send", for: .normal)
        sendInfoButton.titleLabel?.font = .systemFont(ofSize: 14)
        sendInfoButton.isEnabled = true
        sendInfoButton.addTarget(self, action: #selector(sendDataToServer), for: .touchUpInside)
        
        buttonView.addSubview(sendInfoButton)
        
        NSLayoutConstraint.activate([
            buttonView.heightAnchor.constraint(equalToConstant: 66),
            buttonView.widthAnchor.constraint(equalToConstant: 66),
            buttonView.topAnchor.constraint(equalTo: switchView.bottomAnchor, constant: 150),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            
            sendInfoButton.heightAnchor.constraint(equalToConstant: 44),
            sendInfoButton.widthAnchor.constraint(equalToConstant: 44),
            sendInfoButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            sendInfoButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor)
        ])
    }
    
    @objc func sendDataToServer() {
        
        guard let name = name,
        let model = model,
        let email = email else { return }
    
        let fallData =  FallData(deviceModel: model,
                                 deviceOwner: name,
                                 ownersEmail: email,
                                 latitude: latitude,
                                 longitude: longitude,
                                 indoor: false)
        
        
        fallModelController.sendFallDataToPega(fallData: fallData)
        
    }
    
    
    

}

extension FallMonitorViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                print("Default identifier")
            case "alert":
                print("Show more info")
                break
                
            default:
                break
            }
        }
        completionHandler()
    }
}

extension FallMonitorViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    latitude  = manager.location?.coordinate.latitude
                    longitude = manager.location?.coordinate.longitude
                }
            }
        }
    }
}
