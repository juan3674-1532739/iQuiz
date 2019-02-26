//
//  Question.swift
//  iQuiz
//
//  Created by Ju An Oh on 2/24/19.
//  Copyright © 2019 Ju An Oh. All rights reserved.
//

import Foundation

class Question {
    var question : String
    var answers : [String]
    var correct : String
    
    init (question: String, answers: [String], correct: String) {
        self.question = question
        self.answers = answers
        self.correct = correct
    }
}
