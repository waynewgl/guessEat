//
//  GZViewController.m
//  guessEat
//
//  Created by Guiwei LIN on 8/8/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZViewController.h"
#import "UIDevice+Resolutions.h"

@interface GZViewController ()

@end

@implementation GZViewController

-(void)checkVersionAndSetScreenBackground{
    int valueDevice = [[UIDevice currentDevice] resolution];
    
    NSLog(@"valueDevice: %d ...", valueDevice);
    
    if (valueDevice == 0)
    {
        //unknow device - you got me!
    }
    else if (valueDevice == 1)
    {
        //standard iphone 3GS and lower
    }
    else if (valueDevice == 2)
    {
        //iphone 4 & 4S
        //screenImageView=[UIImage imageNamed: @"cell.png"];
    }
    else if (valueDevice == 3)
    {
        //iphone 5
    }
    else if (valueDevice == 4)
    {
        //ipad 2
    }
    else if (valueDevice == 5)
    {
        //ipad 3 - retina display
    }
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"test another user");
    NSLog(@"my edition");
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
