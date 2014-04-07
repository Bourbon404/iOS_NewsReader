//
//  ArticleManager.h
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-10.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BUSINESS_ERROR_DOMAIN @"BUSINESS_ERROR_DOMAIN"
@class Article;

@interface ArticleManager : NSObject
{
    NSMutableArray *allAritcle;
}
+(ArticleManager *)defaultManager;

-(int) addArticle:(Article *) aArticle error:(NSError **)error;
-(int) deleteAllArticleserror:(NSError **)error;

-(NSMutableArray *)allArticles;
-(NSMutableArray *)selectArticleByArticleId:(int)articleId;

@end
