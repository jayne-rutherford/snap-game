//
//  Card.h
//  snap
//
//  Created by Jayne Rutherford on 16/01/2016.
//  Copyright © 2016 Jayne Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSString *rank;
@property (nonatomic, strong) NSString *suit;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank NS_DESIGNATED_INITIALIZER;

@end
