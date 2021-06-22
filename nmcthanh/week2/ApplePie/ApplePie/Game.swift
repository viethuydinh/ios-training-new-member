//
//  Game.swift
//  ApplePie
//
//  Created by Thuy on 6/16/21.
//

import UIKit

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessLetter: [Character]
    
    mutating func playerGuess(letter: Character) {
        guessLetter.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
    
    var formattedWord: String {
        var guessword = ""
        for letter in word {
            if guessLetter.contains(letter) {
                guessword += "\(letter)"
            } else {
                guessword += "_"
            }
        }
        return guessword
    }
}
