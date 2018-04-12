//
//  ToolView.h
//  DrawPrj
//
//  Created by 李晓明 on 2018/4/12.
//  Copyright © 2018年 lixm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolView : UIView

@property (nonatomic,copy) void(^penBlock)();
@property (nonatomic,copy) void(^eraserBlock)();
@property (nonatomic,copy) void(^colorBlock)();
@property (nonatomic,copy) void(^undoBlock)();
@property (nonatomic,copy) void(^clearBlock)();
@property (nonatomic,copy) void(^saveBlock)();
@property (nonatomic,copy) void(^sliderBlock)(CGFloat width);

@end
