//
//  PartyViewController.swift
//  BlindCall
//
//  Created by Aaron Zhou on 3/17/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class PartyViewController: UIViewController, UITableViewDataSource {
    
    var backgroundContainer:UIView!
    var logoImage:CustomImage!
    var inviteButton:UIButton!
    var backButton:UIButton!
    var inviteTextField:UITextField!
    var timer = Timer()
    var tableView:UITableView!
    var userDictionary:Array<Dictionary<String, Any>> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO actually get the length for the timer
        // TODO actually get a dictionary
        // userDictionary = [["username":"Aaron", "ingame":true], ["username":"Nadith", "ingame":true], ["username":"Doug", "ingame":true], ["username":"Raj", "ingame":false], ["Ivan":"Aaron", "ingame":false]]
        
        let notch = UIScreen.main.nativeBounds.height > 2300 || UIScreen.main.nativeBounds.height == 1792 ? true : false;
        let topPadding:CGFloat = notch ? 44 : 0
        
        backgroundContainer = UIView()
        backgroundContainer.frame = CGRect(x: 0, y: 0, width: Globals.screenDimen.width, height: Globals.screenDimen.height)
        backgroundContainer.backgroundColor = UIColor.init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        
        let logoImageDimen = Globals.screenDimen.width * 0.36
        logoImage = CustomImage(image_name: "pokerchipmini", width: logoImageDimen, height: logoImageDimen)
        logoImage.frame = CGRect(x: 0, y: topPadding, width: logoImageDimen, height: logoImageDimen)
        logoImage.center.x = Globals.screenDimen.width / 2
        logoImage.backgroundColor = UIColor.clear
        
        backgroundContainer.addSubview(logoImage)
        
        tableView = UITableView()
        tableView.frame = CGRect(x:0, y: logoImage.frame.maxY + 20, width: self.view.frame.width * 0.75, height: 360)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "nameCell")
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.allowsSelection = false
        tableView.center.x = backgroundContainer.center.x
        tableView.layer.cornerRadius = 5
        
        backgroundContainer.addSubview(tableView)
        
        inviteTextField = UITextField()
        inviteTextField.frame = CGRect(x: 0, y: tableView.frame.maxY + 20, width: 0, height: 0)
        inviteTextField.textAlignment = .center
        inviteTextField.textColor = UIColor.white
        inviteTextField.placeholder = "please put username here"
        inviteTextField.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        inviteTextField.sizeToFit()
        inviteTextField.center.x = backgroundContainer.center.x
        
        backgroundContainer.addSubview(inviteTextField)
        
        inviteButton = UIButton()
        inviteButton.frame = CGRect(x: 0, y: inviteTextField.frame.maxY + 20, width: 0, height: 0)
        inviteButton.setTitleColor(.white, for: .normal)
        inviteButton.setTitle("Invite", for: .normal)
        inviteButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        inviteButton.sizeToFit()
        inviteButton.center.x = backgroundContainer.center.x
        inviteButton.addTarget(self, action: #selector(self.inviteHandler), for: .touchUpInside)
        
        backgroundContainer.addSubview(inviteButton)
        
        backButton = UIButton()
        backButton.frame = CGRect(x: 0, y: inviteButton.frame.maxY + 20, width: 0, height: 0)
        backButton.setTitleColor(.white, for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        backButton.sizeToFit()
        backButton.center.x = backgroundContainer.center.x
        backButton.addTarget(self, action: #selector(self.backHandler), for: .touchUpInside)
        
        backgroundContainer.addSubview(backButton)
        
        self.view.addSubview(backgroundContainer)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        let user = userDictionary[indexPath[1]] as! Dictionary<String, Any>
        let username = user["username"] as! String
        let tF = user["ingame"] as! Bool
        cell.textLabel!.text = "\(username)"
        cell.backgroundColor = tF ? UIColor.init(red: 76/255, green: 165/255, blue: 95/255, alpha: 1) : UIColor.init(red: 205/255, green: 79/255, blue: 96/255, alpha: 1)
        cell.textLabel!.textColor = UIColor.white
        cell.textLabel!.textAlignment = .center
        
        return cell
    }
    
    @objc func inviteHandler(sender: UIButton) {
        let inputtedUsername = inviteTextField.text!
        
        // TODO : check if username exists in database. If true create spot for user.
        
        print("Check database if \(inputtedUsername.lowercased()) exists. If so invite them.")
        inviteTextField.text = ""
        userDictionary.append(["username":inputtedUsername, "ingame":true])
        tableView.reloadData()
    }
    
    @objc func backHandler(sender: UIButton) {
        // TODO : link to Countdown View Controller
        self.dismiss(animated: true)
    }
    
}
