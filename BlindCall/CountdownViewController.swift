//
//  CountdownViewController.swift
//  BlindCall
//
//  Created by Aaron Zhou on 3/17/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController, UITableViewDataSource {
    
    var backgroundContainer:UIView!
    var logoImage:CustomImage!
    var timeLeftLabel:UILabel!
    var timeLeft = 1500
    var startButton:UIButton!
    var timer = Timer()
    var started = false
    var tableView:UITableView!
    var userDictionary:Array<Dictionary<String, Any>> = [["username":"Aaron", "ingame":true], ["username":"Nadith", "ingame":true], ["username":"Doug", "ingame":true], ["username":"Raj", "ingame":false], ["username":"Ivan", "ingame":false]]
    

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
        
        timeLeftLabel = UILabel()
        timeLeftLabel.frame = CGRect(x: 0, y: logoImage.frame.maxY + 20, width: 0, height: 0)
        timeLeftLabel.textColor = UIColor.white
        timeLeftLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        timeLeftLabel.text = "Time Left: \(formatTimer(time: timeLeft))"
        timeLeftLabel.sizeToFit()
        timeLeftLabel.center.x = backgroundContainer.center.x
        
        backgroundContainer.addSubview(timeLeftLabel)
        
        // TODO Add Table
        tableView = UITableView()
        tableView.frame = CGRect(x:0, y: timeLeftLabel.frame.maxY + 20, width: self.view.frame.width * 0.75, height: 400)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "nameCell")
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.allowsSelection = false
        tableView.center.x = backgroundContainer.center.x
        tableView.layer.cornerRadius = 5
        
        backgroundContainer.addSubview(tableView)
        // TODO Add Table
        
        startButton = UIButton()
        startButton.frame = CGRect(x: 0, y: tableView.frame.maxY + 20, width: 0, height: 0)
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        startButton.sizeToFit()
        startButton.center.x = backgroundContainer.center.x
        startButton.addTarget(self, action: #selector(self.startHandler), for: .touchUpInside)
        
        backgroundContainer.addSubview(startButton)
        
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
    
    func runTimer() {
        if !started {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CountdownViewController.updateTimer), userInfo: nil, repeats: true)
            started = true
            startButton.setTitle("Fold", for: .normal)
            startButton.sizeToFit()
            startButton.center.x = backgroundContainer.center.x
            startButton.addTarget(self, action: #selector(self.foldHandler), for: .touchUpInside)
            userDictionary[0]["ingame"] = false
            tableView.reloadData()
        }
    }
    
    func formatTimer(time: Int) -> String {
        let hour = time / 3600
        let minute = time % 3600 / 60
        let second = time % 60
        
        if(hour == 0 && (minute != 0 || second != 0)) {
            let m: String
            let s: String
            if (minute / 10 == 0) {
                m = "0\(second)"
            } else {
                m = String(minute)
            }
            if (second / 10 == 0) {
                s = "0\(second)"
            } else {
                s = String(second)
            }
            return "\(m):\(s)"
        } else if (hour == 0 && minute != 0 && second != 0) {
            return "\(second)"
        } else {
            let m: String
            let s: String
            if (minute / 10 == 0) {
                m = "0\(second)"
            } else {
                m = String(minute)
            }
            if (second / 10 == 0) {
                s = "0\(second)"
            } else {
                s = String(second)
            }
            return "\(hour):\(m):\(s)"
        }
    }
    
    @objc func updateTimer() {
        if(timeLeft >= 0) {
            timeLeft -= 1
            timeLeftLabel.text="Time Left: \(formatTimer(time: timeLeft))"
            timeLeftLabel.sizeToFit()
            timeLeftLabel.center.x = backgroundContainer.center.x
        }
    }
    
    @objc func startHandler(sender: UIButton) {
        runTimer()
    }
    
    @objc func foldHandler(sender: UIButton) {
        // TODO do fold functionaily
        // 1.) Puts Money in the Pot
        // 2.) Changes color of user in list of users
        
        print("Folded.")
        
    }

}
