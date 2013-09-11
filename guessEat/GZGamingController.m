//
//  GZGamingController.m
//  guessEat
//
//  Created by Stephen Zheng on 18/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZGamingController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "GZDatabaseHelper.h"
#import "GZDish.h"
#import "GZDishImage.h"
#import "SVProgressHUD.h"

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

    
    //[self fetchFromDatabase];
    [self fetchDishFromDatabaseForDish:8];
}

-(void)setUpAnswerSection{

    



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


    
    int row = 0;
    int column = 0;
    
    
    DLog(@"now we have row %d and column %d", row*40+15, column*40+210);
    
    CGRect btnFrame = CGRectMake(15 , column*40+280, 40, 40);//your button frame
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTag:0];
    [button addTarget:self
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:[arr objectAtIndex:0]  forState:UIControlStateNormal];
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
        
       // Dlog(@"now we have row %d and column %d", row*40+15, column*40+210);
        
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
    
    NSArray *dish_array=[[NSArray alloc] init];
    dish_array=[[GZDatabaseHelper sharedInstance] queryFromDataBase];
    DLog(@"db in %d" , [dish_array count]);
    
    
    for (GZDish *dish in dish_array){
        
        DLog(@"dish found id %@ ..name: %@", dish.dish_id, dish.dish_name);
    }
    
}


-(void)fetchDishFromDatabase{
    
    NSArray *dish_array=[[NSArray alloc] init];
    dish_array=[[GZDatabaseHelper sharedInstance] queryFromDataBase];
    DLog(@"db in %d" , [dish_array count]);
    
    
    for (GZDish *dish in dish_array){
        
        DLog(@"dish found id %@ ..name: %@", dish.dish_id, dish.dish_name);
    }
    
}

-(void)fetchDishFromDatabaseForDish:(int)dish_id{
    
    self.dish=[[GZDatabaseHelper sharedInstance] queryDishFromDatabase:dish_id];
    
    
    
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@/%@", IMAGE_DIRECTORY,self.dish.dish_province,self.dish.dish_name];
    
    NSArray *images_files= [[NSBundle mainBundle] pathsForResourcesOfType:@"" inDirectory:imagePath];
    
    if ([images_files count] >0){
        
        NSString *images_file = [NSString stringWithFormat:@"%@",[images_files  objectAtIndex:0]];
        
        [self.dish_imageView setImage:[UIImage imageWithContentsOfFile:images_file]];
        
    }
    else{
        
        [SVProgressHUD showErrorWithStatus:@"no such dish found"];
        
    }

    /*
    [self.dish_imageView setImage:[UIImage imageWithContentsOfFile:images_file_test]];
    
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    
    NSString * documentsPath = [resourcePath stringByAppendingPathComponent:imagePath];
    
    NSError * error;
    NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:&error];
    
    DLog(@"the count the content %@", [directoryContents  objectAtIndex:0]);
    
    NSString *images_file = [NSString stringWithFormat:@"%@/%@",imagePath,[directoryContents  objectAtIndex:0]];
    
    NSLog(@"test image , found  image file path %@", images_file);
    
    
    [self.dish_imageView setImage:[UIImage imageWithContentsOfFile:images_file]];*/
    
    
}



- (void)aMethod:(id)sender {
    
    UIButton *instanceButton = (UIButton*)sender;
    
    DLog(@"button clicked. %d", instanceButton.tag);
    //[self.navigationController pushViewController:gamingController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
