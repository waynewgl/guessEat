//
//  UXCollectionViewCell.m
//  iOS6_NEW_FEATURES
//


#import "GZCollectionViewCell.h"

@interface GZCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation GZCollectionViewCell
@synthesize imgView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 5.0f, frame.size.width - 10.0f, frame.size.height - 10.0f)];
        imgView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:imgView];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
        bgView.backgroundColor = [UIColor lightGrayColor];
        self.selectedBackgroundView = bgView;
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    [imgView setImage:image];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
