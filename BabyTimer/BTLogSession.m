//
//  BTLogRecordList.m
//  BabyTimer
//
//  Created by hatemogi on 2014. 2. 14..
//  Copyright (c) 2014년 hatemogi. All rights reserved.
//

#import "BTLogSession.h"

@implementation BTLogSession

@synthesize sessionCount;

- (id)init
{
    if (self = [super init]) {
        timestamps = [NSMutableArray new];
    }
    return self;
}

- (BTLogSession *)prependSession
{
    BTLogSession *head = [BTLogSession new];
    head->next = self;
    return head;
}

- (BTLogSession *)reset
{
    BTLogSession *head = [BTLogSession new];
    head->next = self->next;
    return head;
}

- (NSUInteger)sessionCount
{
    if (next == nil) {
        return 1;
    } else {
        return [next sessionCount] + 1;
    }
}

- (BTLogSession *)nextSession:(NSUInteger)index
{
    if (index == 0) {
        return self;
    } else {
        return [next nextSession:index - 1]; // next가 nil이면 결과는 nil -> ok
    }
}

- (BTLogSession *)stamp:(NSDate *)at
{
    if (timestamps.count == 0) {
        [timestamps addObject:at];
    }
    NSLog(@"%f", [at timeIntervalSinceDate:self.lastStampAt]);
    if ([at timeIntervalSinceDate:self.lastStampAt] >= 1.0) {
        [timestamps addObject:at];
    }
    return self;
}

- (NSUInteger)stampCount
{
    return [timestamps count];
}

- (NSDate *)firstStampAt
{
    return [timestamps firstObject];
}

- (NSDate *)lastStampAt
{
    return [timestamps lastObject];
}

- (NSArray *)intervals
{
    __block NSDate *prev;
    __block NSMutableArray *dts = [NSMutableArray new];
    [timestamps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            prev = (NSDate *)obj;
        } else {
            NSDate *d = (NSDate *)obj;
            NSTimeInterval dt = [d timeIntervalSinceDate:prev];
            [dts addObject:@(dt)];
            prev = d;
        }
    }];
    return dts;
}

- (double)averageInterval
{
    NSArray *dts = [self intervals];
    if (dts.count == 0) return 0.0;
    NSTimeInterval sum = 0;
    for (NSNumber *n in dts) {
        sum += [n doubleValue];
    }
    return sum / dts.count;
}

- (NSArray *)records
{
    NSMutableArray *r = [NSMutableArray new];
    NSArray *dts = [self intervals];
    [timestamps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSTimeInterval dt = (idx == 0) ? 0.0 : [[dts objectAtIndex:idx - 1] doubleValue];
        BTLogRecord *record = [[BTLogRecord alloc] initAt:obj dt:dt];
        [r addObject:record];
    }];
    return [[r reverseObjectEnumerator] allObjects];
}

@end
