//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Game states
    enum GameStates {
        case playeDidReceiveQuestion
        case playerWillAnswerQuestion
        case playerDidAnswerQuestion
        case gameOver
    }

    // Text
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var feedbackHeaderLabel: UILabel!
    @IBOutlet weak var feedbackBodyLabel: UILabel!

    // Buttons
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!

    // Background
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var gradient: UIView!
    let gradientLayer = CAGradientLayer()


    override func viewDidLoad() {
        questionLabel.enabled = true // TODO: Delete and change initial state in IB
        loadGameSounds()
        createGame()
        playGame()
    }

    override func viewWillLayoutSubviews() {
        // Adds gradient layer for improved text readability
        gradientLayer.colors = [(hexStringToUIColor("#000000")).CGColor, (hexStringToUIColor("#000000", alpha: 0.8)).CGColor, UIColor.clearColor().CGColor]
        gradientLayer.locations = [0.0, 0.1, 0.3]
        gradientLayer.frame = self.view.bounds
        gradient.layer.addSublayer(gradientLayer)
    }

    func playGame() {
        guard numberOfQuestionsAsked != questionsPerRound else {
            progressLabel.text = "Game Over"
            displayScore()
            return
        }
        numberOfQuestionsAsked += 1
        progressLabel.text = "Question \(numberOfQuestionsAsked) of \(questionsPerRound)"

        displayQuestion()
    }

    func displayQuestion() {
        questionLabel.text = gameQuestions.first?.question
        option1Button.setTitle(gameQuestions.first?.option1, forState: .Normal)
        option2Button.setTitle(gameQuestions.first?.option2, forState: .Normal)
        option3Button.setTitle(gameQuestions.first?.option3, forState: .Normal)
        option4Button.setTitle(gameQuestions.first?.option4, forState: .Normal)
        backgroundImage.image = UIImage(named: "Images/\((gameQuestions.first?.image)!)")

        configureUIForGameState(.playeDidReceiveQuestion)
        startTimer()
        continueGameWithDelay(seconds: 4, purpose: "Delay display of answer option buttons")

    }

    // TODO: Refactor?
    func displayAnswer() {

    }

    func displayScore() {

        timerLabel.text = "Total Time \(totalGameTime) sec"
        timerLabel.textColor = UIColor.whiteColor()

        let numberOfQuestionsAnswered = Double(questionsPerRound)
        let numberOfCorrectAnswers = Double(correctQuestions)

        if numberOfCorrectAnswers == 0 {
            // 0% correct
            feedbackHeaderLabel.textColor = hexStringToUIColor("#FFA269")
            feedbackHeaderLabel.text = "Bummer!"
            feedbackBodyLabel.text = "You had no correct answers!"
        } else if numberOfCorrectAnswers / numberOfQuestionsAnswered <= 0.5 {
            // 50% correct or less
            feedbackHeaderLabel.textColor = hexStringToUIColor("#FFA269")
            feedbackHeaderLabel.text = "Try again"
            feedbackBodyLabel.text = "You only got \(correctQuestions) out of \(questionsPerRound) correct..."
        } else if numberOfCorrectAnswers != numberOfQuestionsAnswered {
            // More than 50% correct
            feedbackHeaderLabel.textColor = hexStringToUIColor("#0C7996")
            feedbackHeaderLabel.text = "Way to go!"
            feedbackBodyLabel.text = "You got \(correctQuestions) out of \(questionsPerRound) correct!"
        } else {
            // 100% correct
            feedbackHeaderLabel.textColor = hexStringToUIColor("#0C7996")
            feedbackHeaderLabel.text = "Amazing!"
            feedbackBodyLabel.text = "You got all answers correct!"
        }

        configureUIForGameState(.gameOver)
        playStartAndGameOverSound()
    }


    // TODO: Refactor?
    @IBAction func checkAnswer(sender: UIButton?) {
        stopTimer()

        guard sender != nil else {
            feedbackHeaderLabel.textColor = hexStringToUIColor("#FFA269")
            feedbackHeaderLabel.text = "You ran out of time..."
            feedbackBodyLabel.text = "This is \(checkSubmittedAnswer("").correctAnswer)!"

            continueGameWithDelay(seconds: 2, purpose: "checkAnswer")
            configureUIForGameState(.playerDidAnswerQuestion)

            return
        }

        let resultFromCheckedSubmittedAnswer = checkSubmittedAnswer(sender!.currentTitle!)

        if resultFromCheckedSubmittedAnswer.success {
            feedbackHeaderLabel.textColor = hexStringToUIColor("#0C7996")
            feedbackHeaderLabel.text = "Correct!"
            feedbackBodyLabel.text = "Nice job, this is \(resultFromCheckedSubmittedAnswer.correctAnswer)"
        } else {
            feedbackHeaderLabel.textColor = hexStringToUIColor("#FFA269")
            feedbackHeaderLabel.text = "Wrong!"
            feedbackBodyLabel.text = "Actually, this is \(resultFromCheckedSubmittedAnswer.correctAnswer)"
        }

        continueGameWithDelay(seconds: 2)
        configureUIForGameState(.playerDidAnswerQuestion)
    }

    @IBAction func playAgain() {
        createGame()
        playGame()
    }

}


// MARK: Helper Functions

extension ViewController {

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

    // Delays execution 'to create smoother flow'
    // Source: Treehouse starter code (Added parameter for purpose to original code)
    func continueGameWithDelay(seconds seconds: Int, purpose: String = "Default") {

        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))

        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)

        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            if purpose == "Delay display of answer option buttons" {
                self.configureUIForGameState(.playerWillAnswerQuestion)
            } else {
                self.playGame()
            }
        }
    }

}

