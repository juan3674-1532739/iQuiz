//
//  Topic.swift
//  iQuiz
//
//  Created by Ju An Oh on 2/24/19.
//  Copyright © 2019 Ju An Oh. All rights reserved.
//

import Foundation

class Topic {
    var subject:String
    var description: String
    var questions: [Question]
    
    init (subject: String, description: String, questions: [Question]) {
        self.subject = subject
        self.description = description
        self.questions = questions
    }
    
}
