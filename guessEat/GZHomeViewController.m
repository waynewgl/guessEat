//
//  GZHomeViewController.m
//  guessEat
//
//  Created by Stephen Zheng on 12/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZHomeViewController.h"
#import "GZAppDelegate.h"
#import "GZGamingController.h"
#import "GZGamePageViewController.h"

@interface GZHomeViewController ()

@end

@implementation GZHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"游戏";
        
    }
    return self;
}

//achieve page navigate to GZGaming Controller, but it does not work.
- (void)goToGamingpageController {
    DLog(@"Enter method %@", @"");
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Home"
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:nil
                                                                action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
    //GZGamingController *gamingController = [[GZGamingController alloc] init];
    GZGamePageViewController *gamePageController=[[GZGamePageViewController alloc]init];
    //GZAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [self.navigationController pushViewController:gamePageController animated:YES];
    //[self.navigationController pushViewController:gamingController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    NSString *images_misc_file = [[NSBundle mainBundle] pathForResource:@"光饼" ofType:@"jpg" inDirectory:@"dishes_images/福建/光饼"];
    
    NSLog(@"test image , found  image file path %@", images_misc_file);
    
    // Do any additional setup after loading the view from its nib.*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
