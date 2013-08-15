//
//  UXCollectionViewController.m
//  iOS6_NEW_FEATURES


#import "UXCollectionViewController.h"
#import "UXCollectionViewCell.h"

static NSString *kCellIdentifer = @"CELL_ID";

@interface UXCollectionViewController ()
@property (strong, nonatomic) UICollectionView *imgsCollectionView;
- (void)goBack:(id)sender;
@end

@implementation UXCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)loadView
{
	// Do any additional setup after loading the view, typically from a nib.
    
    [super loadView];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                 style:UIBarButtonSystemItemCancel
                                                                target:self
                                                                action:@selector(goBack:)];
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"UICollectionView"];
    navItem.leftBarButtonItem = backItem;
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    navBar.items = @[navItem];
    [self.view addSubview:navBar];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    /**
     * 如果想要对某个 item、section 的 #以下属性# 进行单独设置,
     * 可以实现 flowLayout 的 protocol (UICollectionViewDelegateFlowLayout),
     * 设置 delegate 方法,
     * 根据不同的 indexpath, 找到特定的 item, 返回不同的值.
     */
    /* ################################################################### */
    
    // item 的大小
    flowLayout.itemSize = CGSizeMake(60.0f, 60.0f);
    
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
    flowLayout.minimumLineSpacing = 10.0f;
    
    // section 头视图的大小
    flowLayout.headerReferenceSize = CGSizeMake(0.0f, 0.0f);
    
    // section 尾视图的大小
    flowLayout.footerReferenceSize = CGSizeMake(0.0f, 0.0f);
    
    // 调整 section 的边距. (top, left, bottom, right)
    flowLayout.sectionInset = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);
    
    /* ################################################################### */
    
    _imgsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10.0f,
                                                                             44.0f,
                                                                             self.view.bounds.size.width - 20.0f,
                                                                             self.view.bounds.size.height - 20.0f)
                                             collectionViewLayout:flowLayout];
    _imgsCollectionView.dataSource = self;
    _imgsCollectionView.delegate = self;
    _imgsCollectionView.backgroundColor = [UIColor grayColor];
    
    [self.imgsCollectionView registerClass:[UXCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifer];
    
    [self.view addSubview:_imgsCollectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 24;
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifer forIndexPath:indexPath];
    
    if (indexPath.section % 2 == 0) {
        cell.backgroundColor = [UIColor yellowColor];
    } else {
        cell.backgroundColor = [UIColor orangeColor];
    }
    
    UIImage *img = [UIImage imageNamed:@"img.png"];
    [cell setImage:img];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section: %d row: %d", indexPath.section, indexPath.row);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
