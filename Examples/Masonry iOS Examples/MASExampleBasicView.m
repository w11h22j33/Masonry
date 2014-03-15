//
//  MASExampleBasicView.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASExampleBasicView.h"

@implementation MASExampleBasicView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    UIView *view1 = UIView.new;
    view1.backgroundColor = UIColor.greenColor;
    view1.layer.borderColor = UIColor.blackColor.CGColor;
    view1.layer.borderWidth = 2;
    [self addSubview:view1];
    
    UIView *view2 = UIView.new;
    view2.backgroundColor = UIColor.redColor;
    view2.layer.borderColor = UIColor.blackColor.CGColor;
    view2.layer.borderWidth = 2;
    [self addSubview:view2];
    
    UIView *view3 = UIView.new;
    view3.backgroundColor = UIColor.blueColor;
    view3.layer.borderColor = UIColor.blackColor.CGColor;
    view3.layer.borderWidth = 2;
    [self addSubview:view3];
    
    UIView *superview = self;
    int padding = 10;
    /**
     此处重新写了最基本的Deme，梳理依赖关系，去除不必要的约束，保证每一个约束都是必要的；
     约束分为三种：
     
     1、绝对约束：指定固定值；
     2、相对约束：指定参考条件（参考父View或者兄弟View）；
     
     注意：
     1、如果view之间存在比例依赖（如：width、height未指定绝对值时都为比例依赖），则只需要在一个view上添加约束；
     2、边界的定义都是必要的（如：top、left、bottom、right，其中不进行动态计算的边界必须定义清晰的规则：相对于父View或者绝对值），多个相互依赖关系中，不允许循环依赖；
        如下情况不能正常显示：view1.bottom.equalTo(view2.bottom);
        view2.bottom未指定或view2.bottom.equalTo(view1.bottom);
     **/
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).offset(padding);
        make.left.equalTo(superview).offset(padding);
        make.right.equalTo(superview).offset(-padding);
        
    }];
    
    
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.bottom).offset(padding);
        make.left.equalTo(superview).offset(padding);
        make.bottom.equalTo(superview).offset(-padding);
        make.width.equalTo(view3.width);
        make.height.equalTo(view1.height);
    }];
    
    [view3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.top);
        make.left.equalTo(view2.right).offset(padding);
        make.right.equalTo(superview).offset(-padding);
        make.bottom.equalTo(view2.bottom);
    }];
    
    
    
    return self;
}

@end
