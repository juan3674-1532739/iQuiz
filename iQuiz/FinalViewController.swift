//
//  FinalViewController.swift
//  iQuiz
//
//  Created by Ju An Oh on 2/25/19.
//  Copyright © 2019 Ju An Oh. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    var score = 0
    var length = 0

    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if score == length {
            message.text = "Perfect!"
        } else if score + 1 == length {
            message.text = "Almost!"
        } else {
            message.text = "Try Again!"
        }
        result.text = " \(score) out of \(length)"
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(leftSwipe)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
