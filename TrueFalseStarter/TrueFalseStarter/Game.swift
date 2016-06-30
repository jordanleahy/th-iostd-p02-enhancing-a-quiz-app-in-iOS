//
//  Game.swift
//  TrueFalseStarter
//
//  Created by Martin Wilter on 6/29/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

let questionsPerRound = 10
var questionsAsked = 0
var correctQuestions = 0

func createGame() {
    print("createGame() | Game.swift")

    questionsAsked = 0
    correctQuestions = 0

    createQuestionGroup()
    playGameStartSound()

}

func checkSubmittedAnswer(submittedAnswer: String) -> Bool {
    print("checkSubmittedAnswer() | Game.swift")

    questionsAsked += 1

    if submittedAnswer == gameQuestions.first?.answer {
        correctQuestions += 1
        gameQuestions.removeFirst()
        return true
    } else {
        gameQuestions.removeFirst()
        return false
    }

}

