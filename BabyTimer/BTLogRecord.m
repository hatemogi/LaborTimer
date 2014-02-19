//
//  BTLogRecord.m
//  BabyTimer
//
//  Created by hatemogi on 2014. 2. 7..
//  Copyright (c) 2014년 hatemogi. All rights reserved.
//

#import "BTLogRecord.h"

@implementation BTLogRecord {
    NSDate *_at;
    NSTimeInterval _dt;
}

-(id)initAt:(NSDate *)at
{
    if (self = [super init]) {
        _at = at;
        _dt = BTIntervalUnknown;
    }
    return self;
}

-(id)initAt:(NSDate *)at dt:(NSTimeInterval)dt
{
    if (self = [super init]) {
        _at = at;
        _dt = dt;
    }
    return self;
}

@end
