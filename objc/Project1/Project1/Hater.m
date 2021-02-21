//
//  Hater.m
//  Project1
//
//  Created by Jinwoo Kim on 2/22/21.
//

#import "Hater.h"

@implementation Hater

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.hating = NO;
    }
    
    return self;
}

- (void)hadABadDay {
    self.hating = YES;
}

- (void)hadAGoodDay {
    self.hating = NO;
}

@end
