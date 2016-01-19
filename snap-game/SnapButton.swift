//
//  SnapButton.swift
//  snap-game
//
//  Created by Jayne Rutherford on 19/01/2016.
//  Copyright © 2016 Jayne Rutherford. All rights reserved.
//

import UIKit

class SnapButton: UIButton {
    
    // MARK: Initialisation
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        self.setImage(UIImage(named: "snap_hand"), forState: UIControlState.Normal)
        self.imageView?.layer.cornerRadius = 5
    }
}
