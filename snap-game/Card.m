//
//  Card.m
//  snap
//
//  Created by Jayne Rutherford on 16/01/2016.
//  Copyright © 2016 Jayne Rutherford. All rights reserved.
//

#import "Card.h"

@implementation Card

- (instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank {
    
    if (self = [super init]) {
        
        _suit = suit;
        _rank = rank;
    }
    
    return self;
}

@end
