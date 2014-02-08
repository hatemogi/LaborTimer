//
//  BTTimer.m
//  BabyTimer
//
//  Created by hatemogi on 2014. 2. 7..
//  Copyright (c) 2014년 hatemogi. All rights reserved.
//

#import "BTTimer.h"

@implementation BTTimer {
    NSTimer *timer;
    NSMutableArray *list;
}

- (id)init
{
    if (self = [super init]) {
        list = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)relax
{
    
}

- (void)signal
{
    [self signal:[NSDate date]];
}

- (void)signal:(NSDate *)time
{
    [list addObject:time];
    NSLog(@"%@", list);
}

- (NSDate *)lastTimestamp
{
	if ([list count] > 0) {
		return [list lastObject];
	}
	return [NSDate date];
}

@end
