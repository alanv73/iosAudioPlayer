//
//  ViewController.swift
//  audioplayer
//
//  Created by Alan Van Art on 2/3/20.
//  Copyright © 2020 Alan Van Art. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    var timer = Timer()
    
    @IBOutlet weak var scrubber: UISlider!
    @IBOutlet weak var sliderVolume: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioPath = Bundle.main.path(forResource: "ffdp", ofType: "mp3")
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            scrubber.maximumValue = Float(player.duration)
        } catch {
            
        }
    }

    @IBAction func playClicked(_ sender: Any) {
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
    }
    
    @IBAction func pauseClicked(_ sender: Any) {
        player.pause()
        timer.invalidate()
    }
    
    @IBAction func sliderMoved(_ sender: Any) {
        player.volume = sliderVolume.value
    }
    
    @IBAction func scrubMoved(_ sender: Any) {
        player.currentTime = TimeInterval(scrubber.value)
    }
    
    @objc func updateScrubber(){
        scrubber.value = Float(player.currentTime)
    }
}

