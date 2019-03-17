//
//  ViewController.swift
//  BlindCall
//
//  Created by Nadith Dharmasena on 3/16/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var backgroundContainer:UIView!
    var centeringContainer:UIView!
    var logoImage:CustomImage!
    var appNameLabel:UILabel!
    var emailInput: UITextField!
    var passwordInput: UITextField!
    var emailInputLabel:UILabel!
    var passwordInputLabel:UILabel!
    var submitButton:UIView!
    var submitLabel:UILabel!
    var registerButton:UIView!
    var registerLabel:UILabel!
//    var registerButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        
        backgroundContainer = UIView()
        backgroundContainer.frame = CGRect(x: 0, y: 0, width: Globals.screenDimen.width, height: Globals.screenDimen.height)
        backgroundContainer.backgroundColor = UIColor.init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        
        centeringContainer = UIView()
        
        let logoImageDimen = Globals.screenDimen.width * 0.36
        logoImage = CustomImage(image_name: "pokerchipmini", width: logoImageDimen, height: logoImageDimen)
        logoImage.frame = CGRect(x: 0, y: 0, width: logoImageDimen, height: logoImageDimen)
        logoImage.center.x = Globals.screenDimen.width / 2
        logoImage.backgroundColor = UIColor.clear
        
        centeringContainer.addSubview(logoImage)
        
        appNameLabel = UILabel()
        appNameLabel.frame = CGRect(x: 0, y: logoImage.frame.maxY + 20, width: 0, height: 0)
        appNameLabel.textColor = UIColor.white
        appNameLabel.text = "Blind Call"
        appNameLabel.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.bold)
        appNameLabel.sizeToFit()
        appNameLabel.center.x = backgroundContainer.center.x
        
        centeringContainer.addSubview(appNameLabel)
        
        emailInput = UITextField()
        emailInput.frame = CGRect(x: 0, y: appNameLabel.frame.maxY + 20, width: Globals.screenDimen.width * 0.75, height: 50)
        emailInput.keyboardType = .emailAddress
        addBottomBorder(whichView: emailInput)
        addPadding(whichTextField: emailInput)
        addTextFieldOptions(whichTextField: emailInput)
        
        centeringContainer.addSubview(emailInput)
        
        emailInputLabel = UILabel()
        emailInputLabel.frame = CGRect(x: 0, y: emailInput.frame.maxY + 5, width: 0, height: 0)
        emailInputLabel.text = "Email Address"
        addInputLabelOptions(whichInputLabel: emailInputLabel)
        
        centeringContainer.addSubview(emailInputLabel)
        
        passwordInput = UITextField()
        passwordInput.frame = CGRect(x: 0, y: emailInputLabel.frame.maxY + 30, width: Globals.screenDimen.width * 0.75, height: 50)
        passwordInput.isSecureTextEntry = true
        addBottomBorder(whichView: passwordInput)
        addPadding(whichTextField: passwordInput)
        addTextFieldOptions(whichTextField: passwordInput)
        
        centeringContainer.addSubview(passwordInput)
        
        passwordInputLabel = UILabel()
        passwordInputLabel.frame = CGRect(x: 0, y: passwordInput.frame.maxY + 5, width: 0, height: 0)
        passwordInputLabel.text = "Password"
        addInputLabelOptions(whichInputLabel: passwordInputLabel)
        
        centeringContainer.addSubview(passwordInputLabel)
        
        submitButton = UIView()
        submitButton.frame = CGRect(x: 0, y: passwordInputLabel.frame.maxY + 30, width: Globals.screenDimen.width * 0.75, height: 50)
        submitButton.backgroundColor = UIColor.red
        submitButton.layer.cornerRadius = 25
        submitButton.center.x = backgroundContainer.center.x
        
        submitLabel = UILabel()
        submitLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        submitLabel.textColor = UIColor.white
        submitLabel.text = "Login"
        submitLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        submitLabel.sizeToFit()
        submitLabel.center.x = submitButton.frame.width / 2
        submitLabel.center.y = submitButton.frame.height / 2
        
        submitButton.addSubview(submitLabel)
        centeringContainer.addSubview(submitButton)
        
        registerLabel = UILabel()
        registerLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        registerLabel.text = "Register"
        registerLabel.textColor = UIColor.white
        registerLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        registerLabel.sizeToFit()

        registerButton = UIView()
        registerButton.frame = CGRect(x: 0, y: submitButton.frame.maxY + 10, width: registerLabel.frame.maxX, height: registerLabel.frame.maxY)
        registerButton.center.x = backgroundContainer.center.x

        registerButton.addSubview(registerLabel)
        centeringContainer.addSubview(registerButton)

        let submitTapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleSubmit))
        submitButton.addGestureRecognizer(submitTapGesture)
        
        let registerTapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleRegister))
        registerButton.addGestureRecognizer(registerTapGesture)
        
        let anywhereTapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleAnywhereTapped))
        backgroundContainer.addGestureRecognizer(anywhereTapGesture)
        
        centeringContainer.frame = CGRect(x: 0, y: 0, width: Globals.screenDimen.width, height: registerButton.frame.maxY)
        centeringContainer.center.y = Globals.screenDimen.height / 2 - Globals.screenDimen.height / 16
        backgroundContainer.addSubview(centeringContainer)
        
        self.view.addSubview(backgroundContainer)
        
    }
    

}


