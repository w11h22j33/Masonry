//
//  MASExampleUpdateView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 3/11/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleUpdateView.h"

@interface MASExampleUpdateView ()

@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) CGSize buttonSize;

@end

@implementation MASExampleUpdateView

- (id)init {
    self = [super init];
    if (!self) return nil;

    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.growingButton setTitle:@"Grow Me!" forState:UIControlStateNormal];
    self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.growingButton.layer.borderWidth = 5;

    [self.growingButton addTarget:self action:@selector(didTapGrowButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.growingButton];

    self.buttonSize = CGSizeMake(50, 50);

    // make sure updateConstraints gets called
    [self setNeedsUpdateConstraints];

    return self;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {

    static int count = 0;
    
    NSLog(@"updateConstraints --> %d",++count);
    
    [self.growingButton updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@(self.buttonSize.width)).priorityLow();
        make.height.equalTo(@(self.buttonSize.height)).priorityLow();
        make.width.lessThanOrEqualTo(self);
        make.height.lessThanOrEqualTo(self);
    }];
    
    //according to apple super should be called at end of method
    //    自定义view应该重写此方法在其中建立constraints. 注意：要在实现在最后调用
    [super updateConstraints];
}

- (void)didTapGrowButton:(UIButton *)button {
    self.buttonSize = CGSizeMake(self.buttonSize.width * 1.2, self.buttonSize.height * 1.2);

    // tell constraints they need updating
    // 此方法会将view当前的layout设置为无效的，并在下一个upadte cycle里去触发layout更新。
    [self setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    // 立即触发更新约束
    [self updateConstraintsIfNeeded];

    [UIView animateWithDuration:0.4 animations:^{
        
        //  使用此方法强制立即进行layout,从当前view开始，此方法会遍历整个view层次(包括superviews)请求layout。因此，调用此方法会强制整个view层次布局。
        [self layoutIfNeeded];
    }];
}

@end
