# YZprogressHUB
## Overview
在指定的页面添加蒙板，可以设置GIF和文本属性。
## Basic usage
初始化

    @property (strong, nonatomic) YZprogressHUB *yhub;
添加蒙板到你的视图

    self.yhub = [YZprogressHUB showHUDAddedTo:self.view animated:YES];   
移除本视图蒙板

    [YZprogressHUB hideHUDForView];
    [YZprogressHUB hideHUDForView:self.view afterDelay:0.7];

