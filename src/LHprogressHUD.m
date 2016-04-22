// The MIT License (MIT)
//
// Copyright (c) 2015-2016 lweisNoN ( https://github.com/lweisNoN )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "LHprogressHUD.h"

@interface LHprogressHUD()

@property (nonatomic, strong) UIView *hubView;
@property (nonatomic, strong) UIActivityIndicatorView *acticityIndicator;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *gifView;

@end

@implementation LHprogressHUD

#pragma mark - pubilc methods
+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    LHprogressHUD *hud = [[self alloc] initWithView:view];
    
    [view addSubview:hud];
    [hud show:animated];
    return hud;
}

+ (instancetype)showHUDAddedTo:(UIView *)view andGifViewFrame:(CGRect)frame andGifImages:(NSArray *)images andHudBackGroudColor:(UIColor *)color {
    LHprogressHUD *hud = [[self alloc] initWithView:view];
    [hud setColor:color];
    hud.textLabel.hidden = YES;
    hud.gifView.frame = frame;
    [hud setImages:images duration:images.count * 0.1];
    
    [view addSubview:hud];
    [hud show:YES];
    return hud;
}

+ (void)hideHUDForView:(UIView *)view afterDelay:(NSTimeInterval)delay {
    
    [self performSelector:@selector(hideHUDForView:) withObject:view afterDelay:delay];
   
}

+ (void)hideHUDForView:(UIView *)view {
    LHprogressHUD *hud = [self HUDForView:view];
    if (hud != nil) {
        [hud removeFromSuperview];
    }
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
            return (LHprogressHUD *)subview;
        }
    }
    return nil;
}

- (void)show:(BOOL)animated {
    if (animated) {
        if (self.gifView != nil) {
            [self startAnimating];
        } else {
            [self.acticityIndicator startAnimating];
        }
    }
}

- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration
{
    if (images == nil || images.count == 0) return;

    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.frame.size.height) {
        CGRect frame = self.frame;
        frame.size.height = self.frame.size.height;
        self.hubView.frame = frame;
    }
    
    [self.gifView stopAnimating];
    if (images.count == 1) { // 单张图片
        self.gifView.image = [images lastObject];
    } else { // 多张图片
        self.gifView.animationImages = images;
        self.gifView.animationDuration = duration;
    }

}

#pragma mark load gif
- (void) startAnimating
{
    [_gifView startAnimating];
}

- (void)stopAnimating
{
    [_gifView stopAnimating];
    [_gifView removeFromSuperview];
}

#pragma mark - getters & stters
- (UIView *)hubView
{
    if (!_hubView) {
        _hubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        if (_gifView == nil) {
            [_hubView addSubview:self.acticityIndicator];
            [_hubView addSubview:self.textLabel];
        }

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

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}


- (void)setColor:(UIColor *)backgroundColor
{
    [_hubView setBackgroundColor:backgroundColor];
}

- (void)setText:(NSString *)text
{
    _textLabel.text = text;;
}

@end
