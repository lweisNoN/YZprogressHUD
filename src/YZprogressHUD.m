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

#import "YZprogressHUD.h"

@interface YZprogressHUD()
@property (nonatomic) UIView *hubView;
@property (nonatomic) UIWebView *progressGIFWebVIew;

@property (nonatomic) UIActivityIndicatorView *acticityIndicator;
@property (nonatomic) UILabel *textLabel;
@property (nonatomic) NSData *gifData;
@end

@implementation YZprogressHUD

#pragma mark - pubilc methods
+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    YZprogressHUD *hud = [[self alloc] initWithView:view];
    
    [view addSubview:hud];
    [hud show:animated];
    return hud;
}

+ (instancetype)showHUDAddedTo:(UIView *)view withGifViewFrame:(CGRect)frame andGifData:(NSData *)data animated:(BOOL)animated {
    YZprogressHUD *hud = [[self alloc] initWithView:view];
    
    if (data != nil) {
        hud.textLabel.hidden = YES;
        hud.gifData = data;
        hud.progressGIFWebVIew = [[UIWebView alloc] initWithFrame:frame];
        hud.progressGIFWebVIew.backgroundColor = [UIColor clearColor];
        [hud.progressGIFWebVIew setOpaque:NO];
        hud.progressGIFWebVIew.scalesPageToFit = YES;
        hud.progressGIFWebVIew.userInteractionEnabled = NO;

        [hud addSubview:hud.progressGIFWebVIew];
        
        hud.textLabel.frame = CGRectMake(hud.textLabel.frame.origin.x, frame.origin.y + frame.size.height, 97, 23);
    }

    [view addSubview:hud];
    [hud show:animated];
    return hud;
}

+ (void)hideHUDForView:(UIView *)view afterDelay:(NSTimeInterval)delay {
    
    [self performSelector:@selector(hideHUDForView:) withObject:view afterDelay:delay];
   
}

+ (void)hideHUDForView:(UIView *)view {
    YZprogressHUD *hud = [self HUDForView:view];
    if (hud != nil) {
        [hud removeFromSuperview];
    }
}

- (void)setColor:(UIColor *)backgroundColor
{
    [_hubView setBackgroundColor:backgroundColor];
}

- (void)setText:(NSString *)text
{
    _textLabel.text = text;;
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
            return (YZprogressHUD *)subview;
        }
    }
    return nil;
}

- (void)show:(BOOL)animated {
    if (animated) {
        if (self.progressGIFWebVIew != nil) {
            [self startAnimating];
        } else {
            [self.acticityIndicator startAnimating];
        }
    } else {
        if (self.progressGIFWebVIew != nil) {
            [self stopAnimating];
        } else {
            [self.acticityIndicator stopAnimating];
        }
    }
}

#pragma mark load gif
- (void) startAnimating
{
    dispatch_async(dispatch_get_main_queue(), ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-unused-variable"
        [self.progressGIFWebVIew loadData:self.gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
        self.textLabel.hidden = NO;
#pragma clang diagnostic pop
    });
}

- (void)stopAnimating
{
    [self.progressGIFWebVIew removeFromSuperview];
}

#pragma mark - getters & stters
- (UIView *)hubView
{
    if (!_hubView) {
        _hubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        if (_progressGIFWebVIew == nil) {
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

@end
