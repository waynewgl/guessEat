//
//  GZGamePageViewController.m
//  guessEat
//
//  Created by Guiwei LIN on 8/15/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZGamePageViewController.h"
#import "GZCollectionViewCell.h"
#import "RGMPageView.h"
#import "GZGamingController.h"
#import "GZDatabaseHelper.h"
#import "GZImageController.h"


static NSString *kCellIdentifer = @"CELL_ID";


@interface GZGamePageViewController ()

@property(nonatomic,strong)GZGamingController *gamingController;

@end

static NSString *reuseIdentifier = @"RGMPageReuseIdentifier";
static NSInteger numberOfPages = 3;
static NSInteger indexOfImageInArray=0;


@implementation GZGamePageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pagingScrollView registerClass:[RGMPageView class] forCellReuseIdentifier:reuseIdentifier];
    
    UIImage *image = [UIImage imageNamed:@"indicator.png"];
    UIImage *imageActive = [UIImage imageNamed:@"indicator-active.png"];
    
    RGMPageControl *indicator = [[RGMPageControl alloc] initWithItemImage:image activeImage:imageActive];
    indicator.numberOfPages = numberOfPages;
    [indicator addTarget:self action:@selector(pageIndicatorValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:indicator];
    self.pageIndicator = indicator;
    
    
    
    // comment out for horizontal scrolling and indicator orientation (defaults)
    self.pagingScrollView.scrollDirection = RGMScrollDirectionHorizontal;
    self.pageIndicator.orientation = RGMPageIndicatorHorizontal;
    
    NSLog(@"province that chosed by player: %d",self.newFlat);
    
}




- (IBAction)pageIndicatorValueChanged:(RGMPageControl *)sender
{
    [self.pagingScrollView setCurrentPage:sender.currentPage animated:YES];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    
    [self.pageIndicator sizeToFit];
    
    CGRect frame = self.pageIndicator.frame;
    const CGFloat inset = 20.0f;
    
    switch (self.pageIndicator.orientation) {
        case RGMPageIndicatorHorizontal: {
            frame.origin.x = floorf((bounds.size.width - frame.size.width) / 2.0f);
            frame.origin.y = bounds.size.height - frame.size.height - inset;
            frame.size.width = MIN(frame.size.width, bounds.size.width);
            break;
        }
        case RGMPageIndicatorVertical: {
            frame.origin.x = bounds.origin.x + inset;
            frame.origin.y = floorf((bounds.size.height - frame.size.height) / 2.0f);
            frame.size.height = MIN(frame.size.height, bounds.size.height);
            break;
        }
    }
    
    self.pageIndicator.frame = frame;
}

#pragma mark - RGMPagingScrollView data source


- (NSInteger)pagingScrollViewNumberOfPages:(RGMPagingScrollView *)pagingScrollView
{
    return numberOfPages;
}

- (UIView *)pagingScrollView:(RGMPagingScrollView *)pagingScrollView viewForIndex:(NSInteger)idx
{

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    /**
     * 如果想要对某个 item、section 的 #以下属性# 进行单独设置,
     * 可以实现 flowLayout 的 protocol (UICollectionViewDelegateFlowLayout),
     * 设置 delegate 方法,
     * 根据不同的 indexpath, 找到特定的 item, 返回不同的值.
     */
    /* ################################################################### */
    
    // item 的大小
    flowLayout.itemSize = CGSizeMake(50.0f, 50.0f);
    
    // UICollectionView 的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // item 之间的距离.
    // (如何是纵向滑动, 左右 item 之间的距离).
    // (如何是横向滑动, 上下 item 之间的距离).
    // default 10.
    flowLayout.minimumInteritemSpacing = 10.0f;
    
    // (如何是纵向滑动, 行之间的距离).
    // (如何是纵向滑动, 列之间的距离).
    // default 10.
    flowLayout.minimumLineSpacing = 27.0f;
    
    // section 头视图的大小
    flowLayout.headerReferenceSize = CGSizeMake(0.0f, 0.0f);
    
    // section 尾视图的大小
    flowLayout.footerReferenceSize = CGSizeMake(0.0f, 0.0f);
    
    // 调整 section 的边距. (top, left, bottom, right)
    flowLayout.sectionInset = UIEdgeInsetsMake(20.0f, 27.0f, 35.0f, 27.0f);
    
    /* ################################################################### */
    
    _imgsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10.0f,
                                                                             24.0f,
                                                                             self.view.bounds.size.width - 20.0f,
                                                                             self.view.bounds.size.height - 400.0f)
                                             collectionViewLayout:flowLayout];
    _imgsCollectionView.dataSource = self;
    _imgsCollectionView.delegate = self;
    _imgsCollectionView.backgroundColor = [UIColor grayColor];
    
    [self.imgsCollectionView registerClass:[GZCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifer];
    return _imgsCollectionView;
}

#pragma mark - RGMPagingScrollViewDelegate

- (void)pagingScrollView:(RGMPagingScrollView *)pagingScrollView scrolledToPage:(NSInteger)idx
{
    self.pageIndicator.currentPage = idx;
}





#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

// Section HeaderView or Section FooterView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = [[UICollectionReusableView alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 5.0f, 200.0f, 30.0f)];
    label.backgroundColor = [UIColor clearColor];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableView.backgroundColor = [UIColor lightGrayColor];
        label.text = [NSString stringWithFormat:@"Header (%d, %d)", indexPath.section, indexPath.row];
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        reusableView.backgroundColor = [UIColor lightTextColor];
        label.text = [NSString stringWithFormat:@"Footer (%d, %d)", indexPath.section, indexPath.row];
    }
    
    [reusableView addSubview:label];
    return reusableView;
}

-(NSArray *)fetchDishesFromDBThroughProvinceID{
    NSArray *dish_array=[[NSArray alloc] init];
    GZImageController *imageCrt=[[GZImageController alloc] init];
    dish_array=[imageCrt fetchDishFromDBwithProvince_id:self.newFlat] ;
    return dish_array;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifer forIndexPath:indexPath];
    
    if (indexPath.section % 2 == 0) {
        cell.backgroundColor = [UIColor yellowColor];
    } else {
        cell.backgroundColor = [UIColor orangeColor];
    }
    
       
    //for images display
    NSArray *dishArray=[self fetchDishesFromDBThroughProvinceID];
    DLog(@"final imageArray length: %d",[dishArray count]);
    
    UIImage *img = [UIImage imageNamed:@"img.png"];
    //UIImage *imgage=dishArray[indexOfImageInArray];
    
    [cell setImage:img];

    
    return cell;
}

#pragma mark - UICollectionViewDelegate


/*
 
 
 1	1	北京
 2	2	上海
 3	3	广东
 4	4	四川
 5	5	福建
 6	6	天津
 7	7	云南
 8	8	陕西
 
 
 */

//do something after click one cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"Be clicked item at indexPath: %d row: %d in page %d", indexPath.section, indexPath.row,self.pageIndicator.currentPage);
    self.gamingController = [[GZGamingController alloc]init];
    self.gamingController.dish_code = indexPath.row;
    self.gamingController.province_id = self.newFlat;
    
    NSError *Error;
    NSString *dishFile_data = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:WORDS_FILE_NAME ofType:@"txt"]encoding:NSUTF8StringEncoding error:& Error];  
    NSString *word_data = [dishFile_data stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray *Lines = [word_data componentsSeparatedByString:@"\n"];            
    self.gamingController.ans_words=Lines;
    [self.navigationController pushViewController: self.gamingController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
