//
//  MddCircleControlView.m
//  Printer3D
//
//  Created by mac on 2017/1/7.
//  Copyright © 2017年 mdd.oscar. All rights reserved.
//

#import "MddCircleControlView.h"

/*
 默认值
 */
//半径
#define kCircleBigRadius 100.0
#define kCircleMidleRadius 50.0
#define kCircleSmallRadius 25.0
//矩形
#define kRectBig (kCircleBigRadius * 2)
#define kRectMidle (kCircleMidleRadius * 2)
#define kRectSmall (kCircleSmallRadius * 2)
//状态
#define kStateDef -1
#define kStateStop 0
#define kStateDrop 1
#define kStateOutView 2
//超出圆心的offset
#define kOutCircleDistanceOffSet 20
//超出范围的圆心距离
#define kOutCircleDistance (kRectSmall + kOutCircleDistanceOffSet)
//第一象限
#define kQuadrant1 @"kQuadrant1"
//第二象限
#define kQuadrant2 @"kQuadrant2"
//第三象限
#define kQuadrant3 @"kQuadrant3"
//第四象限
#define kQuadrant4 @"kQuadrant4"
#import "SubDropView.h"

@implementation MddCircleControlView
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self doCircleForView:self.mUiBigBgView];
    [self doCircleForView:self.mUiInnerCenterView];
    [self doCircleForView:self.mUiDropView];
    [self doAddEvent];
    //大圆圆心
    self.mBigCenter=self.mUiBigBgView.center;
    self.mSmallCenter=self.mUiDropView.center;
    self.mStartPoint=self.mUiDropView.center;
    self.mSmallState=kStateDef;
   
}
//重载一个
- (id)init{
    if(self=[super init]){
        [self setUserActivity:[NSUserActivity new]];
        self.userInteractionEnabled=YES;
        //默认值
        self.mBigRadius=kCircleBigRadius;
        self.mMidleRadius=kCircleMidleRadius;
        self.mSmallRadius=kCircleSmallRadius;
    }
    return  self;
}
//初始化(xib加载时自动调用)
- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super initWithCoder:aDecoder]){
        self.userInteractionEnabled=YES;
    }
    return  self;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
    }
    return self;
}
-(void) drawRect:(CGRect)rect{
    NSLog(@"drawRect:");
    /*
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0.0, 1.0, 1.0, 0.5);
    // 设置线条宽度
    CGContextSetLineWidth(ctx, 0.5);
    
    
    CGContextMoveToPoint(ctx, self.frame.size.width/2, self.frame.size.height/2);
    CGContextAddLineToPoint(ctx, self.frame.size.width, self.frame.size.height);
    CGContextStrokePath(ctx);
    //画线
    [self doDrawLine:self.mSmallCenter toPos:self.mCurrentParam.mOutPoint];
     */
    /*
    float Radus= self.frame.size.width/2;
    //用bezier曲线画遮罩层
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter: CGPointMake(self.center.x-self.frame.origin.x, self.center.y-self.frame.origin.y) radius:Radus startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer *shape=[CAShapeLayer layer];
    shape.path=path.CGPath;
    self.layer.mask=shape;

    float rx0=self.mBigRadius;
    float ry0=self.mBigRadius;
    float x=self.mBigRadius;
    float y=self.mBigRadius*2-self.mSmallRadius;
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 1.0, 0, 0, 0.5);
    // 设置线条宽度
    CGContextSetLineWidth(ctx, 0.5);
    
    
    CGContextMoveToPoint(ctx, 0, 0);
    for (int i=0; i<360; i++) {
        int NewX =(int)((x - rx0)*cos(M_PI/180*i) - (y - ry0)*sin(M_PI/180*i) + rx0);
        int NewY =(int)((x - rx0)*sin(M_PI/180*i) + (y - ry0)*cos(M_PI/180*i) + ry0);
        
        CGContextAddLineToPoint(ctx, NewX, NewY);
    }
    CGContextStrokePath(ctx);
          */
    //子视图
    //[self.mUiBigBgView setHidden:YES];
 //   [self.mUiDropView setHidden:YES];
    //[self.mUiInnerCenterView setHidden:YES];
    
    
}
-(void) doCircleForView:(UIView *) pView
{
    float Radus= pView.frame.size.width/2;
    //用bezier曲线画遮罩层
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter: CGPointMake(pView.center.x-pView.frame.origin.x, pView.center.y-pView.frame.origin.y) radius:Radus startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer *shape=[CAShapeLayer layer];
    shape.path=path.CGPath;
    pView.layer.mask=shape;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) setParams:(float) pBigRadius mMidleRadius:(float)pMidleRadius mSmallRadius:(float) pSmallRadius
{
    self.mBigRadius=pBigRadius;
    self.mMidleRadius=pMidleRadius;
    self.mSmallRadius=pSmallRadius;
    //self.mPointsDic=[self getCirleArrayDic];
    self.allPosArray=[self getCirleArray];
    self.mOutCircleDistance=kOutCircleDistanceOffSet+self.mSmallRadius*2;
    //改变ui
    CGRect bigFrame =self.mUiBigBgView.frame;
    self.mUiBigBgView.frame=CGRectMake(bigFrame.origin.x, bigFrame.origin.y, self.mBigRadius*2, self.mBigRadius*2);
    
    CGRect midleFrame =self.mUiInnerCenterView.frame;
    self.mUiInnerCenterView.frame=CGRectMake(midleFrame.origin.x, midleFrame.origin.y, self.mMidleRadius*2, self.mMidleRadius*2);
    self.mUiBigBgView.center=CGPointMake(self.mBigRadius, self.mBigRadius);
    //剧中
    self.mUiDropView.center=self.mUiBigBgView.center;
    
    self.mUiInnerCenterView.center=self.mUiBigBgView.center;
    
    CGRect smallFrame =self.mUiDropView.frame;
    self.mUiDropView.frame=CGRectMake(smallFrame.origin.x, self.mUiBigBgView.frame.size.height-self.self.mUiDropView.frame.size.height, self.mSmallRadius*2, self.mSmallRadius*2);
    
    //重新切圆
    [self doCircleForView:self.mUiBigBgView];
    [self doCircleForView:self.mUiInnerCenterView];
    [self doCircleForView:self.mUiDropView];
    
    //self.mStartPoint=CGPointMake(self.mBigRadius, self.mBigRadius*2- self.mSmallRadius);
    
    //三个圆心
    self.mBigCenter=self.mUiBigBgView.center;
    self.mSmallCenter=self.mUiDropView.center;
    self.mStartPoint=self.mUiDropView.center;
    
    //位置
    self.mCurrentParam=[[MddCircleCurrentParam alloc] initWithData:self.mUiBigBgView.center mToPoint: self.mUiDropView.center mOutPoint:CGPointMake(self.mBigRadius, self.mBigRadius*2) mStartPoint:CGPointMake(self.mBigRadius, self.mBigRadius*2) mAngle:0];
    
}
//拖动手势
-(void) doAddEvent
{

   // UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    //
    self.userInteractionEnabled=YES;
    self.mUiDropView.userInteractionEnabled=YES;
    self.mUiInnerCenterView.userInteractionEnabled=YES;
    self.mUiDropView.userInteractionEnabled=YES;
    
    //
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [ self.mUiDropView addGestureRecognizer:longPressGr];
    //[self.mUiDropView  addGestureRecognizer:pan];
    
}
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    NSLog(@"xxoo---xxoo---xxoo");
    CGPoint point = [rec translationInView:self];
    NSLog(@"%f,%f",point.x,point.y);
    rec.view.center = CGPointMake(rec.view.center.x + point.x, rec.view.center.y + point.y);
    [rec setTranslation:CGPointMake(0, 0) inView:self];
}


