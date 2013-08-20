//
//  GZGamingController.m
//  guessEat
//
//  Created by Stephen Zheng on 18/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZGamingController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface GZGamingController ()

@end

@implementation GZGamingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"游戏中";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObject:@"1"];
    [arr addObject:@"2"];
    [arr addObject:@"3"];
    [arr addObject:@"4"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];

    
    int row = 0;
    int column = 0;
    
    for (int i = 0; i < arr.count; i++)
    {
        if((row%5 == 0) && (row > 0))
        {
            row = 0;
            column++;
        }
        else{
            row++;
        }
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration: 3.20];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        
        
        CGRect btnFrame = CGRectMake(row*50+10, column*50+210, 50, 50);//your button frame
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
                   action:@selector(aMethod:)
         forControlEvents:UIControlEventTouchDown];
        [button setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        [button setFrame:btnFrame];
        button.hidden=true;
        [self.avoidScrollView addSubview:button];

        [UIView animateWithDuration:3.5
                         animations: ^ {
                             [button setAlpha:1.0];
                         }
                         completion: ^ (BOOL finished) {
                             button.hidden=false;
                         }];
        
        [UIView commitAnimations];
    }


    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 3.20];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    
    CGRect btnFrame = CGRectMake(29, 100, 50, 50);//your button frame
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"title" forState:UIControlStateNormal];
    [button setFrame:btnFrame];
    button.hidden=true;
    [self.avoidScrollView addSubview:button];

    [UIView animateWithDuration:3.5
                     animations: ^ {
                         [button setAlpha:1.0];
                     }
                     completion: ^ (BOOL finished) {
                         button.hidden=false;
                     }];
    
    [UIView commitAnimations];

    // Do any additional setup after loading the view from its nib.
}




- (void)aMethod:(id)sender {
    NSLog(@"button clicked.");
    //[self.navigationController pushViewController:gamingController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
