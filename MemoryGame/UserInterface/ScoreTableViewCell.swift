//
//  ScoreTableViewCell.swift
//  MemoryGame
//
//  Created by David Maksa on 04.08.20.
//  Copyright © 2020 David Maksa. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    func configure(score: Score) {
        nameLabel.text = score.name
        scoreLabel.text = "\(score.scoreValue)"
        let date = Date(timeIntervalSinceReferenceDate: score.timestamp)
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        dateLabel.text = formatter.string(from: date)
    }
}
