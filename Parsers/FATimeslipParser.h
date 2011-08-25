//
//  TimeslipParser.h
//  AgentSpy
//
//  Created by Duncan Abbott on 19/07/2011.
//  Copyright 2011 Food for Benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FATimeslipParser;
@class FATimeslip;

@protocol FATimeslipParserDelegate <NSObject>

- (void)parser:(FATimeslipParser *)parser didFinishWithArray:(NSArray *)timeslips;
- (void)parser:(id)parser didFinishWithError:(NSError *)error;

@end

@interface FATimeslipParser : NSObject <NSXMLParserDelegate> {
    @private
    id <FATimeslipParserDelegate> delegate;
    NSXMLParser *parser;
    
    NSMutableArray *timeslips;
    FATimeslip *currentTimeslip;
    NSMutableString *currentStringValue;
}

@property (nonatomic,assign) id <FATimeslipParserDelegate> delegate;
@property (nonatomic,retain) NSArray *timeslips;

- (id)initWithData:(NSData *)data;
- (void)parseDocument;

@end
