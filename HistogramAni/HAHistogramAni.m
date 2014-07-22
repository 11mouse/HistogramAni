//
//  HAHistogramAni.m
//  HistogramAni
//
//  Created by duan on 13-7-2.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import "HAHistogramAni.h"

@interface HAHistogramAni()
{
    double showMaxValue;
    NSTimer *timer;
    UIFont *dataFont;
    
    CGSize dataFontSize;
    
    CGFloat itemSpace;
    CGFloat itemWidth;
    CGFloat itemStartX;
    CGFloat itemMaxLength;
    CGFloat drawStep;
    
    double currDrawData;
    double colorR;
    double colorG;
    double colorB;
    
    double initColorR;
    double initColorG;
    double initColorB;
}
@property(nonatomic,retain) NSArray *oriDataArr;
@end

@implementation HAHistogramAni
@synthesize oriDataArr=_oriDataArr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
        itemSpace=10;
        itemWidth=20;
        itemStartX=10;
        itemMaxLength=230;
        
        dataFont=[UIFont boldSystemFontOfSize:12];
        [dataFont retain];
        dataFontSize=[@"5" sizeWithFont:dataFont];
    }
    return self;
}

-(void)showHistogramAni:(NSArray*)dataArr
{
    self.oriDataArr=dataArr;
    if (self.oriDataArr&&self.oriDataArr.count>0) {
        showMaxValue=[self getMaxValue];
        
        drawStep=showMaxValue/100.0;
        
        currDrawData=0;
        srandom(time(NULL));
        initColorR=(arc4random()%10)/10.0;
        initColorG=(arc4random()%10)/10.0;
        initColorB=(arc4random()%10)/10.0;
        if (!timer) {
            timer=[NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(timer_Interval) userInfo:nil repeats:YES];
            [timer retain];
        }
    }
}

-(double)getMaxValue
{
    NSInteger maxValue=0;
    for (NSNumber *num in self.oriDataArr) {
        double currValue=[num doubleValue];
        if (currValue>maxValue) {
            maxValue=currValue;
        }
    }
    NSString *valueStr=[NSString stringWithFormat:@"%d",maxValue];
    return pow(10, valueStr.length);
    
}

-(void)timer_Interval
{
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    currDrawData=currDrawData+drawStep;
    if (currDrawData>showMaxValue) {
        if (timer) {
            [timer invalidate];
            [timer release];
            timer=nil;
        }
    }
    
    colorR=initColorR;
    colorG=initColorG;
    colorB=initColorB;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    for (NSInteger i=0;i<_oriDataArr.count;i++) {
        
        colorR=colorR+0.1;
        if (colorR>1) {
            colorR=colorR-1;
        }
        colorG=colorG+0.3;
        if (colorG>1) {
            colorG=colorG-1;
        }
        colorB=colorG+0.5;
        if (colorB>1) {
            colorB=colorB-1;
        }
        
        CGContextSetFillColor(contextRef, CGColorGetComponents( [[UIColor colorWithRed:colorR green:colorG blue:colorB alpha:1.0] CGColor]));
        NSNumber *currNum=[_oriDataArr objectAtIndex:i];
        double currData=[currNum doubleValue];
        
        CGContextMoveToPoint(contextRef, itemStartX, (i+1)*itemSpace+i*itemWidth);
        
        double drawData=0;
        if (currDrawData<currData) {
            drawData=currDrawData;
        }
        else //if (currDrawData>=currData&&currDrawData-currData<drawStep)
        {
            drawData=currData;
        }
        CGFloat drawLength=drawData/showMaxValue*itemMaxLength;
        CGContextAddRect(contextRef, CGRectMake(itemStartX, (i+1)*itemSpace+i*itemWidth,drawLength , itemWidth));
        
        CGContextFillPath(contextRef);
        
        CGContextSetFillColor(contextRef, CGColorGetComponents( [[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] CGColor]));
        NSString *dataStr=[NSString stringWithFormat:@"%.0f",drawData];
        [dataStr drawAtPoint:CGPointMake(itemStartX+drawLength+dataFontSize.width, (i+1)*itemSpace+i*itemWidth+(itemWidth-dataFontSize.height)/2.0) withFont:dataFont];
    }
    
}

-(void)stopAni
{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer=nil;
    }
}


@end
