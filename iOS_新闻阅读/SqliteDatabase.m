//
//  SqliteDatabase.m
//  Ablums_MVC
//
//  Created by Bourbon on 13-9-3.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "SqliteDatabase.h"
#import "SqliteDataReader.h"

@implementation SqliteDatabase

- (id)initWithFilename:(NSString *)aFilename{
    self=[super init];
    if (self) {
        filename=[aFilename copy];
        database=NULL;
    }
    return self;
}


- (int)open{
    int rc=sqlite3_open([filename UTF8String], &database);
    if (rc) {
        sqlite3_close(database);
        NSLog(@"open database failed!");
    }
    return rc;
}

- (void)close{
    if (database != NULL) {
        sqlite3_close(database);
    }
}

- (int)executeNonQuery:(NSString *)sql error:(NSError **)error{
    return [self executeNonQuery:sql openAutomatically:YES error:error];
}

- (int)executeNonQuery:(NSString *)sql outputLastInsertRowId:(int *)lastInsertRowId error:(NSError **)error{
    int rc;
    rc=[self open];
    //打开数据库失败，返回错误对象error
    if (rc != SQLITE_OK) {
        if (error != NULL) {
            NSDictionary *eDict=[NSDictionary dictionaryWithObject:@"open database failed" forKey:NSLocalizedDescriptionKey];
            *error=[NSError errorWithDomain:kSqliteErrorDomain code:rc userInfo:eDict];
        }
        
        return rc;
    }
    //执行insert SQL语句
    rc = [self executeNonQuery:sql openAutomatically:NO error:error];
    if (rc != SQLITE_OK) {
        return rc;
    }
    //插入成功，读取主键编号
    SqliteDataReader *dr=[self executeQuery:@"select last_insert_rowid()"];
    if (dr==nil) {
        //读取主键编号失败，返回错误对象error
        if (error != NULL) {
            NSDictionary *eDict=[NSDictionary dictionaryWithObject:@"select last insert rowid failed" forKey:NSLocalizedDescriptionKey];
            *error=[NSError errorWithDomain:kSqliteErrorDomain code:rc userInfo:eDict];
        }
        
        NSLog(@"select last insert rowid failed");
        return SQLITE_ERROR;
    }
    //读数据
    if ([dr read]) {
        *lastInsertRowId=[dr integerValueForColumnIndex:0];
    }
    //关闭DataReader
    [dr close];
    //关闭数据库
    [self close];
    
    return rc;
}

- (int)executeNonQuery:(NSString *)sql openAutomatically:(BOOL)openAutomaticlly error:(NSError **)error{
    int rc;
    char *errmsg;
    
    //判断是否自动打开数据库
    if (openAutomaticlly) {
        rc = [self open];
        if (rc) {//错误处理
            if (error != NULL) {
                NSDictionary *eDict=[NSDictionary dictionaryWithObject:@"open database failed" forKey:NSLocalizedDescriptionKey];
                *error=[NSError errorWithDomain:kSqliteErrorDomain code:rc userInfo:eDict];
            }
            
            return rc;
        }
    }
    //执行SQL
    rc=sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errmsg);
    
    if (rc!=SQLITE_OK) {//错误处理
        if (error != NULL) {
            NSDictionary *eDict=[NSDictionary dictionaryWithObject:[NSString stringWithUTF8String:errmsg] forKey:NSLocalizedDescriptionKey];
            *error=[NSError errorWithDomain:kSqliteErrorDomain code:rc userInfo:eDict];
        }
        
        NSLog(@"%s",errmsg);
        sqlite3_free(errmsg);
    }
    //判断是否自动关闭数据库
    if (openAutomaticlly) {
        [self close];
    }
    
    return rc;
}

- (SqliteDataReader *)executeQuery:(NSString *)sql{
    sqlite3_stmt *statement;
    int rc = sqlite3_prepare(database, [sql UTF8String], -1, &statement, NULL);
    if (rc!=SQLITE_OK) {
        NSLog(@"prepare statement failed!");
        return nil;
    }
    
    return [[SqliteDataReader alloc] initWithStatement:statement];
}

@end
