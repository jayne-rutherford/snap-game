//
//  Deck.m
//  snap
//
//  Created by Jayne Rutherford on 16/01/2016.
//  Copyright © 2016 Jayne Rutherford. All rights reserved.
//

#import "Deck.h"
#import "Hand.h"

@interface Deck ()

@property (nonatomic, strong) NSMutableArray<Card *> *fullDeck;
@property (nonatomic, strong) NSMutableArray<Hand *> *hands;

@end

NSUInteger const MAX_NUM_CARDS_IN_DECK  = 52;
NSUInteger const NUM_HANDS              = 2;

@implementation Deck

# pragma mark - initialisation

- (instancetype)init {
    
    if (self = [super init]) {
        
        _fullDeck = [[NSMutableArray alloc] initWithCapacity:MAX_NUM_CARDS_IN_DECK];
        [self initialiseFullDeck];
        
         _hands = [[NSMutableArray alloc] init];
        [self deal:NUM_HANDS];
    }
    
    return self;
}

- (void)initialiseFullDeck {
    
    for (NSString *suit in [self validSuits]) {
        
        for (NSString *rank in [self validRanks]) {
            
            Card *playingCard = [[Card alloc] initWithSuit:suit rank:rank];
            [self.fullDeck addObject:playingCard];
        }
    }
}

- (NSArray *)validSuits {
    
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (NSArray *)validRanks {
    
    return @[@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K",@"A"];
}

- (void)deal:(NSInteger)numberOfHands {
    
    NSInteger maxCardsPerHand = ceil(MAX_NUM_CARDS_IN_DECK / numberOfHands);
    
    for (int n=1; n<=numberOfHands; n=n+1) {
        
        Hand *hand = [self drawHandForPlayer:maxCardsPerHand];
        [self.hands addObject:hand];
    }
    
}
-(Hand *)drawHandForPlayer:(NSInteger)maxCardsForHand {

    Hand *playerHand = [[Hand alloc] init];
    
    while ([playerHand.cardsInHand count] < maxCardsForHand) {
    
        Card *randomCard = [self drawRandomCard];
        
        if (randomCard) {
            
            [playerHand addCardToHand:randomCard];
        }
    }
    
    return playerHand;
}

- (Card *)drawRandomCard {
    
    Card *selectedCard;
    
    if (self.fullDeck.count > 0) {
        
        NSUInteger randomIndex = arc4random() % [self.fullDeck count];
        selectedCard = self.fullDeck[randomIndex];
        [self.fullDeck removeObject:selectedCard];
    }
   
    return selectedCard;
}

# pragma mark - game play

- (Card *)drawTopCardFromHand:(NSInteger)index {
    
    Hand *hand = [self.hands objectAtIndex:index];
    Card *cardToPlay = [hand.cardsInHand firstObject];
    [hand.cardsInHand removeObject:cardToPlay];
    
    self.previousCardInPlay = self.currentCardInPlay;
    self.currentCardInPlay = cardToPlay;
    
    return self.currentCardInPlay;
}

@end
