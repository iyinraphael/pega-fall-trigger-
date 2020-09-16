//
//  FallMonitorViewController.swift
//  PegaFallTrigger
//
//  Created by Iyin Raphael on 9/15/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import UIKit

class FallMonitorViewController: UIViewController {

    // MARK: -  properties
    
    var accelContainerView: UIView!
    var gyroContainerView: UIView!
    var statusLabel: UILabel!

    var isFalling: Bool = false
    var status = "Normal"
    
    var lightColor = UIColor(red: 146/255, green: 190/255, blue: 178/255, alpha: 1)
    var darkColor = UIColor(red: 55/255, green: 96/255, blue: 86/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = "Status : \(status)"
        statusLabel.textColor = .white
        statusLabel.backgroundColor = darkColor
        statusLabel.layer.masksToBounds = true
        statusLabel.layer.cornerRadius = 20
        statusLabel.textAlignment = .center
        statusLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        view.addSubview(statusLabel)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20.0
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        accelContainerView = UIView()
        accelContainerView.backgroundColor = lightColor
        stackView.addArrangedSubview(accelContainerView)
        
        gyroContainerView = UIView()
        gyroContainerView.backgroundColor = lightColor
        stackView.addArrangedSubview(gyroContainerView)
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.widthAnchor.constraint(equalToConstant: 150),
            statusLabel.heightAnchor.constraint(equalToConstant: 44),
            
            stackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 300)
            
        ])
        
        
        
        
    }
    

}
