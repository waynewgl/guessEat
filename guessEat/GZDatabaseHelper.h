//
//  GZDatabaseHelper.h
//  guessEat
//
//  Created by Guiwei LIN on 8/23/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <sqlite3.h>
#import "GZDish.h"

@interface GZDatabaseHelper : NSObject{
    
    
    sqlite3 *contactDB;
    NSString *myDatabasePath;
}


+ (GZDatabaseHelper *)sharedInstance;

- (NSString *)searchDataBase:(int)dishID;
- (NSArray *)queryFromDataBase;
- (GZDish *)queryDishFromDatabase:(int)dish_id;

@end
