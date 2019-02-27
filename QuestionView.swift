//
//  QuestionView.swift
//  iQuiz
//
//  Created by Ju An Oh on 2/24/19.
//  Copyright © 2019 Ju An Oh. All rights reserved.
//

import UIKit

class QuestionView: UIViewController {
    
    
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var topic: UILabel!
    
    var selectedTopic = ""

    var questions : [Question]?
    var questionIndex = 0
    var isCorrect = false
    var userAnswer = ""
    var currentScore = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        question.text = questions?[questionIndex].question
        topic.text = selectedTopic
        answer1.setTitle(questions?[questionIndex].answers[0], for: .normal)
        answer2.setTitle(questions?[questionIndex].answers[1], for: .normal)
        answer3.setTitle(questions?[questionIndex].answers[2], for: .normal)
        answer4.setTitle(questions?[questionIndex].answers[3], for: .normal)
       
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(leftSwipe)
    }
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        answer1.isSelected = false
        answer2.isSelected = false
        answer3.isSelected = false
        answer4.isSelected = false
        let index : Int = sender.tag
        self.userAnswer = (questions?[questionIndex].answers[index - 1])!
        if self.userAnswer == questions?[questionIndex].correct {
            isCorrect = true
            currentScore += 1
        }
        sender.isSelected = !sender.isSelected
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showResult" {
            let vc = segue.destination as! ViewResultController
            vc.isCorrect = self.isCorrect
            vc.questions = self.questions
            vc.questionIndex = self.questionIndex
            vc.score = self.currentScore
            vc.selectedTopic = self.selectedTopic
            vc.answered = self.userAnswer
        }
    }

}
extension UIViewController {
    @objc func swipeAction(swipe:UISwipeGestureRecognizer) {
        switch swipe.direction.rawValue {
        case 1:
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        case 2:
            if(canPerformSegueWithIdentifier(identifier: "showResult")) {
                self.performSegue(withIdentifier: "showResult", sender: nil)
            }
            else {
                self.performSegue(withIdentifier: "proceed", sender: nil)
            }
        default:
            break
        }
    }
    
    @objc func swipe(swipe:UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "showFinal", sender: nil)
    }
    
    @objc func canPerformSegueWithIdentifier(identifier: NSString) -> Bool {
        let templates:NSArray = self.value(forKey: "storyboardSegueTemplates") as! NSArray
        let predicate:NSPredicate = NSPredicate(format: "identifier=%@", identifier)
        
        let filteredtemplates = templates.filtered(using: predicate)
        return (filteredtemplates.count>0)
    }
}
