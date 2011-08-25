//
//  Timeslip.h
//  AgentSpy
//
//  Created by Duncan Abbott on 19/07/2011.
//  Copyright 2011 Food for Benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FATimeslip : NSObject {
    
@private
    NSUInteger timeslipId;
    float hours;
    BOOL decimalHours;
    NSUInteger userId;
    NSUInteger projectId;
    NSUInteger taskId;
    NSString *comment;
    BOOL locked;
}
@property (nonatomic) NSUInteger timeslipId;
@property (nonatomic) float hours;
@property (nonatomic) BOOL decimalHours;
@property (nonatomic) NSUInteger userId;
@property (nonatomic) NSUInteger projectId;
@property (nonatomic) NSUInteger taskId;
@property (nonatomic,retain) NSString *comment;
@property (nonatomic) BOOL locked;

@end
