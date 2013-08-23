//
//  GZGamingController.m
//  guessEat
//
//  Created by Stephen Zheng on 18/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZGamingController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "GZDatabaseController.h"
#import "GZDatabaseHelper.h"



@interface GZGamingController ()

@end

@implementation GZGamingController;

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

    
    [self setUpGamingSection];
    
    // Do any additional setup after loading the view from its nib.
    //do we need to release memory after I create object databaseCrt in memory???????????????/

    
    [self fetchFromDatabase];
}


-(void)setUpGamingSection{
    
    
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
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
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
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    [arr addObject:@"15"];
    
    int row = 0;
    int column = 0;
    
    
    NSLog(@"now we have row %d and column %d", row*40+15, column*40+210);
    
    CGRect btnFrame = CGRectMake(15 , column*40+280, 40, 40);//your button frame
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTag:0];
    [button addTarget:self
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"1" forState:UIControlStateNormal];
    [button setFrame:btnFrame];
    [self.avoidScrollView addSubview:button];
    
    for (int i = 1; i < arr.count; i++)
    {
        if((row%6 == 0) && (row >0))
        {
            row = 0;
            column++;
        }
        else{
            row++;
        }
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration: 0.2*i];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        NSLog(@"now we have row %d and column %d", row*40+15, column*40+210);
        
        CGRect btnFrame = CGRectMake(row*40+15, column*40+280, 40, 40);//your button frame
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTag:i];
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

    
    
}

-(IBAction)Click:(id)sender{
    [self fetchFromDatabase];
}

-(IBAction)searchFromDB:(id)sender{
    
}



-(void)fetchFromDatabase{
    
    NSArray *array=[[NSArray alloc] init];
    array=[[GZDatabaseHelper sharedInstance] queryFromDataBase];
    NSLog(@"db in %d" , [array count]);
    
    /*
    [image0 setImage:[UIImage imageNamed:@"1-0.jpg"]];
    [image1 setImage:[UIImage imageNamed:@"1-1.jpg"]];
    [image2 setImage:[UIImage imageNamed:@"1-2.jpg"]];
    image3.transform = CGAffineTransformMakeScale(0.3,0.3);
    [image3 setImage:[UIImage imageNamed:@"1-3.jpg"]];*/
}

- (void)aMethod:(id)sender {
    
    UIButton *instanceButton = (UIButton*)sender;
    
    NSLog(@"button clicked. %d", instanceButton.tag);
    //[self.navigationController pushViewController:gamingController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
