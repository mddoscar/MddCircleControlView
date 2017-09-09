//
//  MddCircleWayParam.h
//  Printer3D
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 mdd.oscar. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 */
@interface MddCircleWayParam : NSObject
@property(nonatomic,assign) long mIndex;
@property(nonatomic,assign) CGPoint mPoint;
@property(nonatomic,assign) CGFloat mAngle;

-(id) initWithData:(long) pIndex mPoint:(CGPoint)pPoint mAngle:(CGFloat)pAngle;

@end
