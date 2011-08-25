//
//  TaskParser.h
//  AgentSpy
//
//  Created by Duncan Abbott on 19/07/2011.
//  Copyright 2011 Food for Benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FATaskParser;
@class FATask;

@protocol FATaskParserDelegate <NSObject>

- (void)parser:(FATaskParser *)parser didFinishWithTask:(FATask *)task;
- (void)parser:(id)parser didFinishWithError:(NSError *)error;

@end

@interface FATaskParser : NSObject <NSXMLParserDelegate> {
    
@private
    id <FATaskParserDelegate> delegate;
    NSXMLParser *parser;
    
    FATask *task;
    NSMutableString *currentStringValue;
}
@property (nonatomic,assign) id <FATaskParserDelegate> delegate;
@property (nonatomic,retain) FATask *task;

- (id)initWithData:(NSData *)data;
- (void)parseDocument;

@end
