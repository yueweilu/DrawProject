//
//  ToolView.m
//  DrawPrj
//
//  Created by 李晓明 on 2018/4/12.
//  Copyright © 2018年 lixm. All rights reserved.
//

#import "ToolView.h"

#define Padding 5
#define Width ((self.frame.size.width-4*Padding)/5)

@interface ToolView()
@property (nonatomic,strong) UIButton *penBtn;
@property (nonatomic,strong) UIButton *eraserBtn;
@property (nonatomic,strong) UIButton *colorBtn;
@property (nonatomic,strong) UIButton *undoBtn;
@property (nonatomic,strong) UIButton *clearBtn;
@property (nonatomic,strong) UIButton *saveBtn;
@property (nonatomic,strong) UILabel *lbLineWidth;
@property (nonatomic,strong) UISlider *sliderLine;
@end

@implementation ToolView

-(instancetype)initWithFrame:(CGRect ) frame{
    if(self=[super initWithFrame:frame]){
        [self addSubview:self.penBtn];
        [self addSubview:self.eraserBtn];
        [self addSubview:self.colorBtn];
        [self addSubview:self.undoBtn];
        [self addSubview:self.clearBtn];
        [self addSubview:self.saveBtn];
        [self addSubview:self.lbLineWidth];
        [self addSubview:self.sliderLine];
    }
    return self;
}
-(void)penAction{
    [self.penBtn setBackgroundColor:[UIColor colorWithRed:210.0/255 green:105.0/255 blue:30.0/255 alpha:1]];
    [self.eraserBtn setBackgroundColor:[UIColor orangeColor]];
    if(self.penBlock){
        self.penBlock();
    }
}
-(void)eraseAction{
    [self.eraserBtn setBackgroundColor:[UIColor colorWithRed:210.0/255 green:105.0/255 blue:30.0/255 alpha:1]];
    [self.penBtn setBackgroundColor:[UIColor orangeColor]];
    if(self.eraserBlock){
        self.eraserBlock();
    }
}
-(void)colorAction{
    if(self.colorBlock){
        self.colorBlock();
    }
}
-(void)undoAction{
    if(self.undoBlock){
        self.undoBlock();
    }
}
-(void)clearAction{
    if(self.clearBlock){
        self.clearBlock();
    }
}
-(void)saveAction{
    if(self.saveBlock){
        self.saveBlock();
    }
}
-(void)sliderAction:(UISlider*)slider{
    if(self.sliderBlock){
        CGFloat width = slider.value*10;
        if(width < 1){
            width=1;
        }
        self.lbLineWidth.text = [NSString stringWithFormat:@"%.0f",width];
        self.sliderBlock(width);
    }
}
-(UIButton *) penBtn{
    if(!_penBtn){
        _penBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _penBtn.frame = CGRectMake(0,0,Width,40);
        [_penBtn setTitle:@"画笔" forState:UIControlStateNormal];
        _penBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_penBtn setBackgroundColor:[UIColor colorWithRed:210.0/255 green:105.0/255 blue:30.0/255 alpha:1]];
        [_penBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_penBtn addTarget:self action:@selector(penAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _penBtn;
}
-(UIButton *) eraserBtn{
    if(!_eraserBtn){
        _eraserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _eraserBtn.frame = CGRectMake(CGRectGetMaxX(self.penBtn.frame)+Padding,0,Width,40);
        [_eraserBtn setTitle:@"橡皮擦" forState:UIControlStateNormal];
        _eraserBtn.titleLabel.font = [UIFont systemFontOfSize:14];
         [_eraserBtn setBackgroundColor:[UIColor orangeColor]];
        [_eraserBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_eraserBtn addTarget:self action:@selector(eraseAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _eraserBtn;
}
-(UIButton *) colorBtn{
    if(!_colorBtn){
        _colorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _colorBtn.frame = CGRectMake(CGRectGetMaxX(self.eraserBtn.frame)+Padding,0,Width,40);
        [_colorBtn setTitle:@"颜色" forState:UIControlStateNormal];
        _colorBtn.titleLabel.font = [UIFont systemFontOfSize:14];
          [_colorBtn setBackgroundColor:[UIColor orangeColor]];
        [_colorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_colorBtn addTarget:self action:@selector(colorAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _colorBtn;
}
-(UIButton *) undoBtn{
    if(!_undoBtn){
        _undoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _undoBtn.frame = CGRectMake(CGRectGetMaxX(self.colorBtn.frame)+Padding,0,Width,40);
        [_undoBtn setTitle:@"回退" forState:UIControlStateNormal];
        _undoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
         [_undoBtn setBackgroundColor:[UIColor orangeColor]];
        [_undoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_undoBtn addTarget:self action:@selector(undoAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _undoBtn;
}
-(UIButton *) clearBtn{
    if(!_clearBtn){
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearBtn.frame = CGRectMake(CGRectGetMaxX(self.undoBtn.frame)+Padding,0,Width,40);
        [_clearBtn setTitle:@"清屏" forState:UIControlStateNormal];
        _clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
         [_clearBtn setBackgroundColor:[UIColor orangeColor]];
        [_clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _clearBtn;
}
//第二行显示
-(UIButton *) saveBtn{
    if(!_saveBtn){
        _saveBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame = CGRectMake(CGRectGetMinX(self.clearBtn.frame),45,Width,40);
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
         [_saveBtn setBackgroundColor:[UIColor orangeColor]];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _saveBtn;
}
-(UISlider*) sliderLine{
    if(!_sliderLine){
        _sliderLine = [ [UISlider alloc] initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame) -40,CGRectGetWidth(self.frame)*1/3 , 30)];
        [_sliderLine addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        _sliderLine.value = 0.2;
    }
    return _sliderLine;
}
-(UILabel*) lbLineWidth{
    if(!_lbLineWidth){
        _lbLineWidth = [ [UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.sliderLine.frame)+20,CGRectGetMinY(self.sliderLine.frame),CGRectGetWidth(self.frame)*1/3-30,CGRectGetHeight(self.sliderLine.frame)) ];
        _lbLineWidth.font= [UIFont systemFontOfSize:15] ;
        _lbLineWidth.text = @"2";
        _lbLineWidth.textColor = [UIColor orangeColor];
    }
    return _lbLineWidth;
}


@end
