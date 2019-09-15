//
//  ScoreManager.swift
//  CardMatchGame
//
//  Created by Rupika on 2019-09-13.
//  Copyright © 2019 Rupika. All rights reserved.
//

import Foundation
class ScoreManager {
    
    static let shared = ScoreManager()
    var currentScore = 0
    func resetScore(){
        currentScore = 0
    }
    func newPairFound(){
        currentScore = 1
    }
}
