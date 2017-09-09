//
//  MddCircleCurrentParam.m
//  Printer3D
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 mdd.oscar. All rights reserved.
//

#import "MddCircleCurrentParam.h"

@implementation MddCircleCurrentParam


-(id) initWithData:(CGPoint) pCurrentCenter mToPoint:(CGPoint)pToPoint mOutPoint:(CGPoint)pOutPoint mStartPoint:(CGPoint) pStartPoint mAngle:(CGFloat)pAngle
{

    if (self=[super init]) {
        self.mCurrentCenter=pCurrentCenter;
        self.mToPoint=pToPoint;
        self.mOutPoint=pOutPoint;
        self.mStartPoint=pStartPoint;
        self.mAngle=pAngle;
    }
    return self;
}

@end