// Handle events
extension ViewController {
    
    @objc func handleSubmit (sender: UITapGestureRecognizer) {
        
        let email = emailInput.text!
        let password = passwordInput.text!
        
        if email != "" && password != "" {
            
            if Globals.validateEmail(enteredEmail: email) {
                
                let myParams: [String: Any] = [
                    "email": email,
                    "password": password
                ]
                
                Alamofire.request(Globals.serverURL + "/login", method: .post, parameters: myParams, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                    
                    if let responseObj = response.result.value {
                        
                        let responseDictionary = responseObj as! Dictionary<String, Any>
                        let status = responseDictionary["status"] as! Int
                        
                        if status == 100 {
                            
                            // good
                            
                        } else if status == 155 {
                            
                            
                            
                        }
                        
                        
                    }
                    
                }
                
            } else {
                emailInputLabel.text = "Invalid email address."
                emailInputLabel.sizeToFit()
                emailInputLabel.textColor = UIColor.red
                emailInputLabel.center.x = backgroundContainer.center.x
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.emailInputLabel.text = "Email Address"
                    self.emailInputLabel.textColor = UIColor.white
                    self.emailInputLabel.sizeToFit()
                    self.emailInputLabel.center.x = self.backgroundContainer.center.x
                }
                
            }
            
            
        }
        
    }
    
    @objc func handleAnywhereTapped (sender: UITapGestureRecognizer) {
        emailInput.resignFirstResponder()
        passwordInput.resignFirstResponder()
    }
    
    @objc func handleRegister (sender:UITapGestureRecognizer) {
        
        let registerViewController = RegisterViewController()
        registerViewController.modalTransitionStyle = .coverVertical
        
        self.present(registerViewController, animated: true)
    }
    
}

// Text Field Label Customizations
extension ViewController {
    
    func addInputLabelOptions (whichInputLabel: UILabel) {
        whichInputLabel.textColor = UIColor.white
        whichInputLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        whichInputLabel.sizeToFit()
        whichInputLabel.center.x = backgroundContainer.center.x
    }
    
}

// Text Field Customizations
extension ViewController {
    
    func addBottomBorder (whichView: UIView) {
        
        let bottomBorder:CALayer = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: whichView.frame.height - 1, width: whichView.frame.width, height: 1)
        bottomBorder.backgroundColor = UIColor.white.cgColor
        
        whichView.layer.addSublayer(bottomBorder)
        
    }
    
    func addPadding (whichTextField: UITextField) {
        
        let paddingLeftPwd = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 5))
        whichTextField.leftViewMode = .always
        whichTextField.leftView = paddingLeftPwd
        
        let paddingRightPwd = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 5))
        whichTextField.rightViewMode = .always
        whichTextField.rightView = paddingRightPwd
        
    }
    
    func addTextFieldOptions (whichTextField: UITextField) {
        
        whichTextField.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        whichTextField.textColor = UIColor.white
        whichTextField.backgroundColor = UIColor.clear
        whichTextField.center.x = backgroundContainer.center.x
        
        whichTextField.textAlignment = .center
        whichTextField.autocorrectionType = .no
        whichTextField.autocapitalizationType = .none
        whichTextField.spellCheckingType = .no
        whichTextField.keyboardAppearance = .dark
        
    }
    
}
