//
//  CanvasView.m
//  DrawPrj
//
//  Created by 李晓明 on 2018/4/12.
//  Copyright © 2018年 lixm. All rights reserved.
//

#import "CanvasView.h"
#import "LineModel.h"

@interface CanvasView()
@property (nonatomic,assign) CGMutablePathRef path;
@property (nonatomic,strong) NSMutableArray *lineModels;
@end

@implementation CanvasView

-(instancetype) initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.lineWidth=2;//设置默认初始值
        self.lineModels = [NSMutableArray array];
    }
    return self;
}

-(void) drawRect:(CGRect)rect{
    //类似fast-for 固定block
    [self.lineModels enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx,BOOL * _Nonnull stop){
        LineModel *model = obj;
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context,model.path);
        CGContextSetLineWidth(context,model.lineWidth);
        CGContextSetStrokeColorWithColor(context,model.color.CGColor);
        CGContextDrawPath(context,kCGPathStroke);
    }];
    if(self.path){
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context,self.path);
        CGContextSetStrokeColorWithColor(context,self.color.CGColor);
        CGContextSetLineWidth(context,self.lineWidth);
        CGContextDrawPath(context,kCGPathStroke);
    }
}


-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *) event{
    UITouch *touch = touches.anyObject;
    CGPoint pt = [touch locationInView:touch.view];
    
    self.path = CGPathCreateMutable();
    CGPathMoveToPoint(self.path ,NULL,pt.x,pt.y);
   
}
-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *) event{
    UITouch *touch = touches.anyObject;
    CGPoint pt = [touch locationInView:touch.view];
    CGPathAddLineToPoint(self.path, NULL, pt.x, pt.y);
    [self setNeedsDisplay];
}
-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *) event{
    
    LineModel *lineModel = [[LineModel alloc] init];
    //因为后边执行了self.path=nil 为了持有此引用，进行了一个复制，以便lineModel继续持有此引用，数组中保存
    lineModel.path = CGPathCreateMutableCopy(self.path);
    lineModel.lineWidth = self.lineWidth;
    lineModel.color = self.color;
    [self.lineModels addObject:lineModel];
    
    CGPathRelease(self.path);
    self.path = nil ;
  
}

-(void) undo{
    if(self.lineModels.count>0){
        [self.lineModels removeLastObject];
        [self setNeedsDisplay];
    }
}
-(void) clear{
    if(self.lineModels.count>0){
        [self.lineModels removeAllObjects];
        [self setNeedsDisplay];
    }
}

@end
