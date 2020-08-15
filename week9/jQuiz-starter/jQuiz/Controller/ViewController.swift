//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!

    var clues: [Clue] = []
    var correctAnswerClue: Clue?
    var points: Int = 0
    let imageURL = "https://cdn1.edgedatg.com/aws/v2/abc/ABCUpdates/blog/2900129/8484c3386d4378d7c826e3f3690b481b/1600x900-Q90_8484c3386d4378d7c826e3f3690b481b.jpg"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        self.scoreLabel.text = "\(self.points)"

        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
        SoundManager.shared.playSound()
        getClues()

        logoImageView.downloaded(from: imageURL)
    }
    
    func getClues() {
        Networking.sharedInstance.getRandomCategory(completion: { (categoryId) in
            print("Closure inside .getRandomCategory")
            guard let id = categoryId else {
                return
            }

            
            Networking.sharedInstance.getAllCluesInCategory(categoryId: id) { (clues) in
                print("Closure inside .getAllCluesInCategory")
                self.clues = clues
                self.correctAnswerClue = clues.randomElement()
                self.setUpView()
            }
        })
        
    }
    
    func setUpView(){
        DispatchQueue.main.async {
            self.categoryLabel.text = self.correctAnswerClue?.category.title
            self.clueLabel.text = self.correctAnswerClue?.question
            self.scoreLabel.text = "\(self.points)"
            self.tableView.reloadData()
        }
    }

    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clues.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClueCell", for: indexPath) as? ClueCell else {
            return UITableViewCell()
        }
        //TODO
        let clue = clues[indexPath.row]
        cell.clueLabel.text = clue.answer
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if correctAnswerClue?.answer == clues[indexPath.row].answer {
            points += correctAnswerClue?.value ?? 0
        }
        getClues()
    }
}

