//
//  NSMutableArray+shuffle.m
//  guessEat
//
//  Created by Guiwei LIN on 9/18/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray(Shuffle)


-(void)shuffle
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}


@end
