//
//  LineModel.h
//  DrawPrj
//
//  Created by 李晓明 on 2018/4/12.
//  Copyright © 2018年 lixm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LineModel : NSObject
@property (nonatomic,assign) CGMutablePathRef path;
@property (nonatomic,strong) UIColor *color;
@property CGFloat lineWidth;
@end