-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    UIView *vi=gesture.view;
    
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        /*
        NSLog(@"asin(30):%f",asin(30));
        NSLog(@"asin(0.5):%f",asin(0.5));
        NSLog(@"180/M_PI*asin(0.5):%f",180/M_PI*asin(0.5));
                NSLog(@"cos(60):%f",cos(60));*/
        if(self.mSmallState==kStateStop)
        {
            self.mUiDropView.backgroundColor=[UIColor greenColor];
           
        }
        
    }
    else if (gesture.state==UIGestureRecognizerStateChanged)
    {
        
#if 0
        
        self.mSmallState=kStateDrop;
        
        //圆形距离
        CGFloat circle_Distance=0;
        
        CGPoint newPoint = [gesture locationInView:self.mUiBigBgView];
        CGFloat deltaY = newPoint.y-self.mStartPoint.y;
        CGFloat deltaX = newPoint.x-self.mStartPoint.x;
        
        CGFloat deltaYLast = newPoint.y-self.mSmallCenter.y;
        CGFloat deltaXLast = newPoint.x-self.mSmallCenter.x;
        circle_Distance = sqrt(deltaXLast*deltaXLast+deltaYLast*deltaYLast);
        //是否顺时针
        bool isShun=false;
        if ((newPoint.y>=self.mStartPoint.y)&&(newPoint.x>=self.mStartPoint.x)) {
            isShun=false;
        }else if ((newPoint.y<self.mStartPoint.y)&&(newPoint.x>=self.mStartPoint.x)) {
            isShun=false;
        }else if ((newPoint.y>=self.mStartPoint.y)&&(newPoint.x<self.mStartPoint.x)) {
            isShun=true;
        }else if ((newPoint.y<self.mStartPoint.y)&&(newPoint.x<self.mStartPoint.x)) {
            isShun=true;
        }
        //NSLog(@"deltaY:%f,deltaX:%f,circle_Distance:%f",deltaY,deltaX,circle_Distance);
        if (circle_Distance<kOutCircleDistance) {
            //NSLog(@"vi.center.x+deltaX=====%f\n                                        vi.center.y+deltaY===%f\n                                    ",vi.center.x+deltaX,vi.center.y+deltaY);
           // vi.center=CGPointMake((vi.center.x+deltaX)*(kCircleMidleRadius*kCircleSmallRadius)*2/sqrt(pow(vi.center.x+deltaX,2)+pow(vi.center.y+deltaY,2))+kCircleBigRadius*2, (vi.center.y+deltaY)*(kCircleMidleRadius*kCircleSmallRadius)*2/sqrt(pow(vi.center.x+deltaX,2)+pow(vi.center.y+deltaY,2))+kCircleBigRadius*2);
            float kHudu=1.0f;
            float newy=vi.center.y;
            float newx=vi.center.x;
            
            kHudu=(deltaX/(self.mMidleRadius+self.mSmallRadius));
            
            
            //第一象限
            if((vi.center.x>=self.mBigCenter.x)&&(vi.center.y<=self.mBigCenter.y))
            {
                kHudu=(deltaX/(self.mMidleRadius+self.mSmallRadius));
                
                
                NSLog(@"第一象限");
                newx=self.mBigRadius+[self getAbsF:sin(kHudu)*(self.mMidleRadius+self.mSmallRadius)];
                newy=self.mBigRadius-[self getAbsF:cos(kHudu)*(self.mMidleRadius+self.mSmallRadius)];
            }
            //第二象限
            else if((vi.center.x<self.mBigCenter.x)&&(vi.center.y<=self.mBigCenter.y))
            {
                kHudu=(deltaY/(self.mMidleRadius+self.mSmallRadius));
                
                
                 NSLog(@"第二象限");
                newx=self.mBigRadius-[self getAbsF:sin(kHudu)*(self.mMidleRadius+self.mSmallRadius)];
                newy=self.mBigRadius-[self getAbsF:cos(kHudu)*(self.mMidleRadius+self.mSmallRadius)];
            }
            //第三象限
            else if((vi.center.x<self.mBigCenter.x)&&(vi.center.y>self.mBigCenter.y))
            {
                kHudu=(deltaX/(self.mMidleRadius+self.mSmallRadius));
                
                
                 NSLog(@"第三象限");
                newx=self.mBigRadius-[self getAbsF:sin(kHudu)*(self.mMidleRadius+self.mSmallRadius)];
                newy=self.mBigRadius+[self getAbsF:cos(kHudu)*(self.mMidleRadius+self.mSmallRadius)];
            }
            //第四象限
            else if((vi.center.x>=self.mBigCenter.x)&&(vi.center.y>self.mBigCenter.y))
            {
                kHudu=(deltaY/(self.mMidleRadius+self.mSmallRadius));
                
                NSLog(@"第四象限");
                newx=self.mBigRadius+[self getAbsF:sin(kHudu)*(self.mMidleRadius+self.mSmallRadius)];
                newy=self.mBigRadius+[self getAbsF:cos(kHudu)*(self.mMidleRadius+self.mSmallRadius)];
            }
            /*
            //下半部分
            if (vi.center.y>=self.mBigCenter.y) {
                k=(deltaX/(self.mMidleRadius+self.mSmallRadius));
                newy=self.mBigRadius+cos(k)*(self.mMidleRadius+self.mSmallRadius);
                
                //vi.center=CGPointMake(newPoint.x,newy);
            }else{
                k=(deltaX/(self.mMidleRadius+self.mSmallRadius));
                newy=self.mBigRadius-cos(k)*(self.mMidleRadius+self.mSmallRadius);
               // vi.center=CGPointMake(newPoint.x,self.mBigRadius-cos(asin([self getAbsF:deltaX]/(self.mMidleRadius+self.mSmallRadius))*(self.mMidleRadius+self.mSmallRadius)));
                //vi.center=CGPointMake(newPoint.x,newy);
            }
            //右边
            if (vi.center.x>=self.mBigCenter.x) {
                newx=self.mBigRadius+sin(k)*(self.mMidleRadius+self.mSmallRadius);
            }else{
                newx=self.mBigRadius-sin(k)*(self.mMidleRadius+self.mSmallRadius);
            }
             */
             vi.center=CGPointMake(newx,newy);
            self.mSmallCenter=vi.center;
            NSLog(@"k:%f,%@,circle_Distance:%f",kHudu,NSStringFromCGPoint(vi.center),circle_Distance);
            
            
        }
        
#else
        
                    
                    //圆形距离
                    CGFloat circle_Distance=0;
                    
                    CGPoint newPoint = [gesture locationInView:self.mUiBigBgView];
                    CGFloat deltaY = newPoint.y-self.mStartPoint.y;
                    CGFloat deltaX = newPoint.x-self.mStartPoint.x;
                    
                    CGFloat deltaYLast = newPoint.y-self.mSmallCenter.y;
                    CGFloat deltaXLast = newPoint.x-self.mSmallCenter.x;
                    circle_Distance = sqrt(deltaXLast*deltaXLast+deltaYLast*deltaYLast);
        //
        float newy= [[NSString stringWithFormat:@"%.2f",newPoint.y] floatValue];
        float newx=[[NSString stringWithFormat:@"%.2f",newPoint.x] floatValue];
        CGPoint dirPoint;//目标点，取最小值
        int xMax=0;
        int xMin=0;
        int yMax=0;
        int yMin=0;
        long currentIndex=0;
        if (circle_Distance<self.mOutCircleDistance) {
        
        
        //第一象限
        if((vi.center.x>=self.mBigCenter.x)&&(vi.center.y<=self.mBigCenter.y))
        {
            //边界
          //self.mBigRadius*2-self.mSmallRadius
            xMax=self.mBigRadius*2-self.mSmallRadius;
            xMin=self.mBigRadius;
            yMax=self.mBigRadius;
            yMin=self.mSmallRadius;
            
            if (newx>=xMax) {
                newx=xMax;
            }
            if (newx<=xMin) {
                newx=xMin;
            }
            if (newy>=yMax) {
                newy=yMax;
            }
            if (newy<=yMin) {
                newy=yMin;
            }

            
            NSMutableArray *  mArray1=self.allPosArray;//self.mPointsDic[kQuadrant1];
            
            MddCircleWayParam * first=mArray1[0];
            CGPoint firstPoint=first.mPoint;
            dirPoint=firstPoint;
            for (int i=1;i<mArray1.count;i++) {
                MddCircleWayParam *obj=[mArray1 objectAtIndex:i];
                CGPoint objPoint=obj.mPoint;
                if ([self getPointDisTance:dirPoint toPos:newPoint]>=[self getPointDisTance:objPoint toPos:newPoint]) {
                    dirPoint=objPoint;
                    currentIndex=i;
                }
            }
        }
        //第二象限
        else if((vi.center.x<self.mBigCenter.x)&&(vi.center.y<=self.mBigCenter.y))
        {
            
            xMax=self.mBigRadius;
            xMin=self.mSmallRadius;
            yMax=self.mBigRadius;
            yMin=self.mSmallRadius;
            
            if (newx>=xMax) {
                newx=xMax;
            }
            if (newx<=xMin) {
                newx=xMin;
            }
            if (newy>=yMax) {
                newy=yMax;
            }
            if (newy<=yMin) {
                newy=yMin;
            }
            
            NSMutableArray *  mArray2=self.allPosArray;//self.mPointsDic[kQuadrant2];
            MddCircleWayParam * first=mArray2[0];
            CGPoint firstPoint=first.mPoint;
            dirPoint=firstPoint;
            for (int i=1;i<mArray2.count;i++) {
                MddCircleWayParam *obj=[mArray2 objectAtIndex:i];
                CGPoint objPoint=obj.mPoint;
                if ([self getPointDisTance:dirPoint toPos:newPoint]>=[self getPointDisTance:objPoint toPos:newPoint]) {
                    dirPoint=objPoint;
                     currentIndex=i;
                }
            }
        }
        //第三象限
        else if((vi.center.x<self.mBigCenter.x)&&(vi.center.y>self.mBigCenter.y))
        {
            
            xMax=self.mBigRadius;
            xMin=self.mSmallRadius;
            yMax=self.mBigRadius*2-self.mSmallRadius;
            yMin=self.mBigRadius;
            
            if (newx>=xMax) {
                newx=xMax;
            }
            if (newx<=xMin) {
                newx=xMin;
            }
            if (newy>=yMax) {
                newy=yMax;
            }
            if (newy<=yMin) {
                newy=yMin;
            }
            
            NSMutableArray *  mArray3=self.allPosArray;//self.mPointsDic[kQuadrant3];
            MddCircleWayParam * first=mArray3[0];
            CGPoint firstPoint=first.mPoint;
            dirPoint=firstPoint;
            for (int i=1;i<mArray3.count;i++) {
                MddCircleWayParam *obj=[mArray3 objectAtIndex:i];
                CGPoint objPoint=obj.mPoint;
                if ([self getPointDisTance:dirPoint toPos:newPoint]>=[self getPointDisTance:objPoint toPos:newPoint]) {
                    dirPoint=objPoint;
                     currentIndex=i;
                }
            }
        }
        //第四象限
        else if((vi.center.x>=self.mBigCenter.x)&&(vi.center.y>self.mBigCenter.y))
        {
            
            xMax=self.mBigRadius*2-self.mSmallRadius;
            xMin=self.mBigRadius;
            yMax=self.mBigRadius*2-self.mSmallRadius;
            yMin=self.mBigRadius;
            
            if (newx>=xMax) {
                newx=xMax;
            }
            if (newx<=xMin) {
                newx=xMin;
            }
            if (newy>=yMax) {
                newy=yMax;
            }
            if (newy<=yMin) {
                newy=yMin;
            }
            
            NSMutableArray *  mArray4=self.allPosArray;//self.mPointsDic[kQuadrant4];
            MddCircleWayParam * first=mArray4[0];
            CGPoint firstPoint=first.mPoint;
            dirPoint=firstPoint;
            for (int i=1;i<mArray4.count;i++) {
                MddCircleWayParam *obj=[mArray4 objectAtIndex:i];
                CGPoint objPoint=obj.mPoint;
                if ([self getPointDisTance:dirPoint toPos:newPoint]>=[self getPointDisTance:objPoint toPos:newPoint]) {
                    dirPoint=objPoint;
                     currentIndex=i;
                }
                
            }

        }
        vi.center=dirPoint;//CGPointMake(newx,newy);
        self.mSmallCenter=vi.center;
            //改变圆
            self.mCurrentParam.mToPoint= self.mSmallCenter;
            MddCircleWayParam *obj=[self.allPosArray objectAtIndex:currentIndex];
            self.mCurrentParam.mAngle=obj.mAngle;
            self.mCurrentParam.mToPoint=self.mSmallCenter;
            self.mCurrentParam.mOutPoint=[self getCirleBigNewPointWithAngle:self.mCurrentParam.mAngle];
            //设置画图点
            self.mUiDropView.mStartPoint= [self.mUiDropView convertPoint:self.mCurrentParam.mToPoint fromView:self];
            self.mUiDropView.mEndPoint=[self.mUiDropView convertPoint:self.mCurrentParam.mOutPoint fromView:self];
            [self.mUiDropView setNeedsDisplay];
    }
#endif
        /*
        
        //圆形距离
        CGPoint newPoint = [gesture locationInView:gesture.view];
        CGFloat deltaY = newPoint.y-self.mStartPoint.y;
        CGFloat deltaX = newPoint.x-self.mStartPoint.x;
        CGFloat X=self.mBigRadius;
        CGFloat Y=self.mBigRadius;
        
        if (vi.center.x+deltaX<self.mBigRadius) {
            X=self.mBigRadius-(self.mBigRadius-vi.center.x-deltaX)*(self.mBigRadius-self.mSmallRadius)/sqrt(pow(vi.center.x+deltaX-self.mBigRadius,2)+pow(vi.center.y+deltaY-self.mBigRadius,2));
            
        }
        if (vi.center.x+deltaX>self.mBigRadius) {
            X=self.mBigRadius+(vi.center.x+deltaX-self.mBigRadius)*(self.mBigRadius-self.mSmallRadius)/sqrt(pow(vi.center.x+deltaX-self.mBigRadius,2)+pow(vi.center.y+deltaY-self.mBigRadius,2));
        }
        if (vi.center.y+deltaY<self.mBigRadius) {
            Y=self.mBigRadius-(self.mBigRadius-vi.center.y-deltaY)*(self.mBigRadius-self.mSmallRadius)/sqrt(pow(vi.center.x+deltaX-self.mBigRadius,2)+pow(vi.center.y+deltaY-self.mBigRadius,2));
        }
        if (vi.center.y+deltaY>self.mBigRadius) {
            Y=self.mBigRadius+(vi.center.y+deltaY-self.mBigRadius)*(self.mBigRadius-self.mSmallRadius)/sqrt(pow(vi.center.x+deltaX-self.mBigRadius,2)+pow(vi.center.y+deltaY-self.mBigRadius,2));
        }
        vi.center=CGPointMake(X, Y);
#endif
        
        
        
        
        //            if (sqrt(pow(150.0f-vi.center.x+deltaX,2)+pow(150.0f-vi.center.y+deltaY,2))>=150.0f) {
        //                vi.center=CGPointMake(sqrt(pow(110,2)-pow(vi.center.y+deltaY,2)),sqrt(pow(110,2)-pow(vi.center.x+deltaX,2)));
        //            }
*/

    }
    
    
    
    if (gesture.state==UIGestureRecognizerStateEnded)
    {
        self.mUiDropView.backgroundColor=[UIColor whiteColor];
        /*
        _tapView.backgroundColor=[UIColor blackColor];
        vi.center=CGPointMake(150,260);
        */
        if(self.mSmallState==kStateDef)
        {
            vi.center= self.mStartPoint;
            self.mSmallState=kStateStop;
        }else{
            self.mSmallState=kStateStop;
        }
        
    }
}
-(double) getAbsF:(float) pValue
{
    if (pValue>0) {
        return pValue;
    }else{
        return  -pValue;
    }
}


