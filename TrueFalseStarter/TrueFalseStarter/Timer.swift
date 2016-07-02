//
//  Timer.swift
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
        timerLabel.text = "\(timePerQuestion) sec"
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }

    func countDown() {
        totalGameTime += 1
        remainingTime -= 1
        timerLabel.text = "\(remainingTime) sec"

        if remainingTime <= 5 {
            timerLabel.textColor = UIColor.redColor()
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

