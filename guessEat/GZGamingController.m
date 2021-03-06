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
#import "GZAnswerStatus.h"
#import "NSMutableArray+Shuffle.h"
#import "UIView+I7ShakeAnimation.h"
#import "RGMPageControl.h"
#import "RGMPagingScrollView.h"
#import "RGMPageView.h"

#define ANSWER_TAG 100

static NSString *reuseIdentifier = @"RGMPageReuseIdentifier";
static NSInteger numberOfPages = 3;

@interface GZGamingController ()
{
    WYPopoverController* popoverController;
}

@end

@implementation GZGamingController{
    
    NSMutableArray *ans_grp_array;
    NSString *word_data;
    NSMutableArray *ans_sec_arr;
    
    NSInteger dish_img_count;
    
}

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

    [self.imgScrollView registerClass:[RGMPageView class] forCellReuseIdentifier:reuseIdentifier];
    [self fetchDishFromDatabaseForDish:self.dish_code withProvince_id:self.province_id];
    [self setUpGamingSection];
    [self setUpImgGallerySection];

}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    [self.imgIndicator sizeToFit];
    CGRect frame = self.imgIndicator.frame;
    const CGFloat inset = 20.0f;
    
    switch (self.imgIndicator.orientation) {
        case RGMPageIndicatorHorizontal: {
            
            if(SYSTEM_VERSION_GREATER_THAN(@"6.0")){
                frame.origin.x = floorf((bounds.size.width - frame.size.width) / 2.5f);
                frame.origin.y = self.imgScrollView.bounds.origin.y+110;
                frame.size.width = MIN(frame.size.width, bounds.size.width);
            }
            else{
                
                frame.origin.x = floorf((bounds.size.width - frame.size.width) / 2.5f);
                frame.origin.y = self.imgScrollView.bounds.origin.y+30;
                frame.size.width = MIN(frame.size.width, bounds.size.width);
            }

            break;
        }
        case RGMPageIndicatorVertical: {
    
            frame.origin.x = bounds.origin.x + inset;
            frame.origin.y = floorf((bounds.size.height - frame.size.height) / 2.0f);
            frame.size.height = MIN(frame.size.height, bounds.size.height);
            break;
        }
    }
    
    self.imgIndicator.frame = frame;
}


#pragma mark - gaming methods



