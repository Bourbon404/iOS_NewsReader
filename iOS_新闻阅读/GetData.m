//
//  GetData.m
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-10.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import "GetData.h"

#import "ArticleManager.h"

static NSXMLParser *_parser;
@implementation GetData

-(void)inputUrl
{
    NSURL *url = [NSURL URLWithString:@"http://zhihudaily.sinaapp.com/rss.xml"];
    
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    [urlCache setMemoryCapacity:1*1024*1024];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:60.0f];
    
//    if (request != nil)
//    {
//        NSLog(@"从缓存中读取");
//        [request setCachePolicy:(NSURLRequestReturnCacheDataDontLoad)];
//    }
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                  _parser = [[NSXMLParser alloc] initWithData:data];
                                  [_parser setDelegate:self];
                                  [_parser parse];
    }];

}

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    _menus = [[NSMutableArray alloc] initWithCapacity:0];
    [_menus removeAllObjects];
    
    _currentElement = [[NSMutableString alloc] init];
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [_currentElement appendFormat:@"/%@",elementName];
    if ([@"/rss/channel/item" isEqualToString:_currentElement])
    {
        _currentArticle = [[Article alloc] init];
    }
}
-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    if (_currentArticle != nil)
    {
        NSString *s = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        if ([@"/rss/channel/item/title" isEqualToString:_currentElement])
        {
            _currentArticle.title = s;
        }
        else if ([@"/rss/channel/item/content:encoded" isEqualToString:_currentElement])
        {
//            if ([@"h2" isEqualToString:_currentElement])
//            {
                _currentArticle.subTitle = s;
//            }
        }
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_currentArticle != nil)
    {
        if ([@"/rss/channel/item/link" isEqualToString:_currentElement])
        {
            _currentArticle.link = [NSURL URLWithString:string];
        }
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [_currentElement replaceOccurrencesOfString:[NSString stringWithFormat:@"/%@",elementName] withString:@"" options:NSBackwardsSearch range:NSMakeRange(0, [_currentElement length])];
    
    if ([@"item" isEqualToString:elementName] && [@"/rss/channel" isEqualToString:_currentElement])
    {
        [_menus addObject:_currentArticle];
        _currentArticle = nil;
    }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    for (Article *tmp in _menus)
    {
        [[ArticleManager defaultManager] addArticle:tmp error:nil];
    }
    
//    NSLog(@"%@",_menus);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"data" object:_menus];
}




@end
