//
//  ArticleDatabase.h
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-10.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteDatabase.h"

@class Article;

@interface ArticleDatabase : NSObject
{
    SqliteDatabase *sqliteDatabase;
}
+(void) createDatabaseIfNotExists;
+(NSString *) filename;
+(ArticleDatabase *) sharedDatabase;

@end

@interface ArticleDatabase (Provider)

-(int) addArticle:(Article *) aArticle error:(NSError **)error;
-(int) deleteAllArticleserror:(NSError **)error;

-(NSMutableArray *)allArticles;
-(NSMutableArray *)selectArticleByArticleId:(int)articleId;

@end