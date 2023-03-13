//
//  GameViewController.swift
//  FindNumber
//
//  Created by Nursat Sakyshev on 18.01.2023.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    //    @IBOutlet weak var firstButton: UIButton!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var nextDigit: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
 
    //1
//    lazy var game = Game(countItems: buttons.count, timeForGame: 30) { [weak self] (status, time) in
//        guard let self = self else {return}
//
//        self.timerLabel.text = time.secondsToString()
//        self.updateInfoGame(with: status )
//    }
    
    //2
    lazy var game = Game(countItems: buttons.count) { [weak self] (status, time) in
        guard let self = self else {return}
        
        self.timerLabel.text = time.secondsToString()
        self.updateInfoGame(with: status )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        //        firstButton.backgroundColor = .orange
        //        firstButton.setTitle("10", for: .normal)
    } 
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index: buttonIndex)
        
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    private func setupScreen() {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
//            buttons[index].isHidden = false
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI() {
        for index in game.items.indices {
//            buttons[index].isHidden = game.items[index].isFound
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                } completion: { [weak self] (_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }
            }
        }
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        game.stopGame()
    }
    
    private func updateInfoGame(with: statusGame) {
        switch with {
        case .start:
            statusLabel.text = "Игра началась"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "Вы выиграли"
            statusLabel.textColor = .green
            newGameButton.isHidden = false
        case .lose:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
        }
    }
}
