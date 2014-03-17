//
//  MASExampleLabelView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 24/10/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleLabelView.h"

static UIEdgeInsets const kPadding = {10, 10, 10, 10};

@interface MASExampleLabelView ()

@property (nonatomic, strong) UILabel *shortLabel;
@property (nonatomic, strong) UILabel *longLabel;

@end

@implementation MASExampleLabelView

- (id)init {
    self = [super init];
    if (!self) return nil;

    // text courtesy of http://baconipsum.com/

    self.shortLabel = UILabel.new;
    self.shortLabel.numberOfLines = 1;
    self.shortLabel.textColor = [UIColor purpleColor];
    self.shortLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.shortLabel.text = @"Bacon3545454353535";
    [self addSubview:self.shortLabel];
//    CGSize shortSize = [self.shortLabel.text sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    
    
    self.longLabel = UILabel.new;
    self.longLabel.numberOfLines = 8;
    self.longLabel.textColor = [UIColor darkGrayColor];
    self.longLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.longLabel.text = @"Bacon ipsum dolor sit amet spare ribs fatback kielbasa salami, tri-tip jowl pastrami flank short loin rump sirloin. Tenderloin frankfurter chicken biltong rump chuck filet mignon pork t-bone flank ham hock.";
//    self.longLabel.preferredMaxLayoutWidth = 320 - shortSize.width - kPadding.left*4;
    [self addSubview:self.longLabel];

    [self.longLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).insets(kPadding);
        make.top.equalTo(self.top).insets(kPadding);
    }];

    [self.shortLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.longLabel.centerY);
        make.right.equalTo(self.right).insets(kPadding);
    }];

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    //这个地方比较绕
    
    // for multiline UILabel's you need set the preferredMaxLayoutWidth：优先选择标签布局的最大宽度。
    // you need to do this after [super layoutSubviews] as the frames will have a value from Auto Layout at this point

    // stay tuned for new easier way todo this coming soon to Masonry

    NSLog(@"self.frame : %@",NSStringFromCGRect(self.frame));
    NSLog(@"self.longLabel.frame : %@",NSStringFromCGRect(self.longLabel.frame));
    NSLog(@"self.shortLabel.frame : %@",NSStringFromCGRect(self.shortLabel.frame));
    
    //取得短标签的左顶点X坐标，减去做边距，得到长标签right的值；
    CGFloat width = CGRectGetMinX(self.shortLabel.frame) - kPadding.left;
    
    NSLog(@"width : %f",width);
    
    //用长标签的right值减去长标签左顶点X坐标，得到长标签的宽度；
    width -= CGRectGetMinX(self.longLabel.frame);
    
    NSLog(@"width : %f",width);
    
    self.longLabel.preferredMaxLayoutWidth = width;

    // need to layoutSubviews again as frames need to recalculated with preferredLayoutWidth
    [super layoutSubviews];
}

@end
