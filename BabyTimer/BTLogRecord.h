//
//  BTLogRecord.h
//  BabyTimer
//
//  Created by hatemogi on 2014. 2. 7..
//  Copyright (c) 2014년 hatemogi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTLogRecord : NSObject

@property (readonly) NSDate *at;
@property (readonly) NSTimeInterval dt;

-(id)initAt:(NSDate *)at dt:(NSTimeInterval)dt;
@end
