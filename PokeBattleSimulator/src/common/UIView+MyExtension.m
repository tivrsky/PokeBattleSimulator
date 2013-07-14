//
//  UIView+ MyExtension.m
//  fablap
//
//  Created by fukutarohori on 2012/08/18.
//  Copyright (c) 2012年 Fukutaro Hori. All rights reserved.
//

#import "UIView+MyExtension.h"

@implementation UIView(MyExtension)

//centerX
-(CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)centerY{
    return self.center.y;
}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setX:(CGFloat)x {
    self.frame = CGRectMake( x, self.frame.origin.y, self.frame.size.width, self.frame.size.height );
}

- (CGFloat)x {
    return self.frame.origin.x;
 }

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height );
}

- (CGFloat)y {
    return self.frame.origin.y;
 }

- (void)setWidth:(NSInteger)width {
    self.frame = CGRectMake( self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height );
}

- (NSInteger)width {
    return self.frame.size.width;
}

- (void)setHeight:(NSInteger)height {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (NSInteger)height {
    return self.frame.size.height;
}

- (void)fadeInWithDuration:(NSTimeInterval)interval {
    CGFloat afterAlpha = self.alpha;
    self.alpha = (CGFloat)0.0;
    self.hidden = NO;
    [UIView beginAnimations:@"UIWindow_FadeIn" context:nil];
    [UIView setAnimationDuration:interval];
    self.alpha = afterAlpha;
    [UIView commitAnimations];
}

- (void)fadeOutWithDuration:(NSTimeInterval)interval {
    CGFloat* context = (CGFloat *)malloc(sizeof(CGFloat));
    *context = self.alpha;
    [UIView beginAnimations:@"UIWindow_FadeOut" context:context];
    [UIView setAnimationDidStopSelector:@selector(fadeOutDidStop:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:interval];
    self.alpha = (CGFloat)0.0;
    [UIView commitAnimations];
}

- (void)fadeOutDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    self.hidden = YES;
    self.alpha = *(CGFloat *)context;
    free(context);
}
@end