-(CGFloat )getPointDisTance:(CGPoint) pPos1 toPos:(CGPoint )pPos2
{
   return sqrt(pow((pPos1.x-pPos2.x),2)+pow((pPos1.y-pPos2.y),2));
}


#pragma mark 从xib初始化
+ (instancetype)initializeForNib
{
    MddCircleControlView *view = [[[NSBundle mainBundle]loadNibNamed:@"MddCircleControlView" owner:nil options:nil]lastObject];
    return view;
}
+ (instancetype)initializeForNibWithDataFrame:(CGRect )pFrame mBigRadius:(float) pBigRadius mMidleRadius:(float)pMidleRadius mSmallRadius:(float) pSmallRadius
{
    MddCircleControlView *view = [[[NSBundle mainBundle]loadNibNamed:@"MddCircleControlView" owner:nil options:nil]lastObject];
    view.frame=pFrame;
    [view setParams:pBigRadius mMidleRadius:pMidleRadius mSmallRadius:pSmallRadius];
    return view;
}
/*
 假设对图片上任意点(x,y)，绕一个坐标点(rx0,ry0)逆时针旋转a角度后的新的坐标设为(x0, y0)，有公式：
 
 x0= (x - rx0)*cos(a) - (y - ry0)*sin(a) + rx0 ;
 
 y0= (x - rx0)*sin(a) + (y - ry0)*cos(a) + ry0 ;
 
 一下是对这两条公式的证明。
 
 */
