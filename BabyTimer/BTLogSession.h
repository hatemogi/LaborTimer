//
//  BTLogRecordList.h
//  BabyTimer
//
//  Created by hatemogi on 2014. 2. 14..
//  Copyright (c) 2014년 hatemogi. All rights reserved.
//

#import "BTLogRecord.h"

@interface BTLogSession : NSObject {
    NSMutableArray *timestamps;
    BTLogSession *next;
}

@property (readonly) NSDate *firstStampAt;
@property (readonly) NSDate *lastStampAt;
@property (readonly) double averageInterval;
@property (readonly) double standardDeviation;
@property (readonly) NSUInteger sessionCount;
@property (readonly) NSUInteger stampCount;

// 진통 타임 스탬프 찍기. 세션 알아서 구분.
- (BTLogSession *)stamp:(NSDate *)at;
- (BTLogSession *)cancelStamp:(NSUInteger)index;
- (BTLogSession *)prependSession;
- (BTLogSession *)nextSession:(NSUInteger)index;
- (BTLogSession *)reset;
- (NSArray *)records;

@end
