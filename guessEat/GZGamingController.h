//
//  GZGamingController.h
//  guessEat
//
//  Created by Stephen Zheng on 18/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WYPopoverController.h"
@class TPKeyboardAvoidingScrollView;
@class GZDatabaseController;
@class GZDish;
@class RGMPagingScrollView;
@class RGMPageControl;


@interface GZGamingController : UIViewController <WYPopoverControllerDelegate>{

}

@property (nonatomic, strong) IBOutlet RGMPagingScrollView *imgScrollView;
@property (nonatomic, strong) RGMPageControl *imgIndicator;


@property(nonatomic,weak) IBOutlet TPKeyboardAvoidingScrollView *avoidScrollView;
@property(nonatomic,weak) IBOutlet UILabel *nameLable;
@property(nonatomic,weak) IBOutlet UILabel *descripLable;
@property(nonatomic,weak) IBOutlet UIButton *click;
@property(nonatomic,weak) IBOutlet UIImageView *dish_imageView;
@property(nonatomic,weak) IBOutlet UITextField *testField;

@property(nonatomic,assign)  NSInteger dish_code;
@property(nonatomic,assign)  NSInteger province_id;

@property(nonatomic,strong)  GZDatabaseController *databaseCrt;
@property(nonatomic,strong)  GZDish *dish;
@property(nonatomic,strong)  NSArray *ans_words;
@property(nonatomic,strong)  NSArray *dish_img_gallery;


@property(nonatomic,weak) IBOutlet UIButton *tip_btn;


-(IBAction)tip_btn:(id)sender;

@end
