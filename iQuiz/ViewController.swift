//
//  ViewController.swift
//  iQuiz
//
//  Created by Ju An Oh on 2/16/19.
//  Copyright © 2019/Users/juan/Desktop/INFO449/iQuiz/iQuiz/TableViewCell.swift Ju An Oh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let list = ["Mathematics", "Marvel Super Heroes", "Science"]
    let descriptions = ["A description about Math","A description about heroes","A description about Science"]
    var images = ["mathicon", "marvel", "science"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! TableViewCell
//        cell.imageView?.image = image(UIImage(named: self.images[indexPath.row])!, withSize: CGSize(width: 35, height: 35))
        //cell.img.image = UIImage(named: self.images[indexPath.row])
//        cell.title.text = list[indexPath.row]
//        cell.desc.text = descriptions[indexPath.row]
//        cell.imageView?.image = UIImage(named: self.images[indexPath.row])
        cell.textLabel?.text = list[indexPath.row]
        cell.detailTextLabel?.text = descriptions[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        cell.imageView?.frame = CGRect(x:0, y: 0, width: 20, height: 20)
        return cell
    }
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
    }
//    func image( _ image:UIImage, withSize newSize:CGSize) -> UIImage {
//
//        UIGraphicsBeginImageContext(newSize)
//        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!.withRenderingMode(.automatic)
//    }
    @IBAction func settings(_ sender: Any) {
        let alertController = UIAlertController(title: "Settings", message: "Settings will go here", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

}

