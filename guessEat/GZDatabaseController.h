//
//  GZDatabaseController.h
//  guessEat
//
//  Created by Stephen Zheng on 22/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface GZDatabaseController : UIViewController{
    sqlite3 *contactDB;
    NSString *myDatabasePath;
}
-(NSArray *)queryFromDataBase;

@end
