//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Jonathan Cochran on 5/7/18.
//  Copyright © 2018 Jonathan Cochran. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordingLbl: UILabel!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var stopRecBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecBtn.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

// record IBAction used to record function when pressed
    @IBAction func recordAudio(_ sender: Any) {
        // calling configure button 
        configureRecordButtons(true)
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        //mark calling configure function to change button
        configureRecordButtons(false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else{
            print("recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundVC = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func configureRecordButtons(_ isRecording:Bool) {
        recordingLbl.text = isRecording ? "Recording in progress": "Tap to Record"
        recordBtn.isEnabled = !isRecording
        stopRecBtn.isEnabled = isRecording
    }
}

