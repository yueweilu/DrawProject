//
//  ViewController.m
//  DrawPrj
//
//  Created by 李晓明 on 2018/4/12.
//  Copyright © 2018年 lixm. All rights reserved.
//

#import "ViewController.h"
#import "UnBlockView.h"
#import "FunctionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UnBlockView *blockView=[[UnBlockView alloc]initWithFrame:self.view.frame];
    //blockView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:blockView];
    
    //添加密码校验回调
    __weak typeof(blockView) weakBlockView = blockView;
    weakBlockView.unblockViewBlock = ^(UnBlockView *bView,BOOL success){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"title" message:success?@"解锁成功":@"解锁失败" preferredStyle:UIAlertControllerStyleAlert ];
        UIAlertAction *actionAlert = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
            [weakBlockView reset];//重置信息
            if(success){
                //跳转到一个新界面
                FunctionViewController *vc = [[FunctionViewController alloc] init ];
//                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//                [nav setNavigationBarHidden:YES];
//                [self presentViewController:nav animated:YES completion:nil];
                [self.navigationController pushViewController:vc animated:NO];
            }else {
                //消失  重置密码
            }
        }];
     
        [alert addAction:actionAlert];
        [self presentViewController:alert animated:YES completion:nil];
 
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
