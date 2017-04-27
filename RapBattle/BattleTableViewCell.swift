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
    
    var localUrlToPlay: URL?
    var audioPlayer: AVAudioPlayer!
    var delegate: BattleToRecordDelegate?
    
    var isChild = false
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBAction func onBattle(_ sender: UIButton) {
        delegate?.toRecord(battle: battle!)
    }
    @IBOutlet weak var respondsToText: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var playingSliderView: UISlider!
    
    @IBAction func onPlay(_ sender: UIButton) {
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf:
                localUrlToPlay!)
            self.audioPlayer.delegate = self
            self.audioPlayer!.prepareToPlay()
            self.audioPlayer!.play()
            print("playing")
        } catch let error as NSError {
            print("audioPlayer error: \(error.localizedDescription)")
        }
        
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
        audio.getLocalAudioURL(completion: { (localUrl: URL) in
            self.localUrlToPlay = localUrl
        }, failure: { (error: Error) in
            print("audioPlayer error: \(error.localizedDescription)")
        })
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
