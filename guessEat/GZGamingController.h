//
//  GZGamingController.h
//  guessEat
//
//  Created by Stephen Zheng on 18/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPKeyboardAvoidingScrollView;
@class GZDatabaseController;
@class GZDish;


@interface GZGamingController : UIViewController{

}

@property(nonatomic,strong)  GZDatabaseController *databaseCrt;

@property(nonatomic,weak) IBOutlet TPKeyboardAvoidingScrollView *avoidScrollView;
@property(nonatomic,weak) IBOutlet UILabel *nameLable;
@property(nonatomic,weak) IBOutlet UILabel *descripLable;
@property(nonatomic,weak) IBOutlet UIButton *click;
@property(nonatomic,weak) IBOutlet UIImageView *dish_imageView;

@property(nonatomic,weak) IBOutlet UITextField *testField;
@property(nonatomic,strong)  GZDish *dish;

-(IBAction)Click:(id)sender;
-(IBAction)searchFromDB:(id)sender;



@end
