//
//  UIView+ MyExtension.h
//  fablap
//
//  Created by fukutarohori on 2012/08/18.
//  Copyright (c) 2012年 Fukutaro Hori. All rights reserved.
//

@interface UIView(MyExtension)

@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)NSInteger width;
@property (nonatomic, assign)NSInteger height;

- (void)fadeInWithDuration:(NSTimeInterval)interval;

- (void)fadeOutWithDuration:(NSTimeInterval)interval;

- (void)fadeOutDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;


@end
