//
//  GZGamingController.h
//  guessEat
//
//  Created by Stephen Zheng on 18/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPKeyboardAvoidingScrollView;

@interface GZGamingController : UIViewController{
    IBOutlet UILabel *nameLable;
    IBOutlet UILabel *descripLable;
    IBOutlet UIButton *click;
    IBOutlet UIImage *image0;
    IBOutlet UIImage *image1;
    IBOutlet UIImage *image2;
    IBOutlet UIImage *image3;
    
}


@property(nonatomic,weak) IBOutlet TPKeyboardAvoidingScrollView *avoidScrollView;
@property(nonatomic,weak) IBOutlet UILabel *nameLable;
@property(nonatomic,weak) IBOutlet UILabel *descripLable;
@property(nonatomic,weak) IBOutlet UIButton *click;
@property(nonatomic,weak) IBOutlet UIImage *image0;
@property(nonatomic,weak) IBOutlet UIImage *image1;
@property(nonatomic,weak) IBOutlet UIImage *image2;
@property(nonatomic,weak) IBOutlet UIImage *image3;

-(IBAction)Click:(id)sender;



@end
