# LHprogressHUD
## Overview
在指定的页面添加GIF蒙板，设置GIF图或者文本的属性。
## Basic usage
初始化

    @property (strong, nonatomic) LHprogressHUD *yhub;
添加默认蒙板到你的视图

    self.lhud = [LHprogressHUD showHUDAddedTo:self.view animated:YES];
添加自定义GIF蒙板到你的视图

     self.lhud =  [LHprogressHUD showHUDAddedTo:self.view andGifViewFrame:fooFrame andGifImages:fooImageArray andHudBackGroudColor:fooColor];


移除本视图蒙板

    [LHprogressHUD hideHUDForView];
    [LHprogressHUD hideHUDForView:self.view afterDelay:0.7];

## License
MIT

