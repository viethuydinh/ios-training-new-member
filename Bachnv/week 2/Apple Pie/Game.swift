//
//  Game.swift
//  Apple Pie
//
//  Created by Bách Nguyễn Viết on 13/07/2022.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else{
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) -> Bool {
        guessedLetters.append(letter)
        if !word.contains(letter){
            incorrectMovesRemaining -= 1
            return false
        }
        return true
    }
    
}
