//
//  MddCircleControlView.h
//  Printer3D
//
//  Created by mac on 2017/1/7.
//  Copyright © 2017年 mdd.oscar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MddCircleCurrentParam.h"
#import "MddCircleWayParam.h"
@class SubDropView;
/*
 环形控制视图
 
 version 0.1
 by 肖光
 2016-1-9
 举例子:
 MddCircleControlView * circle_V= [MddCircleControlView initializeForNibWithDataFrame:CGRectMake(0,100, 300, 300) mBigRadius:150 mMidleRadius:100 mSmallRadius:25];
 
 [self.view addSubview:circle_V];
 [self.view bringSubviewToFront:circle_V];
 */
@interface MddCircleControlView : UIView

#pragma mark ui
@property (weak, nonatomic) IBOutlet UIView *mUiBigBgView;
@property (weak, nonatomic) IBOutlet UIView *mUiInnerCenterView;
@property (weak, nonatomic) IBOutlet SubDropView *mUiDropView;
#pragma mark data
//最大的半径
@property(nonatomic,assign) float mBigRadius;
//中间圆的半径
@property(nonatomic,assign) float mMidleRadius;
//小圆半径
@property(nonatomic,assign) float mSmallRadius;
//kOutCircleDistance
@property(nonatomic,assign) float mOutCircleDistance;
//小圆状态(0静止状态，1拖动状态,2超出界限状态)
@property(nonatomic,assign) int mSmallState;
//大圆圆心位置
@property(nonatomic,assign) CGPoint mBigCenter;
//小圆圆心位置
@property(nonatomic,assign) CGPoint mSmallCenter;
//原始位置
@property(nonatomic,assign) CGPoint mStartPoint;
//
//@property(nonatomic,strong) NSMutableDictionary * mPointsDic;
@property(nonatomic,strong) NSMutableArray * allPosArray;
//当前角度
@property(nonatomic,strong) MddCircleCurrentParam * mCurrentParam;

#pragma mark func
-(void) setParams:(float) pBigRadius mMidleRadius:(float)pMidleRadius mSmallRadius:(float) pSmallRadius;
#pragma mark 从xib初始化
//初始化
+ (instancetype)initializeForNib;
//初始化赋值
+ (instancetype)initializeForNibWithDataFrame:(CGRect )pFrame mBigRadius:(float) pBigRadius mMidleRadius:(float)pMidleRadius mSmallRadius:(float) pSmallRadius;
@end
