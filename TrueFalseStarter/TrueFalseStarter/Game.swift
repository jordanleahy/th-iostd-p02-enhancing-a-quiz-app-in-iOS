//
//  Game.swift
//  TrueFalseStarter
//
//  Created by Martin Wilter on 6/29/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

let questionsPerRound = 4
var numberOfQuestionsAsked = 0
var correctQuestions = 0

func createGame() {
    print("createGame() | Game.swift")

    numberOfQuestionsAsked = 0
    correctQuestions = 0

    createQuestionGroup()
    playGameStartSound()

}

func checkSubmittedAnswer(submittedAnswer: String) -> (success: Bool, correctAnswer: String) {
    print("checkSubmittedAnswer() | Game.swift")

    //numberOfQuestionsAsked += 1

    let correctAnswer = (gameQuestions.first?.answer)!

    if submittedAnswer == correctAnswer {
        correctQuestions += 1
        gameQuestions.removeFirst()
        return (true, correctAnswer)
    } else {
        gameQuestions.removeFirst()
        return (false, correctAnswer)
    }

}

