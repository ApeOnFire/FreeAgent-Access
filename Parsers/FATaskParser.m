//
//  TaskParser.m
//  AgentSpy
//
//  Created by Duncan Abbott on 19/07/2011.
//  Copyright 2011 Food for Benjamin. All rights reserved.
//

#import "FATaskParser.h"
#import "FATask.h"


@interface FATaskParser()

@property (nonatomic,retain) NSXMLParser *parser;

@end


@implementation FATaskParser


- (id)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        // Initialization code here.
        NSXMLParser *p = [[NSXMLParser alloc] initWithData:data];
        p.delegate = self;
        self.parser = p;
        [p release];
    }
    return self;
}

- (void)dealloc
{
    self.task = nil;
    self.parser = nil;
    [super dealloc];
}

@synthesize delegate;
@synthesize parser;
@synthesize task;

- (void)parseDocument
{
    [parser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    FATask *t = [[FATask alloc] init];
    self.task = t;
    [t release];
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
    if ([elementName isEqualToString:@"task"]) {
        return;
    }
    if ([elementName isEqualToString:@"id"]) {
        task.taskId = [currentStringValue integerValue];
    }
    else if ([elementName isEqualToString:@"billing-period"]) {
        task.periodIsDay = ([currentStringValue isEqualToString:@"day"]);
    }
    else if ([elementName isEqualToString:@"billing-rate"]) {
        task.billingRate = [currentStringValue floatValue];
    }
    else if ([elementName isEqualToString:@"project-id"]) {
        task.projectId = [currentStringValue integerValue];
    }
    [currentStringValue release];
    currentStringValue = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [delegate parser:self didFinishWithTask:task];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [currentStringValue release];
    currentStringValue = nil;
    
    [delegate parser:self didFinishWithError:parseError];
}

@end
