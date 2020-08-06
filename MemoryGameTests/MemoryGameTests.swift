//
//  MemoryGameTests.swift
//  MemoryGameTests
//
//  Created by David Maksa on 30.07.20.
//  Copyright © 2020 David Maksa. All rights reserved.
//

import XCTest
@testable import Memory_Game

class MemoryGameTests: XCTestCase {
    
    var game: Game!

    override func setUpWithError() throws {
        game = Game()
    }

    override func tearDownWithError() throws {
    }

    func testGameInitialization() throws {
        XCTAssert(game.cards.count == 16)
        XCTAssert(game.score == 0)
        XCTAssert(game.cards.filter{$0.state == .faceDown}.count == 16)
        XCTAssert(game.cards.filter{$0.imageType == .sun}.count == 2)
    }
    
    func testCardFlipping() throws {
        game.flipCard(at: 0)
        XCTAssert(game.cards.first?.state == .faceUp)
        game.cards[1].state = .removed
        game.flipCard(at: 1)
        XCTAssert(game.cards[1].state == .removed)
    }
    
    func testCardResolvingWhenDifferentCardsAreFlipped() throws {
        let firstTwoCardsAreAPaire = game.cards[0].imageType == game.cards[1].imageType
        let indexes = [0, firstTwoCardsAreAPaire ? 2 : 1]
        game.flipCard(at: indexes[0])
        game.flipCard(at: indexes[1])
        let result = game.resolveFaceUpCards()
        XCTAssert(result.score == -1)
        XCTAssert(result.updatedIndexes == indexes)
        XCTAssert(result.isGameFinished == false)
        XCTAssert(game.cards[indexes[0]].state == .faceDown)
        XCTAssert(game.cards[indexes[1]].state == .faceDown)
    }
    
    func testCardResolvingWhenTheSameCardsAreFlipped() throws {
        let indexes = game.cards.indices.filter { game.cards[$0].imageType == .sun }
        game.flipCard(at: indexes[0])
        game.flipCard(at: indexes[1])
        let result = game.resolveFaceUpCards()
        XCTAssert(result.score == 2)
        XCTAssert(result.updatedIndexes == indexes)
        XCTAssert(result.isGameFinished == false)
        XCTAssert(game.cards[indexes[0]].state == .removed)
        XCTAssert(game.cards[indexes[1]].state == .removed)
    }
}
