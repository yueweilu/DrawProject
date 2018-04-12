//
//  FunctionViewController.m
//  DrawPrj
//
//  Created by 李晓明 on 2018/4/12.
//  Copyright © 2018年 lixm. All rights reserved.
//

#import "FunctionViewController.h"
#import "CanvasViewController.h"
#import "CircleViewController.h"

@interface FunctionViewController ()

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //返回键
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,20,80,50);
    [backBtn setImage:[UIImage imageNamed:@"chahao"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    //跳转到画图板界面
    UIButton *canvasBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canvasBtn.frame = CGRectMake(self.view.center.x-50 , self.view.center.y ,100 ,50);
    [canvasBtn setTitle:@"画图板" forState:UIControlStateNormal];
    [canvasBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [canvasBtn addTarget:self action:@selector(clickCanvas:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:canvasBtn];
    
    UIButton *circleBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(canvasBtn.frame), CGRectGetMinY(canvasBtn.frame)+60, 100, 50)];
    [circleBtn setTitle:@"环形圆" forState:UIControlStateNormal];
    [circleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [circleBtn addTarget:self action:@selector(circleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:circleBtn];
}
-(void) circleBtn:(id)sender{
    CircleViewController *vc=[[CircleViewController alloc] init ];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) clickBack:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void) clickCanvas:(id)sender{
    CanvasViewController *vc=[[CanvasViewController alloc] init ];
    [self.navigationController pushViewController:vc animated:YES];
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
