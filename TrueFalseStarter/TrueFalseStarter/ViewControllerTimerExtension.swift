//
//  ViewControllerTimerExtension.swift
//  TrueFalseStarter
//
//  Created by Martin Wilter on 7/1/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

var timer = NSTimer()
var remainingTime = timePerQuestion
var totalGameTime = 0


extension ViewController {

    func startTimer() {
        timerLabel.text = configureMessage(.timerStartTime)
        timerLabel.textColor = configureUIColor(.defaultColor)

        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }

    func countdown() {
        totalGameTime += 1
        remainingTime -= 1
        timerLabel.text = configureMessage(.timerCoutdown)

        if remainingTime <= 5 {
            playCountdownSound()
            timerLabel.textColor = configureUIColor(.alertColor)
        }

        if remainingTime == 0 {
            stopTimer()
            checkAnswer(nil)
        }
    }

    func stopTimer() {
        timer.invalidate()
        remainingTime = timePerQuestion
    }

}

