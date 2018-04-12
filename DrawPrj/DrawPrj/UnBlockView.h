//
//  UnBlockView.h
//  DrawPrj
//
//  Created by 李晓明 on 2018/4/12.
//  Copyright © 2018年 lixm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnBlockView : UIView
@property (nonatomic,copy) void(^unblockViewBlock)(UnBlockView *bView,BOOL success);
-(void) reset;//添加重置方法，用户输入错误后，用户会再次输入

@end
