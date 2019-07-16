//
//  SFZoomImageView.m
//  仿简书缩放图像Demo
//
//  Created by 随风流年 on 2019/7/15.
//  Copyright © 2019 随风流年. All rights reserved.
//

#import "SFZoomImageView.h"

static NSString *const kContentOffset = @"contentOffset";

@interface SFZoomImageView()

@property (nonatomic, strong) UIButton *headerButton;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, copy) ClickHeaderBlock headerBlock;

@end


@implementation SFZoomImageView

#pragma mark --- init ----
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}
- (instancetype)initWithImage:(UIImage *)image{
    self = [super init];
    if (self) {
        [self setUI];
        self.image = image;
    }
    return self;
}
#pragma mark -- setUI --
- (void)setUI{
    CGFloat kWidth = 60;
    self.frame = CGRectMake(0, 0, kWidth, kWidth);
    self.headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerButton.frame = CGRectMake(0, 0, kWidth, kWidth);
    _headerButton.center = CGPointMake(kWidth/2, kWidth/2);
    _headerButton.backgroundColor = [UIColor clearColor];
    _headerButton.layer.borderWidth = 0.5f;
    _headerButton.layer.cornerRadius = kWidth/2;
    _headerButton.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    _headerButton.clipsToBounds = YES;
    [self addSubview:_headerButton];
    
}

#pragma mark -- set get --

- (void)setImage:(UIImage *)image{
    _image = image;
    [self.headerButton setImage:image forState:UIControlStateNormal];
}
- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.headerButton.layer.borderColor = borderColor.CGColor;
}

#pragma mark -- call method --
- (void)clickHeaderBlock:(ClickHeaderBlock)block{
    self.headerBlock = block;
    self.userInteractionEnabled = YES;
    [self.headerButton addTarget:self action:@selector(tapHeaderClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapHeaderClick:(UITapGestureRecognizer *)gesture{
    if (self.headerBlock) {
        self.headerBlock();
    }
}
- (void)updateImageSizeWithScrollView:(UIScrollView *)scrollView{
    self.scrollView = scrollView;
    [self.scrollView addObserver:self forKeyPath:kContentOffset options:NSKeyValueObservingOptionNew context:nil];
}
#pragma mark --- upload image observe ---
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:kContentOffset] && object == self.scrollView) {
        CGFloat offsetY = self.scrollView.contentOffset.y;
        CGFloat scale = 1.0;
        if (offsetY < 0) { //放大
            scale = MIN(1.2, 1- offsetY / 300);
        } else if (offsetY > 0) {//缩小
            scale = MAX(0.55, 1-offsetY / 300);
        }
        NSLog(@"offsetY:%f",offsetY);

        self.headerButton.transform = CGAffineTransformMakeScale(scale, scale);
        
        CGRect frame = self.headerButton.frame;
        frame.origin.y = 15;
        self.headerButton.frame = frame;
        
    }
}



@end
