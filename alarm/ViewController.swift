//
//  ViewController.swift
//  alarm
//
//  Created by Ярослав Вербило on 2023-02-12.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var label = UILabel()
    var datapicker = UIDatePicker()
    var button = UIButton()
    var alarmdate = 0.0
    var count = 0
    var timer: Timer?
    var player = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.addSubview(label)
        label.frame = CGRect(x: 0, y: 200, width: 200, height: 100)
        label.center.x = view.center.x
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 2
        label.font = UIFont.systemFont(ofSize: 30)
        
        view.addSubview(datapicker)
        datapicker.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        datapicker.center = view.center
        datapicker.addTarget(self, action: #selector(datepickeraction(sender:)), for: .valueChanged)
        datapicker.preferredDatePickerStyle = .compact
        
        view.addSubview(button)
        button.frame = CGRect(x: 0, y: view.frame.height - 300, width: 110, height: 48)
        button.setTitle("Start", for: .normal)
        button.center.x = view.center.x
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(buttonaction(sender:)), for: .touchUpInside)
        
        
        
        
    }
    
    func createtimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if self.count == 0 {
                self.stoptimer()
                self.playsound()
            } else {
                self.count -= 1
                self.label.text = "\(self.count)"
            }
        })
    }
    
    func playsound() {
        guard let url = Bundle.main.url(forResource: "Stan", withExtension: "mp3") else {return}
        do{
            player = try AVAudioPlayer(contentsOf: url)
        }catch {
            print("Error")
        }
        player.play()
    }
    
    func stopsound() {
        player.stop()
        
    }
    
    func stoptimer () {
        timer?.invalidate()
    }
    
    @objc func datepickeraction (sender: UIDatePicker) {
        alarmdate = sender.date.timeIntervalSince1970
        
    }
    @objc func buttonaction (sender: UIButton) {
        if sender.title(for: .normal) == "Start" {
            sender.setTitle("Stop", for: .normal)
            count = Int(self.alarmdate) - Int(Date().timeIntervalSince1970)
            createtimer()
        } else {
            sender.setTitle("Start", for: .normal)
            stopsound()
        }
        
    }

}

