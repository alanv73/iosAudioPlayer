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
    var songList = [Int: [String: String]]()
    var currentSong = 0
    
    @IBOutlet weak var scrubber: UISlider!
    @IBOutlet weak var sliderVolume: UISlider!
    @IBOutlet weak var lblScrubber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSongs()
        
        queueSong()
    }

    @IBAction func playClicked(_ sender: Any) {
        if player.isPlaying {
            player.pause()
            timer.invalidate()
        } else {
            player.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
        }
        
        
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
    
    @IBAction func skipBackClicked(_ sender: Any) {
        var playing = false
        if player.isPlaying {
            playing = true
        }

        if currentSong > 0 {
            currentSong -= 1
            
            queueSong()
            
            scrubber.value = 0
            if playing {
                player.play()
            }
        }
    }
    
    @IBAction func skipForwardClicked(_ sender: Any) {
        var playing = false
        if player.isPlaying {
            playing = true
        }
        
        if currentSong < (songList.count - 1) {
            currentSong += 1

            queueSong()
            
            scrubber.value = 0
            if playing {
                player.play()
            }
            
        }
    }
    
    func loadSongs() {
        var song = [String: String]()
        
        song["title"] = "Instant Karma"
        song["artist"] = "John Lennon"
        song["file"] = "JLIK"
        songList[0] = song
        
        song["title"] = "Cecilia"
        song["artist"] = "Simon & Garfunkel"
        song["file"] = "SGC"
        songList[1] = song
        
    }
    
    func queueSong() {
         let audioPath = Bundle.main.path(forResource: songList[currentSong]!["file"], ofType: "mp3")
        
         do {
             try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
             scrubber.maximumValue = Float(player.duration)
            
            lblScrubber.text = "\(String(describing: songList[currentSong]!["title"])) by \(String(describing: songList[currentSong]!["artist"]))"
         } catch {
             
         }

    }
}

