//
//  Sound.swift
//  TrueFalseStarter
//
//  Created by Martin Wilter on 6/29/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import AudioToolbox

var gameSound: SystemSoundID = 0

func loadGameStartSound() {
    print("loadGameStartSound() | Sound.swift")

    let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
    let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
    AudioServicesCreateSystemSoundID(soundURL, &gameSound)
}

func playGameStartSound() {
    print("playGameStartSound() | Sound.swift")

    AudioServicesPlaySystemSound(gameSound)
}

