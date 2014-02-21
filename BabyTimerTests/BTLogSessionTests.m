//
//  BTLogRecordListTests.m
//  BabyTimer
//
//  Created by hatemogi on 2014. 2. 14..
//  Copyright (c) 2014년 hatemogi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BTLogSession.h"

@interface BTLogSessionTests : XCTestCase {
    BTLogSession *session;
    NSDate *t1, *t2, *t3;
}

@end

@implementation BTLogSessionTests

- (void)setUp
{
    [super setUp];
    session = [[BTLogSession alloc] init];
    t1 = [NSDate dateWithTimeIntervalSinceNow:-3600];
    t2 = [NSDate dateWithTimeInterval:60 sinceDate:t1];
    t3 = [NSDate dateWithTimeInterval:30 sinceDate:t2];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCount
{
    XCTAssertEqual((NSUInteger)1, session.sessionCount, "처음 상태는 단 한개의 세션");
    session = [session prependSession];
    XCTAssertEqual((NSUInteger)2, session.sessionCount, "하나 추가하면 두개의 세션");
    session = [session prependSession];
    XCTAssertEqual((NSUInteger)3, session.sessionCount, "또 추가하면 세개의 세션");
}

- (void)testNext
{
    XCTAssertEqual(session, [session nextSession:0], "0번째 next는 자기자신");
    XCTAssertNil([session nextSession:1], "한개짜리 세션의 다음 것은 nil");
    BTLogSession *other = [session prependSession];
    XCTAssertEqual(session, [other nextSession:1], "새로 붙인 세션의 첫번째 다음 것은 원래 세션");
    BTLogSession *ns = nil;
    XCTAssertNil([ns nextSession:1]);
}

- (void)testStamp
{
    XCTAssertNil([session firstStampAt]);
    XCTAssertNil([session lastStampAt]);
    XCTAssertEqual((NSUInteger)0, session.stampCount);
    
    session = [session stamp:t1];
    XCTAssertEqual((NSUInteger)1, session.stampCount);
    XCTAssertEqualObjects(t1, [session firstStampAt]);
    XCTAssertEqualObjects(t1, [session lastStampAt]);
    
    session = [session stamp:t2];
    XCTAssertEqual((NSUInteger)2, session.stampCount);
    XCTAssertEqualObjects(t1, [session firstStampAt]);
    XCTAssertEqualObjects(t2, [session lastStampAt]);
}

- (void)testAverageInterval
{
    XCTAssertEqualWithAccuracy(0.0, session.averageInterval, 0.001);

    session = [session stamp:t1];
    XCTAssertEqualWithAccuracy(0.0, session.averageInterval, 0.001);

    session = [session stamp:t2];
    XCTAssertEqualWithAccuracy(60.0, session.averageInterval, 0.001);

    session = [session stamp:t3];
    XCTAssertEqualWithAccuracy(45.0, session.averageInterval, 0.001);
}

- (void)testRecords
{
    XCTAssertEqual((NSUInteger)0, session.records.count);

    session = [[[session stamp:t1] stamp:t2] stamp:t3];
    NSArray *recs = session.records;
    XCTAssertEqual((NSUInteger)3, recs.count);
    
    BTLogRecord *r[] = {recs[0], recs[1], recs[2]};
    XCTAssertEqualObjects(t3, r[0].at);
    XCTAssertEqualObjects(t2, r[1].at);
    XCTAssertEqualObjects(t1, r[2].at);
    
    XCTAssertEqualWithAccuracy(30, r[0].dt, 0.001);
    XCTAssertEqualWithAccuracy(60, r[1].dt, 0.001);
    XCTAssertEqualWithAccuracy( 0, r[2].dt, 0.001);
}

- (void)testReset
{
    session = [[[session stamp:t1] stamp:t2] stamp:t3];
    XCTAssertEqual((NSUInteger)3, session.stampCount);
    session = [session reset];
    XCTAssertEqual((NSUInteger)0, session.stampCount);
    

}

@end
