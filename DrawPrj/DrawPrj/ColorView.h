//
//  ColorView.h
//  DrawPrj
//
//  Created by 李晓明 on 2018/4/12.
//  Copyright © 2018年 lixm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorView : UIView

@property (nonatomic,copy) void(^selectColorBlock)(UIColor *color);

-(void)showAnimation;
@end
