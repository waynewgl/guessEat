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

@interface GZHomeViewController ()

@end

@implementation GZHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

//achieve page navigate to GZGaming Controller, but it does not work.
- (void)goToGamingpageController {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"BackToHomePage"
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:nil
                                                                action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
    GZGamingController *gamingController = [[GZGamingController alloc] init];
    GZAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.navigationController pushViewController:gamingController animated:YES];
    //[self.navigationController pushViewController:gamingController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end