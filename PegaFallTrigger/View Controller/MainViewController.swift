//
//  MainViewController.swift
//  PegaFallTrigger
//
//  Created by Iyin Raphael on 9/14/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class MainViewController: UIViewController {

    // MARK: - Properties
    
    var deviceModelTextField: UITextField!
    var ownersEmailTextField: UITextField!
    var nameTextField: UITextField!
    
    var deviceOwnerLabel: UILabel!
    var ownersEmailLabel: UILabel!
    
    let color = UIColor(red: 100.0/255.0 , green: 144.0/255.0, blue: 138.0/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Fall Trigger"
        
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        let detailsLabel = UILabel()
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.adjustsFontSizeToFitWidth = true
        let attribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        detailsLabel.attributedText = NSAttributedString(string: "Enter phone details", attributes: attribute)
        view.addSubview(detailsLabel)
        
        
        let mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 10
        view.addSubview(mainStackView)
        
        let deviceOwnerStackView = UIStackView()
        deviceOwnerStackView.axis = .vertical
        deviceOwnerStackView.distribution = .fill
        deviceOwnerStackView.alignment = .fill
        deviceOwnerStackView.spacing = 5.0
        mainStackView.addArrangedSubview(deviceOwnerStackView)
        
        let nameLabel = UILabel()
        nameLabel.text = "Name :"
        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        deviceOwnerStackView.addArrangedSubview(nameLabel)
        
        nameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 15))
        nameTextField.layer.borderWidth = 0.2
        nameTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        deviceOwnerStackView.addArrangedSubview(nameTextField)
        
        let ownersEmailStackView = UIStackView()
        ownersEmailStackView.axis = .vertical
        ownersEmailStackView.distribution = .fill
        ownersEmailStackView.alignment = .fill
        ownersEmailStackView.spacing = 5.0
        mainStackView.addArrangedSubview(ownersEmailStackView)
        
        let emailLabel = UILabel()
        emailLabel.text = "Email :"
        emailLabel.font = .systemFont(ofSize: 14)
        emailLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        ownersEmailStackView.addArrangedSubview(emailLabel)
        
        ownersEmailTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 15))
        ownersEmailTextField.layer.borderWidth = 0.2
        ownersEmailTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        ownersEmailStackView.addArrangedSubview(ownersEmailTextField)

        
        let deviceModelStackView = UIStackView()
        deviceModelStackView.axis = .vertical
        deviceModelStackView.distribution = .fill
        deviceModelStackView.alignment = .fill
        deviceModelStackView.spacing = 5.0
        mainStackView.addArrangedSubview(deviceModelStackView)
        
        let deviceModelLabel = UILabel()
        deviceModelLabel.text = "Device :"
        deviceModelLabel.font = .systemFont(ofSize: 14)
        deviceModelLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        deviceModelStackView.addArrangedSubview(deviceModelLabel)
        
        deviceModelTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 15))
        deviceModelTextField.layer.borderWidth = 0.2
        deviceModelTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        deviceModelStackView.addArrangedSubview(deviceModelTextField)
        
        let submitButton = UIButton()
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.backgroundColor = color
        submitButton.layer.cornerRadius = 20
        submitButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        let attibute = [NSAttributedString.Key.foregroundColor: UIColor.black,
                        NSAttributedString.Key.backgroundColor: color]
        let attributedString = NSAttributedString(string: "Get started!", attributes: attibute)
        submitButton.setAttributedTitle(attributedString, for: .normal)
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 200),
            detailsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 220),
            mainStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            submitButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            submitButton.widthAnchor.constraint(equalToConstant: 150)


        ])
        
    }
    
    
    // MARK: Methods
    
    @objc func saveData() {
        
        guard let name  = nameTextField.text,
            let model = deviceModelTextField.text,
            let email = ownersEmailTextField.text else { return }
        
        let strData = "\(name), \(model), \(email)"
        
        
        let fm = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        let path = fm[0]
        let fileName = path.appendingPathComponent("data.txt")
        
        do {
            try strData.write(to: fileName, atomically: true, encoding: .utf8)
            let input = try String(contentsOf: fileName)
            print(input)
        } catch {
            print(error.localizedDescription)
        }
        
        let vc = FallMonitorViewController()
        present(vc, animated: true)
      
    }
    
    
}

extension MainViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        deviceModelTextField.resignFirstResponder()
    }
}
