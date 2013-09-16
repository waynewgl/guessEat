//
//  GZMapController.m
//  guessEat
//
//  Created by Stephen Zheng on 10/09/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZMapController.h"
#import "GZGamePageViewController.h"


@interface GZMapController ()

@end

@implementation GZMapController

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


- (void)goToGamingpageCrt {
    GZGamePageViewController *gamePageController=[[GZGamePageViewController alloc]init];
    gamePageController.newFlat=5;
    [self.navigationController pushViewController:gamePageController animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
