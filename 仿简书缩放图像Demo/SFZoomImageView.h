//
//  SFZoomImageView.h
//  仿简书缩放图像Demo
//
//  Created by 随风流年 on 2019/7/15.
//  Copyright © 2019 随风流年. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickHeaderBlock) (void);

NS_ASSUME_NONNULL_BEGIN

@interface SFZoomImageView : UIView

/**
 用户图像
 */
@property (nonatomic, strong) UIImage *image;
/**
 边框颜色
 */
@property (nonatomic, strong) UIColor *borderColor;

/**
 初始化方法
 */
- (instancetype)init;
/**
 初始化方法
 */
- (instancetype)initWithImage:(UIImage *)image;
/**
 更新头像大小
 */
- (void)updateImageSizeWithScrollView:(UIScrollView *)scrollView;
/**
 * 点击头像回调
 */
-(void)clickHeaderBlock:(ClickHeaderBlock)block;

@end

NS_ASSUME_NONNULL_END
