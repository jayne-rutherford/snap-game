//
//  GameViewController.swift
//  snap-game
//
//  Created by Jayne Rutherford on 18/01/2016.
//  Copyright © 2016 Jayne Rutherford. All rights reserved.
//

import UIKit

class GameViewController : UIViewController {
    
    enum Player {
        case Computer
        case User
    }
    
    var deckOfCards : Deck
    var gameLevel : Level
    var gameOver : Bool = false
    
    @IBOutlet weak var playerOneButton: UIButton!
    @IBOutlet weak var cardInPlayView: PlayerCardView!
    @IBOutlet weak var previousCardInPlayView: PlayerCardView!
    
    // MARK: Initialisation
    
    init(level : Level) {

        self.deckOfCards = Deck()
        self.gameLevel = level
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIView
    
    override func viewDidLoad() {
        
        setPlayerButtonEnabled(.User)
    }
    
    override func shouldAutorotate() -> Bool {
        
        return (UI_USER_INTERFACE_IDIOM() == .Pad)
    }
    
    // MARK: Game play
    
    func playCard(currentPlayer : Player) {
        
        var indexOfHand : NSInteger
        switch currentPlayer {
            case .User:
                indexOfHand = 0
            case .Computer:
                indexOfHand = 1
        }
        
        self.deckOfCards.drawTopCardFromHand(indexOfHand)
        
        if (self.deckOfCards.currentCardInPlay != nil) {
            
            self.previousCardInPlayView.setDrawnCard(
                self.deckOfCards.previousCardInPlay?.rank,
                suit: self.deckOfCards.previousCardInPlay?.suit
            )
            
            self.cardInPlayView.setDrawnCard(
                self.deckOfCards.currentCardInPlay.rank,
                suit: self.deckOfCards.currentCardInPlay.suit
            )
            
            self.enableNextPlayer(currentPlayer)
        } else {
            
            self.presentEndOfGameMessage("No matches found. Restart game.")
        }
    }
    
    func enableNextPlayer(previousPlayer : Player) {
        
        if previousPlayer == .User {
            
            self.setPlayerButtonEnabled(.Computer)
            if !self.isSnap() {
                
                self.computerToPlay()
            }
        } else {
            
            self.setPlayerButtonEnabled(.User)
        }
        
        if self.isSnap() {
            
            var snapDelay : Double;
            switch self.gameLevel {
            case .Easy:
                snapDelay = 5
            case .Medium:
                snapDelay = 3
            case .Hard:
                snapDelay = 1
            }
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(snapDelay * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                
                [weak self] in
                self?.callSnap(.Computer)
            }
        }
    }
    
    func computerToPlay() {
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                
                [weak self] in
                self?.playCard(.Computer)
        }
    }
    
    func isSnap() -> Bool {
        
        return self.deckOfCards.previousCardInPlay?.rank == self.deckOfCards.currentCardInPlay?.rank &&
            self.deckOfCards.previousCardInPlay?.rank.characters.count > 0 &&
            self.deckOfCards.currentCardInPlay?.rank.characters.count > 0
    }
    
    func callSnap(player : Player) {
        
        if self.isSnap() && !self.gameOver {
            
            if player == .User {
                
                self.presentEndOfGameMessage("You won!")
            } else {
                
                self.presentEndOfGameMessage("You lost!")
            }
        }
    }
    
    func presentEndOfGameMessage(message : String) {
        
        self.gameOver = true
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: {
            
            [weak self] action in
            self?.dismissViewControllerAnimated(false, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func setPlayerButtonEnabled(currentPlayer : Player) {
        
        self.playerOneButton.enabled = currentPlayer == .User
    }
    
    // MARK: User interactions
    
    @IBAction func userPlayButtonPressed(sender: UIButton) {
        
        if self.isSnap() {
            
            self.presentEndOfGameMessage("You missed a snap!")
        } else {
            
           self.playCard(.User)
        }
    }
    
    @IBAction func userSnapButtonPressed(sender: SnapButton) {
        
        self.callSnap(.User)
    }
    
    @IBAction func quitButton(sender: UIButton) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}
