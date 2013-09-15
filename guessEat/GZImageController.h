//
//  GZImageController.h
//  guessEat
//
//  Created by Stephen Zheng on 23/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GZDatabaseController;
@class GZDish;

@interface GZImageController : UIViewController{
    
}

@property(nonatomic,weak) IBOutlet UIImage *image;
@property(nonatomic,strong)  GZDatabaseController *databaseCrt;
@property(nonatomic,strong)  GZDish *dish;
@property(nonatomic,weak) IBOutlet UIImageView *imageView;
-(NSArray *)fetchDishFromDBwithProvince_id:(NSInteger)province;
@end
