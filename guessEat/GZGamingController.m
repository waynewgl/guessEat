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
#import "GZGalleryViewController.h"
#import "GZImageController.h"

@interface GZGamingController ()
{
    WYPopoverController* popoverController;
}

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
    //this is test for the imageArray
    GZImageController *imageCrt=[[GZImageController alloc] init];
    NSArray *imageArray=[imageCrt fetchDishFromDBwithProvince_id:5];
    //[self.dish_imageView setImage:imageArray[0]];
    self.dish_imageView.image=[UIImage imageNamed:@"1-0.jpg"];
    
    [self fetchDishFromDatabaseForDish:self.dish_code withProvince_id:self.province_id];
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
               action:@selector(ans_circleHandler:)
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
                   action:@selector(ans_circleHandler:)
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



-(IBAction)tip_btn:(id)sender{
    
    DLog(@"tip button clicked...%@", @"");
    
    if (popoverController == nil)
    {
        UIView* btn = (UIView*)sender;
        
        GZGalleryViewController* galleryViewController = [[GZGalleryViewController alloc] init];
        galleryViewController.contentSizeForViewInPopover = CGSizeMake(280, 200);
        galleryViewController.title = @"菜名提示库";
        [galleryViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)]];
        
        UINavigationController* contentViewController = [[UINavigationController alloc] initWithRootViewController:galleryViewController];
        
        popoverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
        popoverController.delegate = self;
        popoverController.passthroughViews = @[btn];
        popoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
        popoverController.wantsDefaultContentAppearance = NO;
        [popoverController presentPopoverFromRect:btn.bounds inView:btn permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
    }
    else
    {
        [self done:nil];
    }
    
}




-(void)fetchDishFromDatabaseForDish:(NSInteger)dish_id withProvince_id:(NSInteger)province_id{
    
    //fetch one specific dish info from databse
    self.dish=[[GZDatabaseHelper sharedInstance] queryDishFromDatabase:dish_id withProvince_id:province_id];
    
    //create image path of dish
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@/%@", IMAGE_DIRECTORY,self.dish.dish_province,self.dish.dish_name];
    DLog(@"image path : %@",imagePath);
    
    NSArray *images_files= [[NSBundle mainBundle] pathsForResourcesOfType:@"" inDirectory:imagePath];
    
    if ([images_files count] >0){
        //DLog(@"the image amout is: %d",[images_files count]);
        NSString *images_file = [NSString stringWithFormat:@"%@",[images_files  objectAtIndex:0]];
        
        UIImage *dish_img = [UIImage imageWithContentsOfFile:images_file];

//        CGSize newSize = CGSizeMake(200.0f, 200.0f);
//        UIGraphicsBeginImageContext(newSize);
//        [dish_img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//        dish_img = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
        
        [self.dish_imageView setImage:dish_img];
        NSInteger s = [self.dish.dish_name length];
        //DLog(@"now we get dish name to be displayed %@ with dish length %d",self.dish.dish_name, s);
        for(int i=0; i<s; ++i) {

            UIButton *ans_btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [ans_btn addTarget:self action:@selector(ans_buttonHandler:)  forControlEvents:UIControlEventAllEvents];
            ans_btn.frame = CGRectMake(i*40 +65, 240, 30, 30);
            [ans_btn setImage:[UIImage imageNamed:@"ans_bg1.jpg"] forState:UIControlStateNormal];
            ans_btn.tag = i+1;
            
            //add animation
            CABasicAnimation *fadeAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
            fadeAnimation.fromValue=[NSNumber numberWithFloat:0.7];
            fadeAnimation.toValue=[NSNumber numberWithFloat:1.0];
            fadeAnimation.duration=1.0;
            fadeAnimation.repeatCount=INFINITY;
            fadeAnimation.autoreverses=YES;
            [ans_btn.layer addAnimation:fadeAnimation forKey:@"fadeInOut"];
            
            [self.view addSubview:ans_btn];
        }
        
    }
    else{
        
        [SVProgressHUD showErrorWithStatus:@"no such dish found"];
        
    }
    
    
}



#pragma mark - Selectors

- (void)done:(id)sender
{
    [popoverController dismissPopoverAnimated:YES];
    popoverController.delegate = nil;
    popoverController = nil;
}

#pragma mark - WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismiss:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismiss:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    popoverController = nil;
}


- (void)ans_buttonHandler:(id)sender {
    
    UIButton *instanceButton = (UIButton*)sender;
    DLog(@"answer section clicked. %d", instanceButton.tag);
    //[self.navigationController pushViewController:gamingController animated:YES];
}

- (void)ans_circleHandler:(id)sender {
    
    UIButton *instanceButton = (UIButton*)sender;
    DLog(@"answers circle  clicked. %d  with title %@ ", instanceButton.tag, instanceButton.titleLabel.text);
    //[self.navigationController pushViewController:gamingController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
