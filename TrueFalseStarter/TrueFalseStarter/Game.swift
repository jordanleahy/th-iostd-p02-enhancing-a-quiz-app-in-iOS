//
//  Game.swift
//  TrueFalseStarter
//
//  Created by Martin Wilter on 6/29/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

// Game settings
let questionsPerRound = 5
let timePerQuestion = 15

// Game progress
var numberOfQuestionsAsked = 0
var correctQuestions = 0


func createGame() {
    numberOfQuestionsAsked = 0
    correctQuestions = 0

    createQuestionGroup()
    playStartAndGameOverSound()
}

func checkSubmittedAnswer(submittedAnswer: String) -> (success: Bool, correctAnswer: String) {
    let correctAnswer = (gameQuestions.first?.answer)!

    if submittedAnswer == correctAnswer {
        correctQuestions += 1
        gameQuestions.removeFirst()
        playCorrectAnswerSound()
        return (true, correctAnswer)
    } else {
        gameQuestions.removeFirst()
        playWrongAnswerSound()
        return (false, correctAnswer)
    }
}

