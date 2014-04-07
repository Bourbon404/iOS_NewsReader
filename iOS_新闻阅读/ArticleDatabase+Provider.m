//
//  ArticleDatabase+Provider.m
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-10.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import "ArticleDatabase.h"
#import "Article.h"
@implementation ArticleDatabase (Provider)

-(int)addArticle:(Article *)aArticle error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"insert into Articles(title,link)values('%@','%@');",aArticle.title,aArticle.link];
    int lastRowId;
    int rc = [sqliteDatabase executeNonQuery:sql outputLastInsertRowId:&lastRowId error:error];
    if (rc == SQLITE_OK)
    {
        aArticle.aId = lastRowId;
    }
    return rc;
}

-(int)deleteAllArticleserror:(NSError *__autoreleasing *)error
{
    NSString *sql = @"delete from articles;";
    int rc = [sqliteDatabase executeNonQuery:sql error:error];
    return rc;
}

-(NSMutableArray *)allArticles
{
    NSString *sql = @"select *from Articles;";
    [sqliteDatabase open];
    SqliteDataReader *dr = [sqliteDatabase executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    if (dr != nil)
    {
        while ([dr read])
        {
            Article *article = [[Article alloc] init];
            article.aId = [dr integerValueForColumnIndex:0];
            article.title = [dr stringValueForColumnIndex:1];
            article.link = [NSURL URLWithString:[dr stringValueForColumnIndex:2]];
            
            [array addObject:article];
        }
        [dr close];
    }
    [sqliteDatabase close];
    return array;
}

-(NSMutableArray *)selectArticleByArticleId:(int)articleId
{
    Article *article = nil;
    NSString *sql = [NSString stringWithFormat:@"select *from Articles where aId = %i;",articleId];
    [sqliteDatabase open];
    SqliteDataReader *dr = [sqliteDatabase executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    
    if (dr != nil)
    {
        while ([dr read])
        {
            article = [[Article alloc] init];
            article.aId = [dr integerValueForColumnIndex:0];
            article.title = [dr stringValueForColumnIndex:1];
            article.link = [NSURL URLWithString:[dr stringValueForColumnIndex:2]];
            
            [array addObject:article];
        }
        [dr close];
    }
    [sqliteDatabase close];
    return array;
}

@end
