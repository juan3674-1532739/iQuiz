//
//  ViewController.swift
//  iQuiz
//
//  Created by Ju An Oh on 2/16/19.
//  Copyright © 2019/Users/juan/Desktop/INFO449/iQuiz/iQuiz/TableViewCell.swift Ju An Oh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var list = [Topic]()
    let images = ["mathicon", "marvel", "science"]
    var url = "https://tednewardsandbox.site44.com/questions.json"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! TableViewCell
        let topic = list[indexPath.row]
        cell.title.text = topic.subject
        cell.detailTextLabel?.text = topic.description
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        cell.questions = topic.questions
        let itemSize = CGSize.init(width: 20, height: 20)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale);
        let imageRect = CGRect.init(origin: CGPoint.zero, size: itemSize)
        cell.imageView?.image!.draw(in: imageRect)
        cell.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        
        return cell
    }
    
    private func loadData(url:String) {
        list.removeAll()
        tableView.reloadData()
        
        guard let url = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    let errorMsg = error?.localizedDescription ?? "Response Error"
                    let alertController = UIAlertController(title: "Warning", message: errorMsg, preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    let data = UserDefaults.standard.object(forKey: "data") as! Array<[String: Any]>
                    self.parseJSON(data)
                    return }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: []) as! Array<[String: Any]>
                self.parseJSON(jsonResponse)
                
                UserDefaults.standard.set(jsonResponse, forKey: "data")
            } catch let parsingError {
                let alertController = UIAlertController(title: "Warning", message: "Downloading the data failed: \(parsingError)", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ data: Array<[String: Any]>) {
        for topic in data {
            let title = topic["title"] as! String
            let description = topic["desc"] as! String
            var questionList = [Question]()
            for question in topic["questions"]  as! [AnyObject] {
                let questionTitle = question["text"] as! String
                var listOfAnswers = [String]()
                let choices = question["answers"] as! [AnyObject]
                let correctIndex = question["answer"] as! String
                for answer in choices {
                    listOfAnswers.append(answer as! String)
                }
                questionList.append(Question(question: questionTitle, answers: listOfAnswers, correct: listOfAnswers[Int(correctIndex)! - 1]))
            }
            let topic = Topic(subject: title, description: description, questions: questionList)
            self.list.append(topic)
        }
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        loadData(url: url)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func settings(_ sender: Any) {
        let alertController = UIAlertController(title: "Settings", message: "Settings will go here", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Provide new URL"
        }
        alertController.addAction(UIAlertAction(title: "Check Now", style: .default, handler: { [weak alertController] (_) in
            let textField = alertController?.textFields![0]
            if !(textField?.text)!.isEmpty {
                self.url = (textField?.text)!
                self.loadData(url: self.url)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startQuiz" {
            let cell = sender as! TableViewCell
            let vc = segue.destination as! QuestionView
            vc.selectedTopic = cell.title.text!
            vc.questions = cell.questions
        }
     }

}

