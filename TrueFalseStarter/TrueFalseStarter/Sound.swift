//
//  Sound.swift
//  TrueFalseStarter
//
//  Created by Martin Wilter on 6/29/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import AudioToolbox

var startAndGameOverSound: SystemSoundID = 0
var correctAnswerSound: SystemSoundID = 0
var wrongAnswerSound: SystemSoundID = 0


func loadGameSounds() {
    let pathToStartAndGameOverSoundFile = NSBundle.mainBundle().pathForResource("Sounds/GameSound", ofType: "wav")
    let startAndGameOverSoundURL = NSURL(fileURLWithPath: pathToStartAndGameOverSoundFile!)
    AudioServicesCreateSystemSoundID(startAndGameOverSoundURL, &startAndGameOverSound)

    let pathToCorrectAnswerSoundFile = NSBundle.mainBundle().pathForResource("Sounds/264981__renatalmar__sfx-magic", ofType: "wav")
    let correctAnswerSoundURL = NSURL(fileURLWithPath: pathToCorrectAnswerSoundFile!)
    AudioServicesCreateSystemSoundID(correctAnswerSoundURL, &correctAnswerSound)

    let pathToWrongAnswerSoundFile = NSBundle.mainBundle().pathForResource("Sounds/142608__autistic-lucario__error", ofType: "wav")
    let wrongAnswerSoundURL = NSURL(fileURLWithPath: pathToWrongAnswerSoundFile!)
    AudioServicesCreateSystemSoundID(wrongAnswerSoundURL, &wrongAnswerSound)
}

func playStartAndGameOverSound() {
    AudioServicesPlaySystemSound(startAndGameOverSound)
}

func playCorrectAnswerSound() {
    AudioServicesPlaySystemSound(correctAnswerSound)
}

func playWrongAnswerSound() {
    AudioServicesPlaySystemSound(wrongAnswerSound)
}

