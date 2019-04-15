//
//  MSTableView.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSTableView.h"

@implementation MSTableView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    return hitView;
}

@end
