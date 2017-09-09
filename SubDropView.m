//
//  SubDropView.m
//  Printer3D
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 mdd.oscar. All rights reserved.
//

#import "SubDropView.h"

@implementation SubDropView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    /*     */
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 0.5);
    // 设置线条宽度
    CGContextSetLineWidth(ctx, 0.5);
    
    
    CGContextMoveToPoint(ctx, self.mStartPoint.x , self.mStartPoint.y);
    CGContextAddLineToPoint(ctx, self.mEndPoint.x, self.mEndPoint.y);
    CGContextStrokePath(ctx);
    

}


@end
