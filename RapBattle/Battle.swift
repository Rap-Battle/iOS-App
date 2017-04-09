//
//  Battle.swift
//  RapBattle
//
//  Created by Deep S Randhawa on 3/23/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit

class Battle {
    
    var battleId: String?
    var opponentBattle: Battle?
    var userId: String?
    var audioFielUrl: String?
    
    func getBattleDic() -> [String: Any] {
        return [    "userId"    : self.userId!,
                "audioFileUrl"  : self.audioFielUrl!]
    }

    
}
