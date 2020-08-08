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
    @IBOutlet weak var topButton: RoundButton!
    @IBOutlet weak var rightButton: RoundButton!
    
    //MARK:- Constraints
    @IBOutlet weak var leftButtonToCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var topButtonToCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightButtonToCenterConstraint: NSLayoutConstraint!
    
    //MARK:- Variables
    private var menuIsOpen = false
    
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
        
    }
    
    @IBAction func mushroomPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func featherPressed(_ sender: Any) {
    }
    
    
    
    @IBAction func starPressed(_ sender: Any) {
    }
    
    
    
    //if toggleMenu is false, hide buttons under center button
    func setButtonConstraints() {
        leftButtonToCenterConstraint.constant = menuIsOpen ? 30 : -70
        topButtonToCenterConstraint.constant = menuIsOpen ? 30 : -70
        rightButtonToCenterConstraint.constant = menuIsOpen ? 30 : -70
    }
    

}

