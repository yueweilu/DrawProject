//
//  CircleView.m
//  DrawPrj
//
//  Created by 李晓明 on 2018/4/12.
//  Copyright © 2018年 lixm. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
       
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self setNeedsDisplay];
}
-(void)drawCircle {
    NSArray *arr = @[@300,@232,@324,@34,@435,@43];
    //计算数组所有值得和
    CGFloat sumValue = [[arr valueForKeyPath:@"@sum.floatValue"] floatValue];
    
    
    CGPoint origin = self.center;
    
    CGFloat startAngle = 0;
    
    CGFloat endAngle = 0;
    
    for (NSInteger i = 0; i < arr.count; i++) {
        
        //没个数据的弧度
        CGFloat angle = [arr[i] floatValue] * M_PI *2 / sumValue;
        
        //计算这一段弧度的结束为止
        endAngle = startAngle + angle ;
        
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:origin radius:90 startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        //计算下一段弧度开始的为止
        startAngle = endAngle +  M_PI *2 / sumValue*10;
        
        //从弧边 绘制到原点由于封闭路径 可以沪指扇形
        //        [path addLineToPoint:origin];
        [path setLineWidth:60];
        
        [[self randomdUIColor] set];
        
        [path stroke];
    }
    
//    UIBezierPath *path3 =  [UIBezierPath bezierPathWithArcCenter:self.center radius:100 startAngle:175.0 endAngle:230.0 clockwise:YES];
//    [path3 setLineWidth:40];
//    [[UIColor blueColor] setStroke];
//    [path3 stroke];
//
//    UIBezierPath *path4 =  [UIBezierPath bezierPathWithArcCenter:self.center radius:100 startAngle:235.0 endAngle:M_PI*2 clockwise:YES];
//    [path4 setLineWidth:40];
//    [[UIColor blueColor] setStroke];
//    [path4 stroke];
//
    
    
}
- (UIColor *)randomdUIColor{
    UIColor *color = [UIColor colorWithRed:(arc4random_uniform(256) / 255.0) green:(arc4random_uniform(256) / 255.0) blue:(arc4random_uniform(256) / 255.0) alpha:(arc4random_uniform(256) / 255.0)];
    return color;
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
     [self drawCircle];
}



@end
