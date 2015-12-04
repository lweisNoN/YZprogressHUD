//
//  YZprogressHUB.m
//  iPhoneBIM
//
//  Created by luhai on 15/12/1.
//  Copyright © 2015年 Dev. All rights reserved.
//

#import "YZprogressHUB.h"

@interface YZprogressHUB()

@end

@implementation YZprogressHUB

#pragma mark - pubilc methods
+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    YZprogressHUB *hud = [[self alloc] initWithView:view];
    [view addSubview:hud];
    [hud show:animated];
    return hud;
}

+ (void)hideHUDForView:(UIView *)view afterDelay:(NSTimeInterval)delay {
    
    [self performSelector:@selector(hideHUDForView:) withObject:view afterDelay:delay];
   
}

+ (void)hideHUDForView:(UIView *)view {
    YZprogressHUB *hud = [self HUDForView:view];
    if (hud != nil) {
        [hud removeFromSuperview];
    }
}

- (void)setColor:(UIColor *)backgroundColor
{
    [_hubView setBackgroundColor:backgroundColor];
}

#pragma mark - private methods
- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Set default values for properties
        if (!_hubView) {
            [self addSubview:self.hubView];
        }
    }
    
    return self;
}

+ (instancetype)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (YZprogressHUB *)subview;
        }
    }
    return nil;
}

- (void)show:(BOOL)animated {
    if (animated) {
        [self.acticityIndicator startAnimating];
    } else {
        [self.acticityIndicator stopAnimating];
    }
}

#pragma mark - getters & stters
- (UIView *)hubView
{
    if (!_hubView) {
        _hubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_hubView addSubview:self.acticityIndicator];
        [_hubView addSubview:self.textLabel];
    }
    
    return _hubView;
}

- (UIActivityIndicatorView *)acticityIndicator
{
    if (!_acticityIndicator) {
        _acticityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.frame.size.width - 120) /2,  (self.frame.size.height - 20) /2, 20, 20)];
        [_acticityIndicator setColor:[UIColor grayColor]];
    }
    
    return _acticityIndicator;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 120) /2 + 23, (self.frame.size.height - 23) /2, 97, 23)];
        _textLabel.text = @" 载入数据中...";
        [_textLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [_textLabel setTextColor:[UIColor grayColor]];
    }
    
    return _textLabel;
}

@end
