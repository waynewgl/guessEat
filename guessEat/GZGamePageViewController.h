//
//  GZGamePageViewController.h
//  guessEat
//
//  Created by Guiwei LIN on 8/15/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RGMPageControl.h"
#import "RGMPagingScrollView.h"


@interface GZGamePageViewController : UIViewController<RGMPagingScrollViewDatasource,RGMPagingScrollViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>



@property (nonatomic, strong) IBOutlet RGMPagingScrollView *pagingScrollView;
@property (nonatomic, strong) IBOutlet RGMPageControl *pageIndicator;

@property (strong, nonatomic) UICollectionView *imgsCollectionView;


@end
