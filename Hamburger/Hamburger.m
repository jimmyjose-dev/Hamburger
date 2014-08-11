//
//  Hamburger.m
//  Hamburger
//
//  Created by Jimmy Jose on 11/08/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//

#import "Hamburger.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "CALayer+Animation.h"

@interface Hamburger ()
@property(nonatomic, retain) CAShapeLayer *top;
@property(nonatomic, retain) CAShapeLayer *middle;
@property(nonatomic, retain) CAShapeLayer *bottom;
@end

@implementation Hamburger

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGFloat hamburgerStrokeStart = 0.028;
        CGFloat hamburgerStrokeEnd = 0.111;
        
        self.top = [CAShapeLayer new];
        self.middle = [CAShapeLayer new];
        self.bottom = [CAShapeLayer new];
        
        self.top.path = [self shortStroke];
        self.middle.path = [self outline];
        self.bottom.path = [self shortStroke];
        
        
        
            for (CAShapeLayer *layer in @[ self.top, self.middle, self.bottom ]) {
               
                layer.fillColor = nil;
                layer.strokeColor = [UIColor whiteColor].CGColor;
                layer.lineWidth = 4;
                layer.miterLimit = 4;
                layer.lineCap = kCALineCapRound;
                layer.masksToBounds = YES;
                
                CGPathRef strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4);
                
                layer.bounds = CGPathGetPathBoundingBox(strokingPath);
                
                layer.actions = @{
                                 @"strokeStart": [NSNull null],
                                 @"strokeEnd":  [NSNull null],
                                 @"transform":  [NSNull null]
                                 };
                
                [self.layer addSublayer:layer];
            }
            
        self.top.anchorPoint = CGPointMake(28.0 / 30.0, 0.5);
        self.top.position = CGPointMake(40, 18);
        
        self.middle.position = CGPointMake(27, 27);
        
        
        self.middle.strokeStart = hamburgerStrokeStart;
        self.middle.strokeEnd = hamburgerStrokeEnd;
        
        self.bottom.anchorPoint = CGPointMake(28.0 / 30.0, 0.5);
        self.bottom.position = CGPointMake(40, 36);
        
        
        
    }
    return self;
}


-(void)setShowsMenu:(BOOL)showsMenu{

    _showsMenu = showsMenu;
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];

    CGFloat menuStrokeStart = 0.325;
    CGFloat menuStrokeEnd = 0.9;

    CGFloat hamburgerStrokeStart = 0.028;
    CGFloat hamburgerStrokeEnd = 0.111;
    
    if (showsMenu) {
        strokeStart.toValue = [NSNumber numberWithFloat:menuStrokeStart];
        strokeStart.duration = 0.5;
        
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.25: -0.4: 0.5: 1];
        
        strokeEnd.toValue = [NSNumber numberWithFloat:menuStrokeEnd];
        strokeEnd.duration = 0.6;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.25: -0.4: 0.5: 1];
    } else {
        strokeStart.toValue = [NSNumber numberWithFloat:hamburgerStrokeStart];
        strokeStart.duration = 0.5;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.25: 0: 0.5: 1.2];
        strokeStart.beginTime = CACurrentMediaTime() + 0.1;
        strokeStart.fillMode = kCAFillModeBackwards;
        
        strokeEnd.toValue = [NSNumber numberWithFloat:hamburgerStrokeEnd];
        strokeEnd.duration = 0.6;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.25: 0.3: 0.5: 0.9];
    }
    
    
    [self.middle ocb_applyAnimation:strokeStart];
    [self.middle ocb_applyAnimation:strokeEnd];
    
    CABasicAnimation *topTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
  
    topTransform.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.5: -0.8: 0.5: 1.85];
    topTransform.duration = 0.4;
    topTransform.fillMode = kCAFillModeBackwards;
    
    
    CABasicAnimation *bottomTransform = (CABasicAnimation *)[topTransform copy];
    
    if (showsMenu) {
        CATransform3D translation = CATransform3DMakeTranslation(-4, 0, 0);
        
        topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, -0.7853975, 0, 0, 1)];
        topTransform.beginTime = CACurrentMediaTime() + 0.25;
        
        bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, 0.7853975, 0, 0, 1)];
        bottomTransform.beginTime = CACurrentMediaTime() + 0.25;
    } else {
        topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        topTransform.beginTime = CACurrentMediaTime() + 0.05;
        
        bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        bottomTransform.beginTime = CACurrentMediaTime() + 0.05;
    }
    
    [self.top ocb_applyAnimation:topTransform];
    [self.bottom ocb_applyAnimation:bottomTransform];

}

-(CGMutablePathRef)shortStroke{

    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, nil, 2, 2);
    CGPathAddLineToPoint(path, nil, 28, 2);

    return path;

}

-(CGMutablePathRef)outline{

    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, nil, 10, 27);
    CGPathAddCurveToPoint(path, nil, 12.00, 27.00, 28.02, 27.00, 40, 27);
    CGPathAddCurveToPoint(path, nil, 55.92, 27.00, 50.47,  2.00, 27,  2);
    CGPathAddCurveToPoint(path, nil, 13.16,  2.00,  2.00, 13.16,  2, 27);
    CGPathAddCurveToPoint(path, nil,  2.00, 40.84, 13.16, 52.00, 27, 52);
    CGPathAddCurveToPoint(path, nil, 40.84, 52.00, 52.00, 40.84, 52, 27);
    CGPathAddCurveToPoint(path, nil, 52.00, 13.16, 42.39,  2.00, 27,  2);
    CGPathAddCurveToPoint(path, nil, 13.16,  2.00,  2.00, 13.16,  2, 27);
    
    return path;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
