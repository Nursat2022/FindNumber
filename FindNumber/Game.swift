//
//  Game.swift
//  FindNumber
//
//  Created by Nursat Sakyshev on 19.01.2023.
//

import Foundation

enum statusGame {
    case start
    case win
    case lose
}

class Game {
    
    struct Item {
        var title: String
        var isFound: Bool = false
        var isError = false
    }
    
    private let data = Array(1...99)
    
    var items: [Item] = []
    
    private var countItems: Int
    
    private var timeForGame: Int
    
    private var secondsGame: Int {
        didSet {
            if secondsGame == 0 {
                status = .lose
            }
            updateTimer(status, secondsGame) 
        }
    }
    
    private var timer: Timer?
    
    var nextItem: Item?
    
    private var updateTimer:((statusGame, Int) -> Void)
    
    var status: statusGame = .start {
        didSet {
            if status != .start {
                stopGame()
            }
        }
    }
    
    init(countItems: Int, timeForGame: Int, updateTimer: @escaping (_ status: statusGame, _ seconds: Int) -> Void) {
        self.countItems = countItems
        self.secondsGame = timeForGame
        self.timeForGame = timeForGame
        self.updateTimer = updateTimer
        setupGame()
    }
    
    private func setupGame() {
        var digits = data.shuffled()
        items.removeAll() 
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
        
        updateTimer(status, secondsGame)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self](_) in self?.secondsGame -= 1
        })
    }
    
    func check(index: Int) {
        guard status == .start else {return}
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        }
        else{
            items[index].isError = true
        }
        if nextItem == nil {
            status = .win
        }
    }
    
    private func stopGame() {
        timer?.invalidate()
    }
    
    func newGame() {
        status = .start
        self.secondsGame = timeForGame 
        setupGame()
    }
}

extension Int {
    func secondsToString() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%d:%02d", minutes, seconds )
    }
}
