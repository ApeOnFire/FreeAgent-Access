//
//  TimeslipParser.m
//  AgentSpy
//
//  Created by Duncan Abbott on 19/07/2011.
//  Copyright 2011 Food for Benjamin. All rights reserved.
//

#import "FATimeslipParser.h"
#import "FATimeslip.h"

@interface FATimeslipParser()

@property (nonatomic,retain) NSXMLParser *parser;

@end


@implementation FATimeslipParser

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
    self.timeslips = nil;
    self.parser = nil;
    [super dealloc];
}

@synthesize delegate;
@synthesize parser;
@synthesize timeslips;

- (void)parseDocument
{
    [parser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    self.timeslips = arr;
    [arr release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"timeslips"]) {
        return;
    }
    if ([elementName isEqualToString:@"timeslip"]) {
        currentTimeslip = [[FATimeslip alloc] init];
        return;
    }
    if ([elementName isEqualToString:@"hours"]) {
        NSString *type = [attributeDict objectForKey:@"type"];
        if (type && [type isEqualToString:@"decimal"]) {
            currentTimeslip.decimalHours = YES;
        }
        return;
    }
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
    if ([elementName isEqualToString:@"timeslips"]) {
        return;
    }
    if ([elementName isEqualToString:@"timeslip"]) {
        [timeslips addObject:currentTimeslip];
        [currentTimeslip release];
        return;
    }
    if ([elementName isEqualToString:@"id"]) {
        currentTimeslip.timeslipId = [currentStringValue integerValue];
    }
    else if ([elementName isEqualToString:@"hours"]) {
        currentTimeslip.hours = [currentStringValue floatValue];
    }
    else if ([elementName isEqualToString:@"user-id"]) {
        currentTimeslip.userId = [currentStringValue integerValue];
    }
    else if ([elementName isEqualToString:@"project-id"]) {
        currentTimeslip.projectId = [currentStringValue integerValue];
    }
    else if ([elementName isEqualToString:@"task-id"]) {
        currentTimeslip.taskId = [currentStringValue integerValue];
    }
    else if ([elementName isEqualToString:@"comment"]) {
        currentTimeslip.comment = currentStringValue;
    }
    else if ([elementName isEqualToString:@"status"]) {
        currentTimeslip.locked = [currentStringValue isEqualToString:@"Locked"];
    }
    [currentStringValue release];
    currentStringValue = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [delegate parser:self didFinishWithArray:timeslips];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [currentTimeslip release];
    [currentStringValue release];
    currentStringValue = nil;
    
    [delegate parser:self didFinishWithError:parseError];
}

@end
