//
//  Score.swift
//  Memory Game
//
//  Created by David Maksa on 04.08.20.
//  Copyright © 2020 David Maksa. All rights reserved.
//

import UIKit
import RealmSwift

class Score: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var scoreValue = 0
    @objc dynamic var timestamp = Date().timeIntervalSinceReferenceDate
    
    convenience init(name: String, scoreValue: Int) {
        self.init()
        self.name = name
        self.scoreValue = scoreValue
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
