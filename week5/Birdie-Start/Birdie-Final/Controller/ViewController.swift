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
        tableview.rowHeight = 200
        setUpTableView()
    }

    func setUpTableView() {
        // Set delegates, register custom cells, set up datasource, etc.
        tableview.delegate = self
        tableview.dataSource = self
        MediaPostsHandler.shared.getPosts()
        
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {

    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {

    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaPostsHandler.shared.mediaPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextPost", for: indexPath)
        if let post = MediaPostsHandler.shared.mediaPosts[indexPath.row] as? ImagePost{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImagePost", for: indexPath)
            if let imageCell = cell as? ImagePostCell{
                imageCell.nameLabel.text = post.userName
                imageCell.postLabel.text = post.textBody
                imageCell.timeLabel.text = "the time"
                imageCell.postedImage.image = post.image
                return imageCell
            }
        } else {
            if let textCell = cell as? TextPostCell {
                textCell.nameLabel.text = MediaPostsHandler.shared.mediaPosts[indexPath.row].userName
                textCell.postLabel.text = MediaPostsHandler.shared.mediaPosts[indexPath.row].textBody
                textCell.timeLabel.text = "the time"
                return textCell
            }
        }
        return cell
    }


}
