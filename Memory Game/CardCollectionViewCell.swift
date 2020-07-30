//
//  CardCollectionViewCell.swift
//  Memory Game
//
//  Created by David Maksa on 30.07.20.
//  Copyright © 2020 David Maksa. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet var cardImage: UIImageView!
    
    func configure(with card: Card) {
        switch card.state {
        case .faceDown:
            cardImage.isHidden = false
            cardImage.image = UIImage(named: "color0")
        case .faceUp:
            cardImage.isHidden = false
            cardImage.image = image(for: card.imageType)
        case .removed:
            cardImage.isHidden = true
        }
    }
    
    func image(for type: CardImageType) -> UIImage {
        switch type {
        case .heart:
            return UIImage(named: "color1")!
        case .star:
            return UIImage(named: "color2")!
        case .musicalNote:
            return UIImage(named: "color3")!
        case .drop:
            return UIImage(named: "color4")!
        case .cloud:
            return UIImage(named: "color5")!
        case .crown:
            return UIImage(named: "color6")!
        case .moon:
            return UIImage(named: "color7")!
        case .sun:
            return UIImage(named: "color8")!
        }
    }
    
    func flipCard(_ card: Card) {
        guard card.state != .removed else {
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.cardImage.transform = CGAffineTransform(scaleX: 0.0001, y: 1);
        }, completion: { success in
            self.cardImage.image = card.state == .faceDown ? UIImage(named: "color0") : self.image(for: card.imageType)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.cardImage.transform = CGAffineTransform(scaleX: 1, y: 1);
            }, completion:nil)
        })
    }
}
