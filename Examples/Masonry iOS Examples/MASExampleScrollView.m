//
//  MASExampleScrollView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 20/11/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleScrollView.h"

/**
 *  UIScrollView and Auto Layout don't play very nicely together see
 *  https://developer.apple.com/library/ios/technotes/tn2154/_index.html
 *
 *  This is an example of one workaround
 *
 *  for another approach see https://github.com/bizz84/MVScrollViewAutoLayout
 */

@interface MASExampleScrollView ()
@property (strong, nonatomic) UIScrollView* scrollView;
@end

@implementation MASExampleScrollView

- (id)init {
    self = [super init];
    if (!self) return nil;

    UIScrollView *scrollView = UIScrollView.new;
    self.scrollView = scrollView;
    scrollView.backgroundColor = [UIColor grayColor];
    [self addSubview:scrollView];
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    // We create a dummy contentView that will hold everything (necessary to use scrollRectToVisible later)
    UIView* contentView = UIView.new;
    [self.scrollView addSubview:contentView];
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView.width);
    }];
    
    UIView *lastView;
    CGFloat height = 25;

    for (int i = 0; i < 20; i++) {
        UIView *view = UIView.new;
        view.backgroundColor = [self randomColor];
        
//        if (i<19) {
            [contentView addSubview:view];
//        }else{
//            [scrollView addSubview:view];
//        }
        
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView ? lastView.bottom : @0);
            make.left.equalTo(@0);
            make.width.equalTo(contentView.width);
            make.height.equalTo(@(height));
            

            
            //此处可以直接指定最后一个子View的bottom与contentView的bottom的关系。指定后，虚拟View可以不使用。
            if (i == 19) {
                view.backgroundColor = [UIColor redColor];
                make.bottom.equalTo(contentView.bottom);
            }
            
        }];

        height += 25;
        lastView = view;
        
        // Tap
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [view addGestureRecognizer:singleTap];
        
    }

    // 需要再看一下
    
    // dummy view, which determines the size of the contentView size and therefore the scrollView contentSize
//    UIView *sizingView = UIView.new;
//    [scrollView addSubview:sizingView];
//    [sizingView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lastView.bottom);
//        make.bottom.equalTo(contentView.bottom);
//    }];
    return self;
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)singleTap:(UITapGestureRecognizer*)sender {
    sender.view.backgroundColor = [self randomColor];
//    [sender.view setAlpha:sender.view.alpha / 1.20]; // To see something happen on screen when you tap :O
    [self.scrollView scrollRectToVisible:sender.view.frame animated:YES];
};

@end
