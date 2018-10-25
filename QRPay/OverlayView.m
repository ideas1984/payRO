//
//  OverlayView.m
//  QRPay
//
//  Created by Marius Tanasoiu on 10/24/18.
//  Copyright © 2018 PayRO. All rights reserved.
//

#import "OverlayView.h"

@implementation OverlayView

NSArray *rectsArray;

UIColor *backgroundColor;
CGRect holeRect;
UIView *scannerRedLine;
int height = 180;
int width = 240;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void) customInit {
    backgroundColor = [UIColor blackColor];
    self.alpha = 0.5;
    self.opaque = NO;
}

- (void)drawRect:(CGRect)rect {
    [backgroundColor setFill];
    UIRectFill(rect);
    
    int leftX = (rect.size.width / 2) - (width / 2);
    int rightX = (rect.size.width / 2) + (width / 2);
    int topY = (rect.size.height / 2) - (height / 2);
    int bottomY = (rect.size.height / 2) + (height / 2);
    
    //draw transparent scanning rectangle
    CGRect holeRectIntersection = CGRectIntersection( CGRectMake(leftX, topY, width, height), rect );
    [[UIColor clearColor] setFill];
    UIRectFill(holeRectIntersection);
    
    //draw green borders
    int borderThickness = 3;
    int borderLength = 30;
    
    CGRect ul1 = CGRectIntersection( CGRectMake(leftX - borderThickness, topY - borderThickness, borderLength, borderThickness), rect );
    CGRect ul2 = CGRectIntersection( CGRectMake(leftX - borderThickness, topY - borderThickness, borderThickness, borderLength), rect );
    
    CGRect ur1 = CGRectIntersection( CGRectMake(rightX + borderThickness - borderLength, topY - borderThickness, borderLength, borderThickness), rect );
    CGRect ur2 = CGRectIntersection( CGRectMake(rightX, topY - borderThickness, borderThickness, borderLength), rect );
    
    CGRect bl1 = CGRectIntersection( CGRectMake(leftX - borderThickness, bottomY, borderLength, borderThickness), rect );
    CGRect bl2 = CGRectIntersection( CGRectMake(leftX - borderThickness, bottomY + borderThickness - borderLength, borderThickness, borderLength), rect );
    
    CGRect br1 = CGRectIntersection( CGRectMake(rightX + borderThickness - borderLength, bottomY, borderLength, borderThickness), rect );
    CGRect br2 = CGRectIntersection( CGRectMake(rightX, bottomY + borderThickness - borderLength, borderThickness, borderLength), rect );
    
    [[UIColor yellowColor] setFill];
    UIRectFill(ul1);
    UIRectFill(ul2);
    UIRectFill(ur1);
    UIRectFill(ur2);
    UIRectFill(bl1);
    UIRectFill(bl2);
    UIRectFill(br1);
    UIRectFill(br2);
    
    //scanner red line
    scannerRedLine = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width / 2) - (width / 2), rect.size.height / 2, width, 1)];
    scannerRedLine.backgroundColor = [UIColor redColor];
    [self addSubview:scannerRedLine];
    [self startAnimations];
    
}

BOOL alreadyInMethod;
BOOL isAnimationStarted;
- (void) startAnimation {
    
    if(alreadyInMethod) {
        return;
    }
    alreadyInMethod = YES;
    
    if(!isAnimationStarted) {
        alreadyInMethod = NO;
        return;
    }
    [scannerRedLine setAlpha:0.2f];
    [UIView animateWithDuration:0.2f animations:^{
        [scannerRedLine setAlpha:1.0f];
    } completion:^(BOOL finished) {
        if(!isAnimationStarted) {
            alreadyInMethod = NO;
            return;
        }
        [UIView animateWithDuration:0.2f animations:^{
            [scannerRedLine setAlpha:0.2f];
        } completion:^(BOOL finished) {
            alreadyInMethod = NO;
            [self startAnimation];
        }];
    }];
    
}

- (void) stopAnimations {
    isAnimationStarted = NO;
}

- (void) startAnimations {
    isAnimationStarted = YES;
    [self startAnimation];
}

@end
