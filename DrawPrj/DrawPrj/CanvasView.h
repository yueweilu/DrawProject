//
//  CanvasView.h
//  DrawPrj
//
//  Created by 李晓明 on 2018/4/12.
//  Copyright © 2018年 lixm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanvasView : UIView

@property (nonatomic,strong) UIColor *color;
@property CGFloat lineWidth;

-(void) undo;
-(void) clear;
@end
