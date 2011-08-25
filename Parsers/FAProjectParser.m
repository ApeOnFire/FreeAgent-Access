//
//  ProjectParser.m
//  AgentSpy
//
//  Created by Duncan Abbott on 20/07/2011.
//  Copyright 2011 Food for Benjamin. All rights reserved.
//

#import "FAProjectParser.h"
#import "FAProject.h"


@interface FAProjectParser()

@property (nonatomic,retain) NSXMLParser *parser;

@end


@implementation FAProjectParser

- (id)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        NSXMLParser *p = [[NSXMLParser alloc] initWithData:data];
        p.delegate = self;
        self.parser = p;
        [p release];
    }
    return self;
}

- (void)dealloc
{
    self.project = nil;
    self.parser = nil;
    [super dealloc];
}

@synthesize delegate;
@synthesize parser;
@synthesize project;

- (void)parseDocument
{
    [parser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    FAProject *p = [[FAProject alloc] init];
    self.project = p;
    [p release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!currentStringValue) {
        currentStringValue = [[NSMutableString alloc] initWithCapacity:50];
    }
    [currentStringValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"project"]) {
        return;
    }
    if ([elementName isEqualToString:@"id"]) {
        project.projectId = [currentStringValue integerValue];
    }
    else if ([elementName isEqualToString:@"contact-id"]) {
        project.contactId = [currentStringValue integerValue];
    }
    else if ([elementName isEqualToString:@"name"]) {
        project.name = currentStringValue;
    }
    else if ([elementName isEqualToString:@"currency"]) {
        project.currency = currentStringValue;
    }
    else if ([elementName isEqualToString:@"billing-period"]) {
        if ([currentStringValue isEqualToString:@"hour"]) {
            project.billingPeriod = FAProjectBillingPeriodHour;
        }
        else if ([currentStringValue isEqualToString:@"day"]) {
            project.billingPeriod = FAProjectBillingPeriodDay;
        }
    }
    else if ([elementName isEqualToString:@"budget"]) {
        project.budget = [currentStringValue integerValue];
    }
    else if ([elementName isEqualToString:@"budget-units"]) {
        if ([currentStringValue isEqualToString:@"Hours"]) {
            project.budgetUnits = FAProjectBudgetUnitsHours;
        }
        else if ([currentStringValue isEqualToString:@"Days"]) {
            project.budgetUnits = FAProjectBudgetUnitsDays;
        }
        else if ([currentStringValue isEqualToString:@"Monetary"]) {
            project.budgetUnits = FAProjectBudgetUnitsMonetary;
        }
    }
    else if ([elementName isEqualToString:@"hours-per-day"]) {
        project.hoursPerDay = [currentStringValue floatValue];
    }
    else if ([elementName isEqualToString:@"status"]) {
        if ([currentStringValue isEqualToString:@"Active"]) {
            project.status = FAProjectStatusActive;
        }
        else if ([currentStringValue isEqualToString:@"Completed"]) {
            project.status = FAProjectStatusCompleted;
        }
        else if ([currentStringValue isEqualToString:@"Cancelled"]) {
            project.status = FAProjectStatusCancelled;
        }
        else if ([currentStringValue isEqualToString:@"Inactive"]) {
            project.status = FAProjectStatusInactive;
        }
    }
    [currentStringValue release];
    currentStringValue = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [delegate parser:self didFinishWithProject:project];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [currentStringValue release];
    currentStringValue = nil;
    
    [delegate parser:self didFinishWithError:parseError];
}

@end