-(void)fetchDishFromDatabaseForDish:(NSInteger)dish_id withProvince_id:(NSInteger)province_id{
    
    //fetch one specific dish info from databse
    self.dish=[[GZDatabaseHelper sharedInstance] queryDishFromDatabase:dish_id withProvince_id:province_id];
    
    //create image path of dish
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@/%@", IMAGE_DIRECTORY,self.dish.dish_province,self.dish.dish_name];
    DLog(@"image path : %@",imagePath);
    
    self.dish_img_gallery= [[NSBundle mainBundle] pathsForResourcesOfType:@"" inDirectory:imagePath];
    
    dish_img_count = [self.dish_img_gallery count];
    
    [self.imgScrollView reloadData];
    
    if ([self.dish_img_gallery count] >0){
        //DLog(@"the image amout is: %d",[images_files count]);
        
        // initialise array for storing tags in the answer buttons section  
        ans_grp_array = [[NSMutableArray alloc]initWithCapacity:5];
        
        NSInteger s = [self.dish.dish_name length];
        //DLog(@"now we get dish name to be displayed %@ with dish length %d",self.dish.dish_name, s);
        for(int i=0; i<s; ++i) {
            
            UIButton *ans_btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [ans_btn addTarget:self action:@selector(ans_buttonHandler:)  forControlEvents:UIControlEventAllEvents];
            
            if (SYSTEM_VERSION_GREATER_THAN(@"6.0"))
                ans_btn.frame = CGRectMake(i*40 +90, 300, 30, 30);
            else    
                ans_btn.frame = CGRectMake(i*40 +90, 240, 30, 30);
            
            [ans_btn setBackgroundImage:[UIImage imageNamed:@"ans_bg1.jpg"] forState:UIControlStateNormal];
            [ans_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            NSNumber *ans_btn_tag= [NSNumber numberWithInt: i+ANSWER_TAG];
            
            ans_btn.tag = [ans_btn_tag intValue];
            ans_btn.titleLabel.textColor = [UIColor blackColor];
            [ans_btn setTitle:@"" forState:UIControlStateNormal];
            
            GZAnswerStatus *anss = [[GZAnswerStatus alloc]init];
            
            anss.ans_btn_tag = ans_btn_tag;
            anss.ans_to_filled = false;//set fill status of all btn to be false
            [ans_grp_array addObject:anss];
            
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


-(void)setUpImgGallerySection{
    
    
    UIImage *image = [UIImage imageNamed:@"indicator.png"];
    UIImage *imageActive = [UIImage imageNamed:@"indicator-active.png"];
    
    self.imgIndicator = [[RGMPageControl alloc] initWithItemImage:image activeImage:imageActive];
    [self.imgIndicator addTarget:self action:@selector(pageIndicatorValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.imgIndicator.numberOfPages = dish_img_count;
    self.imgIndicator.orientation = RGMPageIndicatorHorizontal;
    
    [self.view addSubview:self.imgIndicator];
    
    // comment out for horizontal scrolling and indicator orientation (defaults)
    self.imgScrollView.scrollDirection = RGMScrollDirectionHorizontal;
    
    CGRect imgScrollViewframe;
    
    if(SYSTEM_VERSION_GREATER_THAN(@"6.0")){
        
        imgScrollViewframe = CGRectMake(self.imgScrollView.frame.origin.x, self.imgScrollView.frame.origin.y-60, self.imgScrollView.frame.size.width, self.imgScrollView.frame.size.height);
        
        self.imgScrollView.frame=imgScrollViewframe;
        
    }
    else{
        
        imgScrollViewframe = CGRectMake(self.imgScrollView.frame.origin.x, self.imgScrollView.frame.origin.y-40, self.imgScrollView.frame.size.width, self.imgScrollView.frame.size.height);
        
        self.imgScrollView.frame=imgScrollViewframe;
    }
    
}

-(void)setUpGamingSection{
    
    uint32_t rnd_words = arc4random_uniform([self.ans_words count]) ; //random words string from array  
    DLog(@"total count int answrod  %d  random word array %d " ,[self.ans_words count], rnd_words);
    word_data = [self.ans_words objectAtIndex:rnd_words];
    ans_sec_arr = [[NSMutableArray alloc] initWithCapacity:5];
    
    int word_data_len= [word_data length];
    int dish_name_length = [self.dish.dish_name length];
    
    for (int i=0;i<21-dish_name_length;i++){//add the random dish char into array
        
        uint32_t rnd = arc4random_uniform(word_data_len) ;    
        NSString *subWord =nil;
        
        if(rnd>1){
            subWord = [word_data substringWithRange:NSMakeRange(rnd,1)];
        }
        else{
            subWord = [word_data substringToIndex:1];
            DLog(@"adding sub string to button group %@" , subWord);
        }
        if([subWord isEqual:@" "])i--;
        else {
            [ans_sec_arr addObject:subWord];  
        }
    }
    
    for(int k=0;k<dish_name_length;k++){//add the correct dish name into array
        
        NSString *subDishName =[self.dish.dish_name substringWithRange:NSMakeRange(k,1)];
        DLog(@"now we have random word data %@  with length %d " , subDishName, dish_name_length);
        [ans_sec_arr addObject:subDishName];
    }
    
    [ans_sec_arr shuffle];//shuffle the answers' array , use category 
    
    [self initialiseBtnMatrix];
    
}

-(void)initialiseBtnMatrix{
    
    int row = 0;
    int column = 0;
    
    DLog(@"now we have row %d and column %d", row*40+15, column*40+210);
    
    CGRect btnFrame = CGRectMake(15 , column*40+280, 40, 40);//your button frame
    UIButton *ans_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ans_button setTag:999];
    [ans_button setBackgroundImage:[UIImage imageNamed:@"ans_bg1.jpg"] forState:UIControlStateNormal];
    [ans_button addTarget:self
                   action:@selector(ans_circleHandler:)
         forControlEvents:UIControlEventTouchDown];
    [ans_button setTitle:[ans_sec_arr objectAtIndex:0]  forState:UIControlStateNormal];
    [ans_button setFrame:btnFrame];
    [self.avoidScrollView addSubview:ans_button];
    
    for (int i = 1; i < ans_sec_arr.count; i++)
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
        [UIView setAnimationDuration: 0.1*i];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        // Dlog(@"now we have row %d and column %d", row*40+15, column*40+210);
        CGRect btnFrame = CGRectMake(row*40+15, column*40+280, 40, 40);//your button frame
        UIButton *anss_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [anss_button setBackgroundImage:[UIImage imageNamed:@"ans_bg1.jpg"] forState:UIControlStateNormal];
        [anss_button setTag:i];
        [anss_button addTarget:self
                        action:@selector(ans_circleHandler:)
              forControlEvents:UIControlEventTouchDown];
        [anss_button setTitle:[ans_sec_arr objectAtIndex:i] forState:UIControlStateNormal];
        [anss_button setFrame:btnFrame];
        anss_button.hidden=true;
        [self.avoidScrollView addSubview:anss_button];
        
        [UIView animateWithDuration:2.5
                         animations: ^ {
                             [anss_button setAlpha:1.0];
                         }
                         completion: ^ (BOOL finished) {
                             anss_button.hidden=false;
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



#pragma mark - Gaming interaction function

- (void)ans_buttonHandler:(id)sender {
    
    UIButton *ans_btn = (UIButton*)sender;
    GZAnswerStatus *ans=[ans_grp_array objectAtIndex:ans_btn.tag-ANSWER_TAG];
    
    if(ans.ans_to_filled){
        [ans_btn setTitle:@" " forState:UIControlStateNormal];
        NSString *btn_str = ans_btn.titleLabel.text;
        ans.ans_to_filled=false;
        DLog(@"answer section clicked. %d with value text is %@ ", ans_btn.tag, btn_str);
        [ans_btn setBackgroundColor:[UIColor clearColor]];
        
        UIButton *res_ans_btn = (UIButton*)[self.view viewWithTag:[ans.repond_to_btnTag intValue]];//display the button clicked by users and set to hidden
        DLog(@"reset hidden button to be displayed %d",[ans.repond_to_btnTag intValue]);
        
        [res_ans_btn setHidden:NO];
        
    }
}



- (void)ans_circleHandler:(id)sender {
    
    UIButton *ans_cir_btn = (UIButton*)sender;
    DLog(@"answers circle  clicked. %d  with title %@ ", ans_cir_btn.tag, ans_cir_btn.titleLabel.text);    
    NSString *ans_selected = ans_cir_btn.titleLabel.text;
    
    bool check_btn_sta = false;//check if button text is filled
    int btn_tobe_filled = 0 ;
    
    for (int i=0;i<[ans_grp_array count];i++){
        GZAnswerStatus *anss  =  [ans_grp_array objectAtIndex:i];
        if(anss.ans_to_filled==false){
            check_btn_sta=true;//if  one btn's text is not filled, then find this btn 
            btn_tobe_filled = [anss.ans_btn_tag intValue];
            DLog(@"now the btn tag is %d",btn_tobe_filled);
            anss.ans_to_filled=true;   // this is to determine whether the answer fields are filled or not
            anss.repond_to_btnTag = [NSNumber numberWithInt:ans_cir_btn.tag];//record the current clicked button by user
            DLog(@"what is the clicked button tag %@", anss.repond_to_btnTag);
            break;
        }
    }
    
    
    Boolean shake_btn=false;
    
    if(check_btn_sta){//if blank btn text found, then fill the btn with selected answer
        
        UIButton *btn = (UIButton*)[self.view viewWithTag:btn_tobe_filled];
        if([btn.titleLabel.text isEqual:@""]==false || btn.titleLabel.text==nil){
            
            [btn setTitle:ans_selected forState:UIControlStateNormal];
            [ans_cir_btn setHidden:YES];//hide the clicked button
            int btn_tobe_comp = 0 ;            
            NSString *final_ans=@"";
            for (int i=0;i<[ans_grp_array count];i++){
                
                GZAnswerStatus *anss  =  [ans_grp_array objectAtIndex:i];
                btn_tobe_comp = [anss.ans_btn_tag intValue];
                UIButton *btn = (UIButton*)[self.view viewWithTag:btn_tobe_comp];
                final_ans = [final_ans stringByAppendingString:[NSString stringWithFormat:@"%@",btn.titleLabel.text ]];                
            }
            DLog(@"now we have the final string answer %@ " , final_ans);
            
            final_ans = [final_ans stringByReplacingOccurrencesOfString:@" " withString:@""];//remove white space of string
            
            if([final_ans isEqual:self.dish.dish_name]){
                DLog(@"now you got the right answer, congratulation...%@" , @"");
                [SVProgressHUD showSuccessWithStatus:@"congratulation, you got the right answer..."];
            }
            else if ([final_ans isEqual:self.dish.dish_name]==false && [final_ans length]==[self.dish.dish_name length]) shake_btn=true;
        }
        
    }
    
    if(shake_btn){// if the selected answers are not correct , then shake the ans fields to inform users.
        
        for (int i=0;i<[ans_grp_array count];i++){
            
            GZAnswerStatus *anss  =  [ans_grp_array objectAtIndex:i];
            int shake_btn_tag = [anss.ans_btn_tag intValue];
            UIButton *btn = (UIButton*)[self.view viewWithTag:shake_btn_tag];
            [btn shakeX];
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
    
}








#pragma mark - RGMPagingScrollViewDelegate


- (IBAction)pageIndicatorValueChanged:(RGMPageControl *)sender
{
    
    [self.imgScrollView setCurrentPage:sender.currentPage animated:YES];
}



- (void)pagingScrollView:(RGMPagingScrollView *)pagingScrollView scrolledToPage:(NSInteger)idx
{
    self.imgIndicator.currentPage = idx;
}



#pragma mark - RGMPagingScrollView data source

- (NSInteger)pagingScrollViewNumberOfPages:(RGMPagingScrollView *)pagingScrollView
{
    return dish_img_count;
}

- (UIView *)pagingScrollView:(RGMPagingScrollView *)pagingScrollView viewForIndex:(NSInteger)idx
{
    NSString *images_file = [NSString stringWithFormat:@"%@",[ self.dish_img_gallery  objectAtIndex:idx]];
    UIImage *dish_img = [UIImage imageWithContentsOfFile:images_file];
    [self.dish_imageView setImage:dish_img];
    DLog(@"we get img ..... %@",images_file);
    return self.dish_imageView;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
