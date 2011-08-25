//
//  Project.h
//  AgentSpy
//
//  Created by Duncan Abbott on 20/07/2011.
//  Copyright 2011 Food for Benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FAProjectStatusActive,
    FAProjectStatusCompleted,
    FAProjectStatusCancelled,
    FAProjectStatusInactive
}FAProjectStatus;

typedef enum {
    FAProjectBillingPeriodHour,
    FAProjectBillingPeriodDay
}FAProjectBillingPeriod;

typedef enum {
    FAProjectBudgetUnitsHours,
    FAProjectBudgetUnitsDays,
    FAProjectBudgetUnitsMonetary
}FAProjectBudgetUnits;

@interface FAProject : NSObject {

@private
    NSUInteger projectId;
    NSUInteger contactId;
    NSString *name;
    NSString *currency;
    FAProjectBillingPeriod billingPeriod;
    NSUInteger budget;
    FAProjectBudgetUnits budgetUnits;
    float hoursPerDay;
    FAProjectStatus status;
}
@property (nonatomic) NSUInteger projectId;
@property (nonatomic) NSUInteger contactId;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *currency;
@property (nonatomic) FAProjectBillingPeriod billingPeriod;
@property (nonatomic) NSUInteger budget;
@property (nonatomic) FAProjectBudgetUnits budgetUnits;
@property (nonatomic) float hoursPerDay;
@property (nonatomic) FAProjectStatus status;

@end
