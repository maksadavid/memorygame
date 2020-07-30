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
    let game = Game()
    
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
    
}

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        game.flipCard(at: indexPath.row)
        let card = game.cards[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        cell.flipCard(card)
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
