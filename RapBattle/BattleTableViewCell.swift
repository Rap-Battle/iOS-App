//
//  BattleTableViewCell.swift
//  RapBattle
//
//  Created by monus on 4/8/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit
import AVFoundation

class BattleTableViewCell: UITableViewCell, AVAudioPlayerDelegate {
    var battle: Battle?
    
    var audio: Audio?
    var rootBattle: Battle?
    
    var localUrlToPlay: URL?
    var audioPlayer: AVAudioPlayer!
    var delegate: BattleToRecordDelegate?
    var audioDelegate: AudioDelegate?
    
    var isChild = false
    @IBOutlet weak var numVotes: UILabel!

    @IBAction func _upVoteButtonPressed(_ sender: UIButton) {
        upVoteButtonPressed(sender)
    }

    @IBAction func upVoteButtonPressed(_ sender: UIButton) {
        if isChild {
            for audioInArray in (rootBattle?.cyphers)!{
                if audio!.audioID! == audioInArray!.audioID! {
                    if (audioInArray!.addVoter(user: User.currentUser) == true) {
                        FirebaseClient.currentDB.updateBattle(battle: rootBattle!)
                        numVotes.text = "\(Int(numVotes.text!)! + 1)"
                        print("upvoted cypherID")
                    }
                }
            
            }
            
        }
        else if (battle?.cyphers[0]?.addVoter(user: User.currentUser) == true) {
            FirebaseClient.currentDB.updateBattle(battle: battle!)
            numVotes.text = "\(Int(numVotes.text!)! + 1)"
            print("upvoted cypherID")
        }
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBAction func onBattle(_ sender: UIButton) {
        delegate?.toRecord(battle: battle!)
    }
    @IBOutlet weak var respondsToText: UILabel!
    @IBOutlet weak var playingProgressView: UIProgressView!
    
    @IBAction func onPlay(_ sender: UIButton) {
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf:
                localUrlToPlay!)
            self.audioPlayer.delegate = self
            self.audioPlayer!.prepareToPlay()
            self.audioPlayer!.play()
            print("playing")
            
            //Progress view
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
            
        } catch let error as NSError {
            print("audioPlayer error: \(error.localizedDescription)")
        }
    }
    
    
    
    func updateAudioProgressView()
    {
        if audioPlayer.isPlaying
        {
            // Update progress
            playingProgressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playingProgressView.progress = 0.0
    }
    
    @IBAction func onReplyToBattle(_ sender: Any) {
    }

    func initializeWith(battle: Battle){
        self.battle = battle
        usernameLabel.text = battle.organizer!.getName()
        battle.cyphers[0]!.getLocalAudioURL(completion: { (localUrl: URL) in
            self.localUrlToPlay = localUrl
        }, failure: { (error: Error) in
            print("audioPlayer error: \(error.localizedDescription)")
        })
    }
    func initializeWith(audio: Audio, rootBattle: Battle){
        self.audio = audio
        usernameLabel.text = audio.user!.getName()
        respondsToText.text = "responds to " + (rootBattle.organizer?.getName())!
        self.rootBattle = rootBattle
        isChild = true
        audio.getLocalAudioURL(completion: { (localUrl: URL) in
            self.localUrlToPlay = localUrl
        }, failure: { (error: Error) in
            print("audioPlayer error: \(error.localizedDescription)")
        })
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        playingProgressView.progress = 0.0
        userImageView.layer.borderWidth = 1
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
