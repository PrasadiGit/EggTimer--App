//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation



class ViewController: UIViewController {
    var audioPlayer: AVAudioPlayer!
    var selectedSoundFileName: String = ""
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    //Creating a dictionary with keys and values
    //To set the timer, first need to convert min to seconds.
    let eggTimes = ["Soft" : 3, "Medium" : 4, "Hard" : 7 ]
    // Creating a variable called secondTemaining
//    var secondRemaining = 60
    
    var timer = Timer()
    var totalTime = 0
    var secondsPressed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //Set the progress
//        progressBar.progress = 1.0
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPressed = 0
        titleLabel.text = hardness
        
        //Set the Timer
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    // Creating the fuction for updateTimer
    @objc   func updateTimer() {
        if secondsPressed < totalTime {

            secondsPressed = secondsPressed + 1
            progressBar.progress = Float(secondsPressed) / Float(totalTime)
            print(Float(secondsPressed) / Float(totalTime))
            
            //We need a percentage expressed as a decimal number, eg. 56% would be 0.56
            //We have a different amount of time to count down depending on which egg hardness was selected, eg. soft eggs require a total of 300s, which hard eggs require 720s total.
            //We have a function called updateTimer that can be done in every second.
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
             selectedSoundFileName = "alarm_sound"
             print(selectedSoundFileName)
             playSound()
        }
    }
    
    func playSound () {
        let url = Bundle.main.url(forResource: selectedSoundFileName, withExtension: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            guard let player = audioPlayer else { return }
            player.prepareToPlay()
            player.play()
        } catch let error as Error {
            print(error)
        }
    }
    
    
}
