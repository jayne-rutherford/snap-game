//
//  ViewController.swift
//  snap-game
//
//  Created by Jayne Rutherford on 18/01/2016.
//  Copyright © 2016 Jayne Rutherford. All rights reserved.
//

import UIKit

enum Level {
    case Easy
    case Medium
    case Hard
}

class ViewController : UIViewController {
    
    @IBAction func easyPressed(sender: UIButton) {
        
        startGame(level: .Easy)
    }
    
    @IBAction func mediumPressed(sender: UIButton) {
        
        startGame(level: .Medium)
    }
    
    @IBAction func hardPressed(sender: UIButton) {
        
        startGame(level: .Hard)
    }
    
    func startGame(level level : Level) {
        
        let gameViewController = GameViewController(level: level)
        
        self.presentViewController(gameViewController, animated: true, completion: nil)
    }
}
