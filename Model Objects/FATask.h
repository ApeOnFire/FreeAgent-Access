//
//  Task.h
//  AgentSpy
//
//  Created by Duncan Abbott on 19/07/2011.
//  Copyright 2011 Food for Benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FATimeslip;

@interface FATask : NSObject {
    
@private
    NSUInteger taskId;
    NSUInteger projectId;
    BOOL periodIsDay;
    float billingRate;
}

@property (nonatomic) NSUInteger taskId;
@property (nonatomic) NSUInteger projectId;
@property (nonatomic) BOOL periodIsDay;
@property (nonatomic) float billingRate;

@end
