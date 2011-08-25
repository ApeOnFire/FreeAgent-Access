//
//  ProjectParser.h
//  AgentSpy
//
//  Created by Duncan Abbott on 20/07/2011.
//  Copyright 2011 Food for Benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FAProjectParser;
@class FAProject;

@protocol FAProjectParserDelegate <NSObject>

- (void)parser:(FAProjectParser *)parser didFinishWithProject:(FAProject *)project;
- (void)parser:(id)parser didFinishWithError:(NSError *)error;

@end


@interface FAProjectParser : NSObject <NSXMLParserDelegate> {
    
@private
    id <FAProjectParserDelegate> delegate;
    NSXMLParser *parser;
    
    FAProject *project;
    NSMutableString *currentStringValue;
}
@property (nonatomic,assign) id <FAProjectParserDelegate> delegate;
@property (nonatomic,retain) FAProject *project;

- (id)initWithData:(NSData *)data;
- (void)parseDocument;

@end
