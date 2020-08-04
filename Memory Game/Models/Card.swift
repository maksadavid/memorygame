//
//  Card.swift
//  Memory Game
//
//  Created by David Maksa on 30.07.20.
//  Copyright © 2020 David Maksa. All rights reserved.
//

import UIKit

enum CardImageType: Int {
    case heart
    case star
    case musicalNote
    case drop
    case cloud
    case crown
    case moon
    case sun
}

enum CardState: Int {
    case faceDown
    case faceUp
    case removed
}

class Card: NSObject {
    let imageType: CardImageType
    var state: CardState
    
    init(imageType: CardImageType) {
        self.imageType = imageType
        state = .faceDown
    }
}
