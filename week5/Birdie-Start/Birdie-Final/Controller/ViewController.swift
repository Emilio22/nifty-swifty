//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    func setUpTableView() {
        // Set delegates, register custom cells, set up datasource, etc.
        tableview.delegate = self
        tableview.dataSource = self
        MediaPostsHandler.shared.getPosts()
        
    }

    
    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Post Text", message: "What would you like to post?", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Username"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "body"
        }
        let action = UIAlertAction(title: "Post", style: .default, handler:{
            action in
            let post = TextPost(textBody: alertController.textFields![1].text,
                                userName: alertController.textFields![0].text!,
                                timestamp: Date())
            MediaPostsHandler.shared.addTextPost(textPost: post)
            self.tableview.reloadData()
            
        })
        alertController.addAction(action)
        present(alertController,animated: true,completion: nil)
    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {

    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaPostsHandler.shared.mediaPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextPost", for: indexPath)
        if let post = MediaPostsHandler.shared.mediaPosts[indexPath.row] as? ImagePost{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImagePost", for: indexPath)
            if let imageCell = cell as? ImagePostCell{
                imageCell.nameLabel.text = post.userName
                imageCell.postLabel.text = post.textBody
                imageCell.timeLabel.text = dateFormatter.string(from: post.timestamp)
                imageCell.postedImage.image = post.image
                return imageCell
            }
        } else {
            let post = MediaPostsHandler.shared.mediaPosts[indexPath.row]
            if let textCell = cell as? TextPostCell {
                textCell.nameLabel.text = post.userName
                textCell.postLabel.text = post.textBody
                textCell.timeLabel.text = dateFormatter.string(from: post.timestamp)
                return textCell
            }
        }
        return cell
    }


}
