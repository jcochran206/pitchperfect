//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Jonathan Cochran on 5/12/18.
//  Copyright © 2018 Jonathan Cochran. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    // mark buttons
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    //functions
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play Sound Button Pressed")
            switch(ButtonType(rawValue: sender.tag)!) {
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 1.5)
            case .chipmunk:
                playSound(pitch: 1000)
            case .vader:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
            }
            
            configureUI(.playing)
        }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    func configure(button: UIButton) {
        button.imageView?.contentMode = .scaleAspectFit
    }
    
    func configureButtons() {
        configure(button: snailButton)
        configure(button: rabbitButton)
        configure(button: chipmunkButton)
        configure(button: vaderButton)
        configure(button: echoButton)
        configure(button: reverbButton)
        configure(button: stopButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        configureButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

}
