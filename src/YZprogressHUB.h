//
//  YZprogressHUB.h
//  iPhoneBIM
//
//  Created by luhai on 15/12/1.
//  Copyright © 2015年 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZprogressHUB : UIView
@property (nonatomic) UIActivityIndicatorView *acticityIndicator;
@property (nonatomic) UILabel *textLabel;
@property (nonatomic) UIView *hubView;

//property setters
- (void)setColor:(UIColor *)backgroundColor;

//pubic methods
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view afterDelay:(NSTimeInterval)delay;
+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;

@end
