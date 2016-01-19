//
//  Hand.m
//  snap-game
//
//  Created by Jayne Rutherford on 18/01/2016.
//  Copyright © 2016 Jayne Rutherford. All rights reserved.
//

#import "Hand.h"

@implementation Hand

- (instancetype)init {
    
    if (self = [super init]) {
        
        _cardsInHand = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addCardToHand:(Card *)card {
    
    [self.cardsInHand addObject:card];
}

@end
