//
//  FallMonitorViewController.swift
//  PegaFallTrigger
//
//  Created by Iyin Raphael on 9/15/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

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
        accelXaxisLabel.text = "Accel - X : 0.00"
        accelXaxisLabel.layer.masksToBounds = true
        accelXaxisLabel.layer.cornerRadius = 10
        accelStackView.addArrangedSubview(accelXaxisLabel)
        
        accelYaxisLabel = UILabel()
        accelYaxisLabel.adjustsFontSizeToFitWidth = true
        accelYaxisLabel.backgroundColor = Appearance.darkColor
        accelYaxisLabel.text = "Accel - Y : 0.00"
        accelYaxisLabel.layer.masksToBounds = true
        accelYaxisLabel.layer.cornerRadius = 10
        accelStackView.addArrangedSubview(accelYaxisLabel)
        
        accelZaxisLabel = UILabel()
        accelZaxisLabel.adjustsFontSizeToFitWidth = true
        accelZaxisLabel.backgroundColor = Appearance.darkColor
        accelZaxisLabel.text = "Accel - Z : 0.00"
        accelZaxisLabel.layer.masksToBounds = true
        accelZaxisLabel.layer.cornerRadius = 10
        accelStackView.addArrangedSubview(accelZaxisLabel)
        
        let switchView  = UIView()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.backgroundColor = Appearance.lightColor
        switchView.layer.cornerRadius = 10
        view.addSubview(switchView)
        
        switchFallButton =  UISwitch()
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
            accelStackView.topAnchor.constraint(equalTo: accelContainerView.topAnchor, constant: 10)
            
        ])
        
        
        
        
    }
    
    // MARK: - Methods
    
    func updateAccAndGyro() {
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
            
            
        }
    }
    

}
