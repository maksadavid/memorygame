//
//  ScoresViewController.swift
//  MemoryGame
//
//  Created by David Maksa on 04.08.20.
//  Copyright © 2020 David Maksa. All rights reserved.
//

import UIKit
import RealmSwift

class ScoresViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var scores: Results<Score>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = 44;
        let realm = try! Realm()
        scores = realm.objects(Score.self).sorted(byKeyPath: "scoreValue", ascending: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension ScoresViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ScoreTableViewCell
        let score = scores[indexPath.row]
        cell.configure(score: score)
        return cell
    }
}
