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


@interface GZGamingController : UIViewController{
//    IBOutlet UILabel *nameLable;
//    IBOutlet UILabel *descripLable;
//    IBOutlet UIButton *click;
//    IBOutlet UIImageView *image0;
//    IBOutlet UIImageView *image1;
//    IBOutlet UIImageView *image2;
//    IBOutlet UIImageView *image3;
    
}

@property(nonatomic,strong)  GZDatabaseController *databaseCrt;

@property(nonatomic,weak) IBOutlet TPKeyboardAvoidingScrollView *avoidScrollView;
@property(nonatomic,weak) IBOutlet UILabel *nameLable;
@property(nonatomic,weak) IBOutlet UILabel *descripLable;
@property(nonatomic,weak) IBOutlet UIButton *click;
@property(nonatomic,weak) IBOutlet UIImageView *image0;
@property(nonatomic,weak) IBOutlet UIImageView *image1;
@property(nonatomic,weak) IBOutlet UIImageView *image2;
@property(nonatomic,weak) IBOutlet UIImageView *image3;
@property(nonatomic,weak) IBOutlet UITextField *testField;

-(IBAction)Click:(id)sender;
-(IBAction)searchFromDB:(id)sender;



@end
