//
//  ViewResultController.swift
//  iQuiz
//
//  Created by Ju An Oh on 2/25/19.
//  Copyright © 2019 Ju An Oh. All rights reserved.
//

import UIKit

class ViewResultController: UIViewController {
    
    @IBOutlet weak var userResult: UILabel!
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var userAnswer: UITextView!
    @IBOutlet weak var proceed: UIButton!
    @IBOutlet weak var end: UIButton!
    var isCorrect = false
    var questions : [Question]?
    var questionIndex = 0
    var selectedTopic = ""
    var answered = ""
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if isCorrect {
            userResult.text = "Correct"
            userResult.backgroundColor = .green
        } else {
            userResult.text = "Wrong!"
            userResult.backgroundColor = .red
        }
        topic.text = selectedTopic
        question.text =  questions?[questionIndex].question
        userAnswer.text = answered
        questionIndex += 1
        if questions?.count == questionIndex {
            proceed.isHidden = true
            let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe(swipe:)))
            rightSwipe.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(rightSwipe)
        } else {
            end.isHidden = true
            let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
            rightSwipe.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(rightSwipe)
        }
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(leftSwipe)
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "proceed" {
             let vc = segue.destination as! QuestionView
             vc.questions = self.questions
             vc.questionIndex = self.questionIndex
             vc.selectedTopic = self.selectedTopic
             vc.currentScore = self.score
         }
        if segue.identifier == "showFinal" {
            let vc = segue.destination as! FinalViewController
            vc.length = self.questionIndex
            vc.score = self.score
        }
     
     }

}
