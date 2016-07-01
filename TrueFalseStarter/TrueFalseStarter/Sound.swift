//
//  Sound.swift
//  TrueFalseStarter
//
//  Created by Martin Wilter on 6/29/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import AudioToolbox

var gameSound: SystemSoundID = 0
var correctAnswerSound: SystemSoundID = 0
var wrongAnswerSound: SystemSoundID = 0

func loadGameSounds() {
    print("-->> loadGameSounds() | Sound.swift")

    let pathToGameStartSoundFile = NSBundle.mainBundle().pathForResource("Sounds/GameSound", ofType: "wav")
    let gameStartSoundURL = NSURL(fileURLWithPath: pathToGameStartSoundFile!)
    AudioServicesCreateSystemSoundID(gameStartSoundURL, &gameSound)

    let pathToCorrectAnswerSoundFile = NSBundle.mainBundle().pathForResource("Sounds/264981__renatalmar__sfx-magic", ofType: "wav")
    let correctAnswerSoundURL = NSURL(fileURLWithPath: pathToCorrectAnswerSoundFile!)
    AudioServicesCreateSystemSoundID(correctAnswerSoundURL, &correctAnswerSound)

    let pathToWrongAnswerSoundFile = NSBundle.mainBundle().pathForResource("Sounds/142608__autistic-lucario__error", ofType: "wav")
    let wrongAnswerSoundURL = NSURL(fileURLWithPath: pathToWrongAnswerSoundFile!)
    AudioServicesCreateSystemSoundID(wrongAnswerSoundURL, &wrongAnswerSound)

}

func playMainGameStartSound() {
    print("-->> playMainGameStartSound() | Sound.swift")

    AudioServicesPlaySystemSound(gameSound)
}

func playCorrectAnswerSound() {
    print(correctAnswerSound)
    print("-->> playCorrectAnswerSound() | Sound.swift")

    AudioServicesPlaySystemSound(correctAnswerSound)
}

func playWrongAnswerSound() {
    print("-->> playWrongAnswerSound() | Sound.swift")

    AudioServicesPlaySystemSound(wrongAnswerSound)
}

