//
//  GameViewController.swift
//  Memory Game
//
//  Created by David Maksa on 30.07.20.
//  Copyright © 2020 David Maksa. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    var selectedIndexes = [Int]()
    private var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @IBAction func newGameButtonTapped() {
        game = Game()
        collectionView.reloadData()
        scoreLabel.text = "Score: 0"
        selectedIndexes = []
    }
    
    func secondCardDidFlip() {
        let result = self.game.resolveFaceUpCards()
        scoreLabel.text = "Score: \(result.score)"
        result.updatedIndexes.forEach {
            let cell = self.collectionView.cellForItem(at: IndexPath(row: $0, section: 0)) as! CardCollectionViewCell
            let card = self.game.cards[$0]
            cell.flipCard(card) {
                self.selectedIndexes.removeAll()
            }
        }
        if result.isGameFinished {
            let alert = UIAlertController(title: "Congratulations!", message: "The game is finished. Please enter your name to record your score", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                // record score
               let _ =  alert.textFields?.first
            }))
            alert.addTextField { _ in }
            present(alert, animated: true, completion: nil)
        }
    }
}

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !selectedIndexes.contains(indexPath.item) &&
            selectedIndexes.count < 2 &&
            game.cards[indexPath.item].state == .faceDown else {
            return
        }
        let card = game.cards[indexPath.row]
        selectedIndexes.append(indexPath.item)
        game.flipCard(at: indexPath.item)
        let isSecondSelection = selectedIndexes.count == 2
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        cell.flipCard(card) {
            if isSecondSelection {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    self.secondCardDidFlip()
                }
            }
        }
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 30) / 4, height: (collectionView.frame.size.height - 30) / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardcell", for: indexPath) as! CardCollectionViewCell
        let card = game.cards[indexPath.row]
        cell.configure(with: card)
        return cell
    }
}
