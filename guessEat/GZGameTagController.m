//
//  GZGameTagController.m
//  guessEat
//
//  Created by Stephen Zheng on 12/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZGameTagController.h"
#import "GZAppDelegate.h"
#import "GZGamingController.h"

@interface GZGameTagController ()

@end

@implementation GZGameTagController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"游戏展示";
    }
    return self;
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
