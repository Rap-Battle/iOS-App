//
//  BattleTableViewCell.swift
//  RapBattle
//
//  Created by monus on 4/8/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit

class BattleTableViewCell: UITableViewCell {
    var battle: Battle?
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var opponentNameLabel: UILabel!
    
    @IBAction func onBattle(_ sender: UIButton) {
    }
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var playingSliderView: UISlider!
    @IBAction func onPlay(_ sender: UIButton) {
    }

    func initializeWith(battle: Battle){
        self.battle = battle
        
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
