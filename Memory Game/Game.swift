//
//  Game.swift
//  Memory Game
//
//  Created by David Maksa on 30.07.20.
//  Copyright © 2020 David Maksa. All rights reserved.
//

import UIKit

class Game: NSObject {
    var cards = [Card]()
    
    override init() {
        super.init()
        cards = []
        for i in 0 ..< 8 {
            let type = CardImageType.init(rawValue: i)!
            cards.append(Card(imageType: type))
            cards.append(Card(imageType: type))
        }
        cards.shuffle()
    }
}
