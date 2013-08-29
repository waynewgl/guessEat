//
//  GZDatabaseHelper.m
//  guessEat
//
//  Created by Guiwei LIN on 8/23/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZDatabaseHelper.h"
#import "GZDish.h"

@implementation GZDatabaseHelper


+ (GZDatabaseHelper *)sharedInstance
{
    static GZDatabaseHelper *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] init];
    });
    return _sharedClient;
}

- (id)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    //combine the path of external database and document directory
    myDatabasePath=[[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"ios_eat_v2"]];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"ios_eat_v2" ofType:@""];
    
    DLog(@"current path is ---- %@" , path);
    
    /*
    NSError *error = nil;
    
    //copy external database to document directory
    [[NSFileManager defaultManager] copyItemAtPath:path toPath:myDatabasePath error:&error];
    
    //judge the database is it existed
    NSFileManager *filmanager = [NSFileManager defaultManager];
    if ([filmanager fileExistsAtPath:myDatabasePath] == NO) {
        DLog(@"the database not exist");
    }
    else{
        DLog(@"file is exist");
    }*/


    return self;
}

- (NSArray *)queryFromDataBase
{
    const char *dbpath = [myDatabasePath UTF8String];
    sqlite3_stmt *statement;
    NSMutableArray *dish_array=[[NSMutableArray alloc]initWithCapacity:5];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT dishes_id, kind, name, description from dishes"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                GZDish *dish  = [[GZDish alloc]init];
                
                NSString *dishesID = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                DLog(@"id is %@", dishesID);
                dish.dish_id = dishesID;
                DLog(@"after ID be printed %@", @"");
                
                NSString *disheskind = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1    )];
                DLog(@"kind is: %@", disheskind);
                dish.dish_kind = disheskind;
                
                NSString *dish_name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2    )];
                DLog(@"name is: %@", dish_name);
                dish.dish_name = dish_name;
                
                NSString *dish_discript = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3    )];
                DLog(@"description is: %@", dish_discript);
                dish.dish_description = dish_discript;
                
                [dish_array addObject:dish];
                
            }
            
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    return dish_array;
}


- (NSString *)searchDataBase:(int)dishID
{
    const char *dbpath = [myDatabasePath UTF8String];
    sqlite3_stmt *statement;
    NSString *searchResult=[[NSString alloc]init];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT name from contacts id=\"%d\"",dishID];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *result= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                DLog(@"search result: %@", searchResult);
                searchResult=result;
            }
            else {
                DLog(@"search failed %@", @"");
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    return searchResult;
}




@end