//
//  DeckTests.m
//  snap-game
//
//  Created by Jayne Rutherford on 19/01/2016.
//  Copyright © 2016 Jayne Rutherford. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "Deck.h"
#import "Hand.h"

@interface Deck ()

@property (nonatomic, strong) NSMutableArray<Hand *> *hands;

@end

@interface DeckTests : XCTestCase

@end

@implementation DeckTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTwoHandsDealtForDeck {
    
    Deck *testDeck = [[Deck alloc] init];
    
    XCTAssertEqual([testDeck.hands count], 2);
}

- (void)testTotalCardsInAllHandsEqualsFiftyTwo {
    
    Deck *testDeck = [[Deck alloc] init];
    
    NSInteger totalNumberOfCards = 0;
    
    for (Hand *hand in testDeck.hands) {
        totalNumberOfCards = totalNumberOfCards + [hand.cardsInHand count];
    }
    
    XCTAssertEqual(totalNumberOfCards, 52);
}

- (void)testTopCardDrawnFromHand {
    
    Deck *testDeck = [[Deck alloc] init];
    id deckPartialMock = OCMPartialMock(testDeck);
    
    NSString *expectedFirstSuit = @"foo";
    NSString *expectedFirstRank = @"1";
    NSString *expectedSecondSuit = @"bar";
    NSString *expectedSecondRank = @"2";
    
    Card *mockCard1 = [[Card alloc] initWithSuit:expectedFirstSuit rank:expectedFirstRank];
    Card *mockCard2 = [[Card alloc] initWithSuit:expectedSecondSuit rank:expectedSecondRank];
    
    Hand *mockHand1 = [[Hand alloc] init];
    [mockHand1 addCardToHand:mockCard1];
    [mockHand1 addCardToHand:mockCard2];
    
    NSMutableArray *mockHands = [[NSMutableArray alloc] init];
    [mockHands addObject:mockHand1];
    
    OCMStub([deckPartialMock hands]).andReturn(mockHands);
    
    Card *firstCard = [deckPartialMock drawTopCardFromHand:0];
    XCTAssertEqual(firstCard.rank, expectedFirstRank);
    XCTAssertEqual(firstCard.suit, expectedFirstSuit);
    XCTAssertNil([deckPartialMock previousCardInPlay]);
    XCTAssertEqual([deckPartialMock currentCardInPlay], firstCard);
    
    Card *secondCard = [deckPartialMock drawTopCardFromHand:0];
    XCTAssertEqual(secondCard.rank, expectedSecondRank);
    XCTAssertEqual(secondCard.suit, expectedSecondSuit);
    XCTAssertEqual([deckPartialMock previousCardInPlay], firstCard);
    XCTAssertEqual([deckPartialMock currentCardInPlay], secondCard);
}

@end