-(NSMutableDictionary *) getCirleArrayDic
{
    NSMutableDictionary * rDic=[NSMutableDictionary dictionary];
    
    float rx0=self.mBigRadius;
    float ry0=self.mBigRadius;
    float x=self.mBigRadius;
    float y=self.mBigRadius*2-self.mSmallRadius;
    NSMutableArray * tArray1=[NSMutableArray array];
    for (int i=0; i<90; i++) {
        float NewX =((x - rx0)*cos(M_PI/180*i) - (y - ry0)*sin(M_PI/180*i) + rx0);
        float NewY =((x - rx0)*sin(M_PI/180*i) + (y - ry0)*cos(M_PI/180*i) + ry0);
        [tArray1 addObject:[NSValue valueWithCGPoint:CGPointMake([[NSString stringWithFormat:@"%.2f",NewX] floatValue], [[NSString stringWithFormat:@"%.2f",NewY] floatValue])]];
    }
    NSMutableArray * tArray2=[NSMutableArray array];
    for (int i=91; i<180; i++) {
        float NewX =((x - rx0)*cos(M_PI/180*i) - (y - ry0)*sin(M_PI/180*i) + rx0);
        float NewY =((x - rx0)*sin(M_PI/180*i) + (y - ry0)*cos(M_PI/180*i) + ry0);
        [tArray2 addObject:[NSValue valueWithCGPoint:CGPointMake([[NSString stringWithFormat:@"%.2f",NewX] floatValue], [[NSString stringWithFormat:@"%.2f",NewY] floatValue])]];
    }    NSMutableArray * tArray3=[NSMutableArray array];
    for (int i=181; i<270; i++) {
        float NewX =((x - rx0)*cos(M_PI/180*i) - (y - ry0)*sin(M_PI/180*i) + rx0);
        float NewY =((x - rx0)*sin(M_PI/180*i) + (y - ry0)*cos(M_PI/180*i) + ry0);
        [tArray3 addObject:[NSValue valueWithCGPoint:CGPointMake([[NSString stringWithFormat:@"%.2f",NewX] floatValue], [[NSString stringWithFormat:@"%.2f",NewY] floatValue])]];
    }
    NSMutableArray * tArray4=[NSMutableArray array];
    for (int i=271; i<360; i++) {
        float NewX =((x - rx0)*cos(M_PI/180*i) - (y - ry0)*sin(M_PI/180*i) + rx0);
        float NewY =((x - rx0)*sin(M_PI/180*i) + (y - ry0)*cos(M_PI/180*i) + ry0);
        [tArray4 addObject:[NSValue valueWithCGPoint:CGPointMake([[NSString stringWithFormat:@"%.2f",NewX] floatValue], [[NSString stringWithFormat:@"%.2f",NewY] floatValue])]];
    }
    [rDic setObject:tArray1 forKey:kQuadrant1];
    [rDic setObject:tArray2 forKey:kQuadrant2];
    [rDic setObject:tArray3 forKey:kQuadrant3];
    [rDic setObject:tArray4 forKey:kQuadrant4];
    return rDic;
}
-(NSMutableArray *) getCirleArray
{
    NSMutableArray * rArray=[NSMutableArray array];
    
    float rx0=self.mBigRadius;
    float ry0=self.mBigRadius;
    float x=self.mBigRadius;
    float y=self.mBigRadius*2-self.mSmallRadius;
    for (int i=0; i<360; i++) {
        float NewX =((x - rx0)*cos(M_PI/180*i) - (y - ry0)*sin(M_PI/180*i) + rx0);
        float NewY =((x - rx0)*sin(M_PI/180*i) + (y - ry0)*cos(M_PI/180*i) + ry0);

        [rArray addObject:[[MddCircleWayParam alloc]initWithData:i mPoint:CGPointMake([[NSString stringWithFormat:@"%.2f",NewX] floatValue], [[NSString stringWithFormat:@"%.2f",NewY] floatValue]) mAngle:M_PI/180*i]];
        
       // [rArray addObject:[NSValue valueWithCGPoint:CGPointMake([[NSString stringWithFormat:@"%.2f",NewX] floatValue], [[NSString stringWithFormat:@"%.2f",NewY] floatValue])]];
    }
    return rArray;
}
//获取圆周位置
-(CGPoint) getCirleBigNewPointWithAngle:(CGFloat)pAngle
{
    float rx0=self.mBigRadius;
    float ry0=self.mBigRadius;
    float x=self.mBigRadius;
    float y=self.mBigRadius*2;
    float NewX =((x - rx0)*cos(pAngle) - (y - ry0)*sin(pAngle) + rx0);
    float NewY =((x - rx0)*sin(pAngle) + (y - ry0)*cos(pAngle) + ry0);
    return CGPointMake([[NSString stringWithFormat:@"%.2f",NewX] floatValue], [[NSString stringWithFormat:@"%.2f",NewY] floatValue]);
}
-(void) doDrawLine:(CGPoint) pos1 toPos:(CGPoint) pos2
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0.0, 1.0, 1.0, 0.5);
    // 设置线条宽度
    CGContextSetLineWidth(ctx, 0.5);
    
    
    CGContextMoveToPoint(ctx, pos1.x, pos1.y);
    CGContextAddLineToPoint(ctx, pos2.x, pos2.y);
    CGContextStrokePath(ctx);
}

@end
