//
//  ViewController.swift
//  ApplePie
//
//  Created by Thuy on 6/16/21.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["newyork", "hanoi", "beijing", "monaco", "hochiminh"]
    var incorrectAllowed = 7
    var totalWins = 0 {
        didSet {
            newGame()
        }
    }
    var totalLosses = 0 {
        didSet {
            newGame()
        }
    }
    var currentGame: Game!
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func pressButton(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuess(letter: letter)
        updateUI()
        updateGameState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    func newGame() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectAllowed, guessLetter: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpace = letters.joined(separator: " ")
        correctLabel.text = wordWithSpace
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
}
