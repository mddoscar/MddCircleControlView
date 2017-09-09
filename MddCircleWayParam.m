//
//  MddCircleWayParam.m
//  Printer3D
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 mdd.oscar. All rights reserved.
//

#import "MddCircleWayParam.h"

@implementation MddCircleWayParam


-(id) initWithData:(long) pIndex mPoint:(CGPoint)pPoint mAngle:(CGFloat)pAngle
{
    if (self=[super init]) {
        self.mIndex=pIndex;
        self.mPoint=pPoint;
        self.mAngle=pAngle;
        
    }
    return self;

}

@end
