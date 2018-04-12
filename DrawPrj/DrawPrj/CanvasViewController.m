//
//  CanvasViewController.m
//  DrawPrj
//
//  Created by 李晓明 on 2018/4/12.
//  Copyright © 2018年 lixm. All rights reserved.
//

#import "CanvasViewController.h"
#import "CanvasView.h"
#import "ToolView.h"
#import "ColorView.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface CanvasViewController ()

@property (nonatomic,strong) CanvasView *canvasView;
@property (nonatomic,strong) ToolView *toolView;
@property (nonatomic,strong) ColorView *colorView;

@property BOOL bEraserMode;//标识是橡皮擦模式，还是画笔模式
@property UIColor *lastColor;//橡皮擦模式时，更改颜色和线宽不起作用，要先记录起来
@property CGFloat lastLineWidth;
@end



@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.lastColor = [UIColor blackColor];
    self.lastLineWidth = 2;
    
    
    [self.view addSubview:self.canvasView];
    [self.view addSubview:self.toolView];
    [self.view addSubview:self.colorView];
    [self configToolView];
    
    //返回键
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(self.view.center.x-40,CGRectGetHeight(self.view.frame)-50,80,50);
    [backBtn setImage:[UIImage imageNamed:@"chahao"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
}

-(void)configToolView{
    //防止循环引用
    __weak typeof(self) weakself = self;
    self.toolView.penBlock = ^{
        weakself.bEraserMode = NO;
        weakself.canvasView.color = weakself.lastColor;
        weakself.canvasView.lineWidth = weakself.lastLineWidth;
    };
    self.toolView.eraserBlock = ^{
        weakself.bEraserMode = YES;
        weakself.canvasView.color = [UIColor whiteColor];
        weakself.canvasView.lineWidth = 50;
    };
    self.toolView.colorBlock = ^{
        [weakself.colorView showAnimation];
        
    };
    self.toolView.undoBlock = ^{
        //清除最后一条线
        [weakself.canvasView undo];
    };
    self.toolView.clearBlock = ^{
        [weakself.canvasView clear];
    };
    self.toolView.saveBlock = ^{
        [weakself saveImageToAlbum:[weakself screenView:weakself.canvasView]];
    };
    self.toolView.sliderBlock = ^(CGFloat width){
        if(!weakself.bEraserMode){
            weakself.canvasView.lineWidth = width;}
        weakself.lastLineWidth = width;
    };
    
}
//保存图片
-(void)saveImageToAlbum:(UIImage *) image{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        NSLog(@"没有访问权限");
    }else{
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image: didFinishSavingWithError: contextInfo:), (__bridge void*)self);
    }
}
//截屏
-(UIImage *) screenView:(UIView*)view{
    CGRect rect = view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
//保存图片 回调
-(void)image:(UIImage*)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存图片失败");
    }else{
        NSLog(@"保存图片成功");
    }
}

-(ToolView *) toolView{
    if(!_toolView){
        _toolView = [[ToolView alloc] initWithFrame:CGRectMake(20,30,self.view.frame.size.width-40,100)];
    }
    return _toolView;
}

-(CanvasView *)canvasView{
    if(!_canvasView){
        _canvasView = [[CanvasView alloc] initWithFrame:CGRectMake(20,130,self.view.frame.size.width - 40 ,self.view.frame.size.height -130 -20)];
    }
    return _canvasView;
}

-(ColorView*)colorView{
    if (!_colorView) {
        _colorView = [[ColorView alloc]initWithFrame:self.view.frame];//设置为整个view的大小
        __weak typeof (self) weakify = self;
        _colorView.selectColorBlock = ^(UIColor *color){
            if (!weakify.bEraserMode) {
                weakify.canvasView.color = color;
            }
            weakify.lastColor = color;
        };
    }
    return _colorView;
}

-(void) clickBack:(id)sender{
    //因为进栈是push进来，所有这里pop出去
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
