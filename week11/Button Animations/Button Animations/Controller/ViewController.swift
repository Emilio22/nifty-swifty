//
//  ViewController.swift
//  Button Animations
//
//  Created by Emilio Rodriguez on 8/7/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- IB Outlets
    @IBOutlet weak var menuButton: RoundButton!
    @IBOutlet weak var mushroomButton: RoundButton!
    @IBOutlet weak var featherButton: RoundButton!
    @IBOutlet weak var starButton: RoundButton!
    @IBOutlet weak var marioImage: UIImageView!
    
    //MARK:- Constraints
    @IBOutlet weak var mushroomButtonToMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var featherButtonToMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var starButtonToMenuConstraint: NSLayoutConstraint!
    
    //MARK:- Variables
    private var menuIsOpen = false
    var animator = UIViewPropertyAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setButtonConstraints()
    }
    
    
    
    @IBAction func toggleMenu(_ sender: UIButton) {
        menuIsOpen.toggle()
        //set button constraints
        setButtonConstraints()
        
        //animate
        UIView.animate(withDuration: 0.75,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 7,
                       options: .allowUserInteraction,
                       animations: {
                        self.view.layoutIfNeeded()
                        }
        )
        if menuIsOpen == false {
            animator.startAnimation()
        }
    }
    
    @IBAction func mushroomPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func featherPressed(_ sender: Any) {
        animator.addAnimations {
            UIView.animate(withDuration: 2, delay: 0, animations: {
                self.marioImage.frame.origin.y -= 300
            }){ _ in
                UIView.animate(withDuration: 2, delay: 0, animations: {
                    self.marioImage.frame.origin.y += 300
                })
            }
        }
        
    }
    
    
    
    @IBAction func starPressed(_ sender: Any) {
    }
    
    
    
    //if toggleMenu is false, hide buttons under center button
    func setButtonConstraints() {
        mushroomButtonToMenuConstraint.constant = menuIsOpen ? 30 : -70
        featherButtonToMenuConstraint.constant = menuIsOpen ? 30 : -70
        starButtonToMenuConstraint.constant = menuIsOpen ? 30 : -70
    }
    

}

