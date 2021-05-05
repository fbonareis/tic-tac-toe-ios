//
//  GameViewModelTests.swift
//  TicTacToeTests
//
//  Created by Fernando de Bona on 04/05/21.
//

import XCTest
@testable import TicTacToe

class GameViewModelTests: XCTestCase {
    
    private var sut: GameViewModel!
    
    override func setUp() {
        super.setUp()
        sut = GameViewModel()
    }
    
    func test_isSquareOccupied() throws {
        let position = 1
        
        XCTAssertFalse(sut.isSquareOccupied(in: sut.moves, forIndex: position))
        
        sut.processPlayerMove(for: position)
        
        XCTAssertTrue(sut.isSquareOccupied(in: sut.moves, forIndex: position))
    }
    
    func test_processPlayerMove_isOccupied() throws {
        XCTAssertEqual(sut.moves.compactMap { $0 }.count, 0)
        
        sut.processPlayerMove(for: 1)
        sut.processPlayerMove(for: 1)
       
        XCTAssertEqual(sut.moves.compactMap { $0 }.count, 1)
    }
    
    func test_processPlayerMove_humanWin() throws {
        XCTAssertEqual(sut.moves.compactMap { $0 }.count, 0)
        XCTAssertNil(sut.alertItem)
        
        sut.processPlayerMove(for: 0)
        sut.processPlayerMove(for: 1)
        sut.processPlayerMove(for: 2)
       
        XCTAssertEqual(sut.moves.compactMap { $0 }.count, 3)
        XCTAssertNotNil(sut.alertItem)
    }
    
    func test_processPlayerMove_draw() throws {
        sut.processPlayerMove(for: 1)
        sut.processPlayerMove(for: 2)
        sut.processPlayerMove(for: 3)
        sut.processPlayerMove(for: 4)
        sut.processPlayerMove(for: 5)
        
        let exp = expectation(description: "\(#function)")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [self] in
            XCTAssertEqual(self.sut.moves.compactMap { $0 }.count, 9)
            XCTAssertNotNil(self.sut.alertItem)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
}
