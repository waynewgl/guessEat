//
//  GZImageController.m
//  guessEat
//
//  Created by Stephen Zheng on 23/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZImageController.h"

@interface GZImageController ()

@end

@implementation GZImageController
@synthesize image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//set the scal of image
- (UIImage *)scaleImage:(UIImage *)imagetoScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
                                [image drawInRect:CGRectMake(0, 0,image.size.width * scaleSize, image.size.height *scaleSize)];
                            UIImage *scaledImage =UIGraphicsGetImageFromCurrentImageContext();
                                UIGraphicsEndImageContext();
                                return scaledImage;                                
}

//set the width and height of image
- (UIImage *)reSizeImage:(UIImage *)imagetoSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width,reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width,reSize.height)];
    UIImage *reSizeImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
