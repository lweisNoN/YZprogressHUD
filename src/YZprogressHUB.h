//
//  YZprogressHUB.h
//  iPhoneBIM
//
//  Created by luhai on 15/12/1.
//  Copyright © 2015年 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZprogressHUB : UIView
- (void)setColor:(UIColor *)backgroundColor;
+ (void)hideHUDForView:(UIView *)view afterDelay:(NSTimeInterval)delay;
+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;

@end
