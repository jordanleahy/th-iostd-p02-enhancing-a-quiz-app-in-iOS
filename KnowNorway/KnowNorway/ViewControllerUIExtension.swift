//
//  ViewControllerUIExtension.swift
//  TrueFalseStarter
//
//  Created by Martin Wilter on 7/2/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

extension ViewController {

    // Game states
    enum GameStates {
        case playeDidReceiveQuestion
        case playerWillAnswerQuestion
        case playerDidAnswerQuestion
        case gameOver
    }

    // Game colors
    enum GameColors {
        case defaultColor
        case successColor
        case errorColor
        case alertColor
    }

    // Message center
    enum Message {
        // Status bar
        case statusBarGameOver
        case statusBarProgress
        case statusBarTotalTime
        case timerStartTime
        case timerCoutdown

        // Feedback header
        case feedBackHeaderRanOutOfTime
        case feedBackHeaderCheckedSubmittedAnswerCorrect
        case feedBackHeaderCheckedSubmittedAnswerWrong
        case feedBackHeaderScore0
        case feedBackHeaderScoreLessThen50
        case feedBackHeaderScore50Plus
        case feedBackHeaderScore100

        // Feedback body
        case feedBackBodyRanOutOfTime
        case feedBackBodyCheckedSubmittedAnswerCorrect
        case feedBackBodyCheckedSubmittedAnswerWrong
        case feedBackBodyScore0
        case feedBackBodyScoreLessThen50
        case feedBackBodyScore50Plus
        case feedBackBodyScore100
    }


    // Set UI elements' state for current game state
    func configureUIForGameState(gameState: GameStates) {
        switch gameState {
        case .playeDidReceiveQuestion:
            questionLabel.hidden = false
            feedbackHeaderLabel.hidden = true
            feedbackBodyLabel.hidden = true
            option1Button.hidden = true
            option2Button.hidden = true
            option3Button.hidden = true
            option4Button.hidden = true
            playAgainButton.hidden = true
        case .playerWillAnswerQuestion:
            questionLabel.hidden = false
            feedbackHeaderLabel.hidden = true
            feedbackBodyLabel.hidden = true
            option1Button.hidden = false
            option2Button.hidden = false
            option3Button.hidden = false
            option4Button.hidden = false
            playAgainButton.hidden = true
        case .playerDidAnswerQuestion:
            questionLabel.hidden = true
            feedbackHeaderLabel.hidden = false
            feedbackBodyLabel.hidden = false
            option1Button.hidden = true
            option2Button.hidden = true
            option3Button.hidden = true
            option4Button.hidden = true
            playAgainButton.hidden = true
            option1Button.setTitle(nil, forState: .Normal)
            option2Button.setTitle(nil, forState: .Normal)
            option3Button.setTitle(nil, forState: .Normal)
            option4Button.setTitle(nil, forState: .Normal)
        case .gameOver:
            questionLabel.hidden = true
            feedbackHeaderLabel.hidden = false
            feedbackBodyLabel.hidden = false
            option1Button.hidden = true
            option2Button.hidden = true
            option3Button.hidden = true
            option4Button.hidden = true
            playAgainButton.hidden = false
        }
    }

    // Set UI element's color
    func configureUIColor(gameColor: GameColors) -> UIColor {

        switch gameColor {
        case .defaultColor:
            return UIColor.whiteColor()
        case .successColor:
            return hexStringToUIColor("#2196F3")
        case .errorColor:
            return hexStringToUIColor("#D50000")
        case .alertColor:
            return hexStringToUIColor("#D50000")
        }
    }

    // Set message to be displayed
    func configureMessage(message: Message) -> String {
        switch message {
        // Status bar
        case .statusBarGameOver:
            return "Game Over"
        case .statusBarProgress:
            return "Question \(numberOfQuestionsAsked) of \(questionsPerRound)"
        case .statusBarTotalTime:
            return "Total Time \(totalGameTime) sec"
        case .timerStartTime:
            return "\(timePerQuestion) sec"
        case .timerCoutdown:
            return "\(remainingTime) sec"

        // Feedback header
        case .feedBackHeaderRanOutOfTime:
            return "You ran out of time..."
        case .feedBackHeaderCheckedSubmittedAnswerCorrect:
            return "Correct!"
        case .feedBackHeaderCheckedSubmittedAnswerWrong:
            return "Wrong!"
        case .feedBackHeaderScore0:
            return "Bummer!"
        case .feedBackHeaderScoreLessThen50:
            return "Try again"
        case .feedBackHeaderScore50Plus:
            return "Way to go!"
        case .feedBackHeaderScore100:
            return "Amazing!"

        // Feedback body
        case .feedBackBodyRanOutOfTime:
            return "This is \(checkSubmittedAnswer("").correctAnswer)"
        case .feedBackBodyCheckedSubmittedAnswerCorrect:
            return "Nice job, this is "  // + 'correct answer'
        case .feedBackBodyCheckedSubmittedAnswerWrong:
            return "Actually, this is "  // + 'correct answer'
        case .feedBackBodyScore0:
            return "You had no correct answers!"
        case .feedBackBodyScoreLessThen50:
            return "You only got \(correctQuestions) out of \(questionsPerRound) correct..."
        case .feedBackBodyScore50Plus:
            return "You got \(correctQuestions) out of \(questionsPerRound) correct!"
        case .feedBackBodyScore100:
            return "You got all answers correct!"
        }
    }

}

