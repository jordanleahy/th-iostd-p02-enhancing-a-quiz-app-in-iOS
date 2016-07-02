//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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


    @IBAction func answerButtonWasPressed(sender: UIButton) {
        checkAnswer(sender)
    }

    @IBAction func playAgainButtonWasPressed() {
        createGame()
        playGame()
    }

    override func viewDidLoad() {
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
            progressLabel.text = configureMessage(.statusBarGameOver)
            displayScore()
            return
        }
        numberOfQuestionsAsked += 1
        progressLabel.text = configureMessage(.statusBarProgress)

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
        continueGameWithDelay(seconds: delayDisplayOfAnswerOptionButtons, purpose: "Delay display of answer option buttons")

    }

    func checkAnswer(sender: UIButton?) {
        stopTimer()

        guard sender != nil else {
            feedbackHeaderLabel.textColor = configureUIColor(.errorColor)
            feedbackHeaderLabel.text = configureMessage(.feedBackHeaderRanOutOfTime)
            feedbackBodyLabel.text = configureMessage(.feedBackBodyRanOutOfTime)

            continueGameWithDelay(seconds: delayDisplayOfNextScreen)
            configureUIForGameState(.playerDidAnswerQuestion)

            return
        }

        let resultFromCheckedSubmittedAnswer = checkSubmittedAnswer(sender!.currentTitle!)

        if resultFromCheckedSubmittedAnswer.success {
            feedbackHeaderLabel.textColor = configureUIColor(.successColor)
            feedbackHeaderLabel.text = configureMessage(.feedBackHeaderCheckedSubmittedAnswerCorrect)
            feedbackBodyLabel.text = configureMessage(.feedBackBodyCheckedSubmittedAnswerCorrect) + resultFromCheckedSubmittedAnswer.correctAnswer
        } else {
            feedbackHeaderLabel.textColor = configureUIColor(.errorColor)
            feedbackHeaderLabel.text = configureMessage(.feedBackHeaderCheckedSubmittedAnswerWrong)
            feedbackBodyLabel.text = configureMessage(.feedBackBodyCheckedSubmittedAnswerWrong) + resultFromCheckedSubmittedAnswer.correctAnswer
        }

        continueGameWithDelay(seconds: delayDisplayOfNextScreen)
        configureUIForGameState(.playerDidAnswerQuestion)
    }

    func displayScore() {
        timerLabel.text = configureMessage(.statusBarTotalTime)
        timerLabel.textColor = configureUIColor(.defaultColor)

        let numberOfQuestionsAnswered = Double(questionsPerRound)
        let numberOfCorrectAnswers = Double(correctQuestions)

        if numberOfCorrectAnswers == 0 {
            feedbackHeaderLabel.textColor = configureUIColor(.errorColor)
            feedbackHeaderLabel.text = configureMessage(.feedBackHeaderScore0)
            feedbackBodyLabel.text = configureMessage(.feedBackBodyScore0)
        } else if numberOfCorrectAnswers / numberOfQuestionsAnswered < 0.5 {
            feedbackHeaderLabel.textColor = configureUIColor(.errorColor)
            feedbackHeaderLabel.text = configureMessage(.feedBackHeaderScoreLessThen50)
            feedbackBodyLabel.text = configureMessage(.feedBackBodyScoreLessThen50)
        } else if numberOfCorrectAnswers != numberOfQuestionsAnswered {
            feedbackHeaderLabel.textColor = configureUIColor(.successColor)
            feedbackHeaderLabel.text = configureMessage(.feedBackHeaderScore50Plus)
            feedbackBodyLabel.text = configureMessage(.feedBackBodyScore50Plus)
        } else {
            feedbackHeaderLabel.textColor = configureUIColor(.successColor)
            feedbackHeaderLabel.text = configureMessage(.feedBackHeaderScore100)
            feedbackBodyLabel.text = configureMessage(.feedBackBodyScore100)
        }

        configureUIForGameState(.gameOver)
        playStartAndGameOverSound()
    }

}


// MARK: Helper Functions

extension ViewController {

    // Delays execution 'to create smoother flow'
    // Source: Treehouse starter code (Added parameter for purpose to original code)
    func continueGameWithDelay(seconds seconds: Int, purpose: String = "Default") {

        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))

        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)

        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            if purpose == "Default" {
                self.playGame()
            } else {
                self.configureUIForGameState(.playerWillAnswerQuestion)
            }
        }
    }

}

