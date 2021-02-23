//
//  ThrowingTests.m
//  Project2Tests
//
//  Created by Jinwoo Kim on 2/24/21.
//

#import <XCTest/XCTest.h>

typedef NS_ENUM(NSUInteger, GameError) {
    GameErrorNotPurchased, GameErrorNotInstalled, GameErrorParentalControlsDisallowed
};

@interface Game : NSObject
@property NSString *name;
- (void)play:(NSError * __autoreleasing _Nullable *)error;
@end

@implementation Game
- (Game *)initWithName:(NSString *)name {
    self = [super init];
    if (self) self.name = name;
    return self;
}

- (void)play:(NSError *__autoreleasing  _Nullable *)error {
    if ([self.name isEqualToString:@"BioBlitz"]) {
        *error = [[NSError alloc] initWithDomain:@"GameErrorNotPurchased" code:GameErrorNotPurchased userInfo:@{NSLocalizedDescriptionKey: @"GameErrorNotPurchased"}];
    } else if ([self.name isEqualToString:@"Blastazap"]) {
        *error = [[NSError alloc] initWithDomain:@"GameErrorNotInstalled" code:GameErrorNotInstalled userInfo:@{NSLocalizedDescriptionKey: @"GameErrorNotInstalled"}];
    } else if ([self.name isEqualToString:@"Dead Storm Rising"]) {
        *error = [[NSError alloc] initWithDomain:@"GameErrorParentalControlsDisallowed" code:GameErrorParentalControlsDisallowed userInfo:@{NSLocalizedDescriptionKey: @"GameErrorParentalControlsDisallowed"}];
    } else {
        NSLog(@"%@ is OK to play!", self.name);
    }
}
@end

@interface ThrowingTests : XCTestCase

@end

@implementation ThrowingTests
- (void)testPlayingBioBlitzThrows {
    Game *game = [[Game alloc] initWithName:@"BioBlitz"];
    
    NSError * __autoreleasing _Nullable error = nil;
    [game play:&error];
    
    if (error == nil) {
        XCTFail(@"BioBlitz has not been purchased");
    } else if (error.code == GameErrorNotPurchased) {
        // success!
    } else {
        XCTFail();
    }
}
@end
