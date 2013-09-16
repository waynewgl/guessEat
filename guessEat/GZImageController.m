//
//  GZImageController.m
//  guessEat
//
//  Created by Stephen Zheng on 23/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZImageController.h"
#import "GZDatabaseHelper.h"
#import "SVProgressHUD.h"
#import "GZDish.h"

@interface GZImageController ()

@end

@implementation GZImageController
@synthesize image;

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



-(NSString *)provinceTranser:(NSInteger)province_ID{
    NSString* province;
    switch (province_ID) {
        case 1:
            province=@"北京";
            break;
        case 2:
            province=@"上海";
            break;
        case 3:
            province=@"广东";
            break;
        case 4:
            province=@"四川";
            break;
        case 5:
            province=@"福建";
            break;
        case 6:
            province=@"天津";
            break;
        case 7:
            province=@"云南";
            break;
        case 8:
            province=@"陕西";
            break;
    }
    return province;
    
}


-(NSArray *)fetchDishFromDBwithProvince_id:(NSInteger)province_id{
      
    NSArray *imagesInfo=[[GZDatabaseHelper sharedInstance] queryFromDataBase:province_id];
    NSMutableArray *imageArray =[[NSMutableArray alloc] init];
    for(GZDish *dish in imagesInfo){
        NSString *name=dish.dish_name;
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@/%@",IMAGE_DIRECTORY,dish.dish_province,name];
        //DLog(@"the root path of image:%@",imagePath);
        
        @try {
            [imageArray addObject:[[NSBundle mainBundle] pathForResource:name ofType:@"jpg" inDirectory:imagePath]];
        }
        @catch (NSException *exception) {
        NSLog(@"the error happen in pageController class while fetch image");
        }
        @finally {
            
        }
    }
    //DLog(@"imageArray length:%d",[imageArray count]);
    
    
    DLog(@"the root path of image:%@",[imageArray objectAtIndex:0]);

    
    return imageArray;
}





//set the scal of image
- (UIImage *)scaleImage:(UIImage *)imagetoScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
                                [image drawInRect:CGRectMake(0, 0,image.size.width * scaleSize, image.size.height *scaleSize)];
                            UIImage *scaledImage =UIGraphicsGetImageFromCurrentImageContext();
                                UIGraphicsEndImageContext();
                                return scaledImage;                                
}

//set the width and height of image
- (UIImage *)reSizeImage:(UIImage *)imagetoSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width,reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width,reSize.height)];
    UIImage *reSizeImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
