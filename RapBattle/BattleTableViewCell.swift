//
//  BattleTableViewCell.swift
//  RapBattle
//
//  Created by monus on 4/8/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit
import AVFoundation

class BattleTableViewCell: UITableViewCell {
    var battle: Battle?
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBAction func onBattle(_ sender: UIButton) {
    }
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var playingSliderView: UISlider!
    @IBAction func onPlay(_ sender: UIButton) {
        let audio = battle!.cyphers[0]!
        audio.getLocalAudioURL(completion: { (localUrl: URL) in
            var audioPlayer: AVAudioPlayer?
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:
                    (localUrl))
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
                print("playing")
            } catch let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }, failure: { (error: Error) in
            print("audioPlayer error: \(error.localizedDescription)")
        })
        
    }

    func initializeWith(battle: Battle){
        self.battle = battle
        usernameLabel.text = battle.organizer!.getUsername()
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
