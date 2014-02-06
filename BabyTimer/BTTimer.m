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
    if ([super init]) {
        list = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)relax
{
    
}

- (void)signal
{
    
}

@end
