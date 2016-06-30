//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    enum GameStates {
        case playerWillAnswerQuestion
        case playerDidAnswerQuestion
        case gameOver
    }

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerHeaderLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!


    override func viewDidLoad() {
        loadGameStartSound()
        createGame()
        playGame()
    }

    func playGame() {
        print("playGame() | ViewController.swift")

        guard questionsAnswered != questionsPerRound else {
            displayScore()
            return
        }
            displayQuestion()
    }

    func displayQuestion() {
        print("displayQuestion() | ViewController.swift")

        questionLabel.text = gameQuestions.first?.question
        option1Button.setTitle(gameQuestions.first?.option1, forState: .Normal)
        option2Button.setTitle(gameQuestions.first?.option2, forState: .Normal)
        option3Button.setTitle(gameQuestions.first?.option3, forState: .Normal)
        option4Button.setTitle(gameQuestions.first?.option4, forState: .Normal)
        backgroundImage.image = UIImage(named: "Images/\((gameQuestions.first?.image)!)")

        configureUIForGameState(.playerWillAnswerQuestion)
    }

    func displayAnswer() {

    }

    func displayScore() {
        print("displayScore() | ViewController.swift")

        questionLabel.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"

        configureUIForGameState(.gameOver)
        print("GAME OVER\n")
    }

    @IBAction func checkAnswer(sender: UIButton) {
        print("checkAnswer() | ViewController.swift")

        let submittedAnswer = sender.currentTitle!
        let resultFromCheckedSubmittedAnswer = checkSubmittedAnswer(submittedAnswer)

        if resultFromCheckedSubmittedAnswer.success {
            answerHeaderLabel.text = "Correct!"
            answerHeaderLabel.textColor = hexStringToUIColor("#0C7996")
            answerLabel.text = "Nice job, this is \(resultFromCheckedSubmittedAnswer.correctAnswer)"
        } else {
            answerHeaderLabel.text = "Wrong!"
            answerHeaderLabel.textColor = hexStringToUIColor("#FFA269")
            answerLabel.text = "Actually, this is \(resultFromCheckedSubmittedAnswer.correctAnswer)"
        }

        continueGameWithDelay(seconds: 2)
        configureUIForGameState(.playerDidAnswerQuestion)
    }

    @IBAction func playAgain() {
        print("playAgain() | ViewController.swift")

        createGame()
        displayQuestion()
    }

}


// MARK: Helper Functions

extension ViewController {

    // Configures UI elements
    func configureUIForGameState(gameState: GameStates) {
        print("configureUIForGameState(.\(gameState)) | ViewController.swift")

        // Set UI elements' state for current game state
        switch gameState {
        case .playerWillAnswerQuestion:
            option1Button.hidden = false
            option2Button.hidden = false
            option3Button.hidden = false
            option4Button.hidden = false
            playAgainButton.hidden = true
            questionLabel.hidden = false
            answerHeaderLabel.hidden = true
            answerLabel.hidden = true
        case .playerDidAnswerQuestion:
            option1Button.hidden = true
            option2Button.hidden = true
            option3Button.hidden = true
            option4Button.hidden = true
            playAgainButton.hidden = true
            option1Button.setTitle(nil, forState: .Normal)
            option2Button.setTitle(nil, forState: .Normal)
            option3Button.setTitle(nil, forState: .Normal)
            option4Button.setTitle(nil, forState: .Normal)
            questionLabel.hidden = true
            answerHeaderLabel.hidden = false
            answerLabel.hidden = false
        case .gameOver:
            option1Button.hidden = true
            option2Button.hidden = true
            option3Button.hidden = true
            option4Button.hidden = true
            playAgainButton.hidden = false
        }
    }

    // Delays execution 'to create smoother flow'
    func continueGameWithDelay(seconds seconds: Int) {
        print("continueGameWithDelay() | ViewController.swift")

        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))

        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)

        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.playGame()
        }
    }
    
}

