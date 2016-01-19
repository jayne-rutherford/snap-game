//
//  PlayerCardView.swift
//  snap-game
//
//  Created by Jayne Rutherford on 18/01/2016.
//  Copyright © 2016 Jayne Rutherford. All rights reserved.
//

import UIKit

class PlayerCardView: UIView {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    // MARK: Initialisation
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        let view = loadViewFromNib(fileName: "PlayerCardView")
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.blackColor().CGColor
        
        self.addSubview(view)
    }
    
    func loadViewFromNib(fileName fileName: String) -> UIView
    {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: fileName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    // MARK: Display
    
    func setDrawnCard(rank : String?, suit : String?) {
        
        let displayText = String(format: "%@%@", rank ?? "", suit ?? "")
        topLabel.text = displayText
        bottomLabel.text = displayText
    }
    
}
