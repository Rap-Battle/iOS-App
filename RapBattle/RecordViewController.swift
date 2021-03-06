//
//  RecordViewController.swift
//  RapBattle
//
//  Created by Aditya Dhingra on 3/28/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage
import FirebaseDatabase

class RecordViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    
    @IBOutlet weak var circleAnimate2: BPCircleActivityIndicator!
    @IBOutlet weak var circleAnimate1: BPCircleActivityIndicator!
    @IBOutlet weak var circleAnimate: BPCircleActivityIndicator!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var didRecord = false
    let battleFirRef = FIRDatabase.database().reference()
    var battleRepliedTo: Battle? = nil

    
    @IBAction func recordTapped(_ sender: Any) {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    @IBAction func playTapped(_ sender: Any) {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        print("AUDIO: \(audioFilename)")
//        print(audioRecorder)
        if audioRecorder == nil {
//            recordButton.isEnabled = true
            
            do {
                circleAnimate.animate()
                circleAnimate1.animate()
                circleAnimate2.animate()
                
                try audioPlayer = AVAudioPlayer(contentsOf:
                    (audioFilename))
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
                print("playing")
            } catch let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        circleAnimate.stop()
        circleAnimate1.stop()
        circleAnimate2.stop()
    }
    
    @IBAction func didTapPost(_ sender: UIButton) {
        let audioFileUrl = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        if audioRecorder == nil && didRecord {
            didRecord = false
            
            let audioFile = FirebaseClient.currentDB.createNewAudioFileOnFirebase(with: audioFileUrl)

            FirebaseClient.currentDB.createNewReply(with: audioFile, battleRepliedTo: battleRepliedTo)
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set image as title
        
        let titleImageView = UIImageView(frame: CGRect(x: 0,y: 0,width: 0,height: 20))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = UIImage(named: "logo")
        
        //Commented out becuase center align probtlems. Will fix later
        //self.navigationItem.titleView = titleImageView
        
        
   //     self.navigationItem.titleView.
        //Done
        
        recordButton.isEnabled = false
        
        //Record Stuff
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Record now")
                        self.recordButton.isEnabled = true
                    } else {
                        // failed to record!
                        print("recording failed")
                    }
                }
            }
        } catch {
            // failed to record!
            print("Something went wrong with recording ...")
        }
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
//            recordButton.setTitle("Tap to Re-record", for: .normal)
            recordButton.setImage(UIImage(named: "record-start"), for: .normal)
            didRecord = true
            
            
        } else {
//            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
            recordButton.setImage(UIImage(named: "record-start"), for: .normal)
        }
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        print(audioFilename)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            print("recording now")
            
//            recordButton.setTitle("Tap to Stop", for: .normal)
            recordButton.setImage(UIImage(named: "record-finish"), for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
