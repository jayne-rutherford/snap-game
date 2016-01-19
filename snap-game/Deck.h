//
//  Deck.h
//  snap
//
//  Created by Jayne Rutherford on 16/01/2016.
//  Copyright © 2016 Jayne Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

@property (nonatomic, strong) Card *currentCardInPlay;
@property (nonatomic, strong) Card *previousCardInPlay;

- (Card *)drawTopCardFromHand:(NSInteger)index;

@end
