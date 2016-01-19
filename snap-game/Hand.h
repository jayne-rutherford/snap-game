//
//  Hand.h
//  snap-game
//
//  Created by Jayne Rutherford on 18/01/2016.
//  Copyright © 2016 Jayne Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Hand : NSObject

@property (nonatomic, strong) NSMutableArray<Card *> *cardsInHand;
- (void)addCardToHand:(Card *)card;

@end
