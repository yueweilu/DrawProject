//
//  UnBlockView.m
//  DrawPrj
//
//  Created by 李晓明 on 2018/4/12.
//  Copyright © 2018年 lixm. All rights reserved.
//

#import "UnBlockView.h"
#import "NodeView.h"

@interface UnBlockView()
@property (nonatomic,assign) CGMutablePathRef path;
@property (nonatomic,strong) NSMutableArray *nodeViews;
@property (nonatomic,strong) NSMutableArray *throughNodeViews;//存储有效点
@property BOOL isValidateGesture;//默认是NO
@property (nonatomic,strong) NSMutableString *secret;//存储密码
@end

@implementation UnBlockView

-(instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];//背景使用图片
        self.nodeViews = [NSMutableArray array];
        self.throughNodeViews = [NSMutableArray array];
        self.secret =[ [NSMutableString alloc] init];
        [self initNodeViews];
    }
    return self;
}

-(void) initNodeViews{
    CGFloat x = self.frame.size.width/4;
    CGFloat startY = (self.frame.size.height-self.frame.size.width)/2;
    CGFloat y = x;
    for(int i = 0;i<9;i++){
        NodeView *node = [ [NodeView alloc ] init ] ;
        node.userInteractionEnabled=NO;//禁掉手势点
        //node.backgroundColor= [UIColor orangeColor] ;
        node.center = CGPointMake(x*(i%3+1),startY+y*(i/3+1));//设置中心点
        node.bounds = CGRectMake(0,0 ,50,50);//设置大小
        node.image=[UIImage imageNamed:@"gesture_node_normal"];
        node.number = [NSString stringWithFormat:@"%d",i+1];//给每个点添加标识
        [self addSubview:node];
        [self.nodeViews addObject:node];
    }
}

-(void) drawRect:(CGRect)rect{
    if(self.path){
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context,self.path);
        CGContextSetStrokeColorWithColor(context,[UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context,4);
        CGContextDrawPath(context,kCGPathStroke);
    }
}
//手势滑动是否经过点阵中的点
-(NodeView*)throungNodeViewByPoint:(CGPoint)pt{
    __block NodeView *nodeView = nil;//引入__block关键字是因为要在block中对字段赋值
    [self.nodeViews enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx,BOOL * _Nonnull stop){
        NodeView *node = obj;
        CGRect rect = node.frame;
        if(CGRectContainsPoint(rect ,pt )){//如果点已经在某区域中
            nodeView=node;
            *stop = YES;
        }
    }];
    return nodeView;
}
-(void)touchesBegan:(NSSet<UITouch *> *) touches withEvent:(UIEvent *) event{
    UITouch *touch=touches.anyObject;
    CGPoint pt=[touch locationInView:touch.view];
    //判断该点是否落在手势点中
    NodeView *nodeView = [self throungNodeViewByPoint:pt];
    if(nodeView){
        self.isValidateGesture = YES;
        //只有第一个点是有效的，才能继续执行后续操作
        self.path=CGPathCreateMutable();
        CGPathMoveToPoint(self.path,NULL,nodeView.center.x,nodeView.center.y);
        nodeView.image = [UIImage imageNamed:@"gesture_node_highlighted"];//设置选中点的图片背景
        [self.throughNodeViews addObject:nodeView];
        //密码赋值
        [self.secret appendString:nodeView.number];
    }
    
}
-(void)touchesMoved:(NSSet<UITouch *> *) touches withEvent:(UIEvent *) event {
    if(!self.isValidateGesture){
        return;
    }
    UITouch *touch=touches.anyObject;
    CGPoint pt=[touch locationInView:touch.view];
    //判断该点是否落在手势点中
    NodeView *nodeView = [self throungNodeViewByPoint:pt];
    if(nodeView){
        //是否该点出现过，出现过，不做任何处理
        if(![self.throughNodeViews containsObject:nodeView]){
            //nodeView.center 使用中心点连接
            CGPathAddLineToPoint(self.path,NULL,nodeView.center.x,nodeView.center.y);
            nodeView.image = [UIImage imageNamed:@"gesture_node_highlighted"];//设置选中点的图片背景
            [self setNeedsDisplay];
            [self.throughNodeViews addObject:nodeView];
            //密码赋值
            [self.secret appendString:nodeView.number];
        }
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *) touches withEvent:(UIEvent *) event{
    if(!self.isValidateGesture){
        return;
    }
    CGPathRelease(self.path);
    self.path=nil;
    //密码校验
    [self validateSecret];
}
//密码校验
-(void) validateSecret{
    BOOL succ = NO;
    if([self.secret isEqualToString:@"1478"]){
        succ = YES;
    }
    if(self.unblockViewBlock){
        self.unblockViewBlock(self,succ);
    }
}

-(void) reset{
    [self.throughNodeViews enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx , BOOL * _Nonnull stop){
        NodeView * node=obj;
        node.image = [UIImage imageNamed:@"gesture_node_normal"];//设置选中点的图片背景
    }];
    [self.throughNodeViews removeAllObjects];//清空集合中的点
    self.isValidateGesture=NO;
    [self.secret setString:@""];
    
    [self setNeedsDisplay];
}

@end
