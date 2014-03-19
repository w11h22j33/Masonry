//
//  UIView+MASAdditions.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "View+MASAdditions.h"
#import <objc/runtime.h>

@implementation MAS_VIEW (MASAdditions)

//创建约束构造器，调用传入的block进行约束构造，返回约束数组
- (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (MASViewAttribute *)mas_left {
    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (MASViewAttribute *)mas_top {
    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (MASViewAttribute *)mas_right {
    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (MASViewAttribute *)mas_bottom {
    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (MASViewAttribute *)mas_leading {
    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}

- (MASViewAttribute *)mas_trailing {
    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (MASViewAttribute *)mas_width {
    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (MASViewAttribute *)mas_height {
    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (MASViewAttribute *)mas_centerX {
    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (MASViewAttribute *)mas_centerY {
    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (MASViewAttribute *)mas_baseline {
    return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}

#pragma mark - associated properties

- (id)mas_key {
    return objc_getAssociatedObject(self, @selector(mas_key));
}

//设置调试输出日志的对象名称
- (void)setMas_key:(id)key {
    objc_setAssociatedObject(self, @selector(mas_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

//查找当前view与指定view的最小共同父view
- (instancetype)mas_closestCommonSuperview:(MAS_VIEW *)view {
    MAS_VIEW *closestCommonSuperview = nil;

    MAS_VIEW *secondViewSuperview = view;
    
    //条件：未找到共同父view && 指定view不为空
    while (!closestCommonSuperview && secondViewSuperview) {
        
        //循环遍历从指定view开始及以上的所有view
        
        MAS_VIEW *firstViewSuperview = self;
        
        //条件：未找到共同父view && 当前view不为空
        while (!closestCommonSuperview && firstViewSuperview) {
            
            //循环遍历当前view开始及以上的所有view
            
            if (secondViewSuperview == firstViewSuperview) {
                
                //判断指定view的当前父view与当前view的当前父view是否为同一view
                
                closestCommonSuperview = secondViewSuperview;
            }
            
            //指定下一次循环中，当前view的父view为本次循环view的父view
            firstViewSuperview = firstViewSuperview.superview;
        }
        
        //指定下一次循环中，指定view的父view为本次循环view的父view
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
