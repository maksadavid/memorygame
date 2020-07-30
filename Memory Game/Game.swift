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
    
    func flipCard(at index: Int) {
        let card = cards[index]
        guard card.state != .removed else {
            return
        }
        card.state = (card.state == .faceDown) ? .faceUp : .faceDown
    }
    
    func resolveFaceUpCards() -> [Int] {
        let faceUpCards = cards.filter { $0.state == .faceUp }
        guard faceUpCards.count > 1 else {
            return []
        }
        if faceUpCards[0].imageType == faceUpCards[1].imageType {
            faceUpCards[0].state = .removed
            faceUpCards[1].state = .removed
        } else {
            faceUpCards[0].state = .faceDown
            faceUpCards[1].state = .faceDown
        }
        
        let updatedIndex1 = cards.firstIndex(where: {$0 == faceUpCards[0]})!
        let updatedIndex2 = cards.firstIndex(where: {$0 == faceUpCards[1]})!
        return [updatedIndex1, updatedIndex2]
    }
}
