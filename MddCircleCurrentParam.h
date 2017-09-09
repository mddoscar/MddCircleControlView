//
//  MddCircleCurrentParam.h
//  Printer3D
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 mdd.oscar. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 当前角度
 */
@interface MddCircleCurrentParam : NSObject
//正中间圆心
@property(nonatomic,assign) CGPoint mCurrentCenter;
//当前点位置(小圆圆心)
@property(nonatomic,assign) CGPoint mToPoint;
//触点坐标
@property(nonatomic,assign) CGPoint mOutPoint;
//开始位置
@property(nonatomic,assign) CGPoint mStartPoint;
//旋转角度
@property(nonatomic,assign)CGFloat mAngle;


-(id) initWithData:(CGPoint) pCurrentCenter mToPoint:(CGPoint)pToPoint mOutPoint:(CGPoint)pOutPoint mStartPoint:(CGPoint) pStartPoint mAngle:(CGFloat)pAngle;




@end
