//
//  CALayer+Animation.m
//  Hamburger
//
//  Created by Jimmy Jose on 11/08/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//

#import "CALayer+Animation.h"

@implementation CALayer (Animation)

-(void)ocb_applyAnimation:(CABasicAnimation *)animation {
    CABasicAnimation *copy = (CABasicAnimation *)[animation copy];
    
    if (!copy.fromValue) {
        copy.fromValue = [self.presentationLayer valueForKeyPath:copy.keyPath];
    }
    
    [self addAnimation:copy forKey:copy.keyPath];
    
    [self setValue:copy.toValue forKey:copy.keyPath];
    
}

@end
