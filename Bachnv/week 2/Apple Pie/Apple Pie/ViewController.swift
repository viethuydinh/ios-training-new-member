//
//  ViewController.swift
//  Apple Pie
//
//  Created by Bách Nguyễn Viết on 13/07/2022.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["buncha","guitar","football","bug","mouse"]
    let incorrectMovesAllowed = 7
    var isPlayer1Turn = true
    var awardPoint = 0 {
        didSet {
            awardPointLabel.text = String(awardPoint)
        }
    }
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    var totalLosses = 0{
        didSet{
            newRound()
        }
    }
    var player1Point = 0{
        didSet{
            player1PointLabel.text = String(player1Point)
        }
    }
    var player2Point = 0{
        didSet{
            player2PointLabel.text = String(player2Point)
        }
    }
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var awardPointLabel: UILabel!
    @IBOutlet weak var player1PointLabel: UILabel!
    @IBOutlet weak var player1Background: UIStackView!
    @IBOutlet weak var player2PointLabel: UILabel!
    @IBOutlet weak var player2Background: UIStackView!
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view.
    }
    var currentGame: Game!
    func newRound(){
        if !listOfWords.isEmpty{
            let newWord = listOfWords[Int.random(in: 0...4)]
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }else{
            enableLetterButtons(false)
        }
        //check player's turn
        if isPlayer1Turn {
            player1Background.backgroundColor = .cyan
            player2Background.backgroundColor = .clear
        }else{
            player1Background.backgroundColor = .clear
            player2Background.backgroundColor = .cyan
        }
    }
    
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        //Map function
        let letters = currentGame.formattedWord.map{String($0)}
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        awardPointLabel.text = String(awardPoint)
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
            isPlayer1Turn.toggle()
            awardPoint = 0
            newRound()
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            awardPoint += 5
            playerPointCalculate(point: 5, true)
        } else {
            updateUI()
        }
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        if currentGame.playerGuessed(letter: letter){
            awardPoint += 1
            playerPointCalculate(point: 1, true)
        } else{
            if awardPoint > 0{
                awardPoint -= 1
            }
            playerPointCalculate(point: 1, false)
        }
        updateGameState()
    }
    func playerPointCalculate(point p:Int, _ isAdd:Bool){
        if isPlayer1Turn {
            if isAdd{
                player1Point += p
            }else{
                if player1Point > 0{
                    player1Point -= p
                }
            }
        }else{
            if isAdd{
                player2Point += p
            }else{
                if player2Point > 0{
                    player2Point -= p
                }
            }
        }
    }
    
}

