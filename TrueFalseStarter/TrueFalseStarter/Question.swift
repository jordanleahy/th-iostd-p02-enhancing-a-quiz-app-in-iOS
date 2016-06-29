//
//  Question.swift
//  TrueFalseStarter
//
//  Created by Martin Wilter on 6/28/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

var gameQuestions = [Question]()

struct Question {
    let question: String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    let answer: String
    let image: String
}

// Returns question object
func createQuestion(questionFromDictionary: [String: String]) -> Question {

    let question = questionFromDictionary["Question"]!
    let option1 = questionFromDictionary["Option1"]!
    let option2 = questionFromDictionary["Option2"]!
    let option3 = questionFromDictionary["Option3"]!
    let option4 = questionFromDictionary["Option4"]!
    let answer = questionFromDictionary["Answer"]!
    let image = questionFromDictionary["Image"]!

    let questionObject = Question(question: question, option1: option1, option2: option2, option3: option3, option4: option4, answer: answer, image: image)

    return questionObject
}

// Returns array of question objects
func createQuestionGroup() {

    // Get indices of random questions
    let randomQuestionsIndicies = pickRandomQuestionsByIndex()

    var questionGroup = [Question]()

    for index in randomQuestionsIndicies {
        questionGroup.append(createQuestion(trivia[index]))
    }

    print("----------")
    for question in questionGroup {
        print(question)
    }
    print("----------")

    gameQuestions = questionGroup
}


// MARK: - Helper functions

// Returns array with given number of random indices from the data collection array
func pickRandomQuestionsByIndex() -> [Int] {

    // Dict of indices
    var randomIndices = [Int: Int]()

    while randomIndices.count < questionsPerRound {

        let randomNumber = randomIntWithUpperBound(trivia.count)

        if randomIndices[randomNumber] == nil {
            randomIndices.updateValue(randomNumber, forKey: randomNumber)
        }
    }

    // Array indices
    var randomQuestionsIndicies = [Int]()

    for key in randomIndices.values {
        randomQuestionsIndicies.append(key)
    }

    return randomQuestionsIndicies
}

