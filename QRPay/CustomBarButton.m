//
//  CustomBarButton.m
//  QRPay
//
//  Created by Marius Tanasoiu on 10/17/18.
//  Copyright © 2018 PayRO. All rights reserved.
//

#import "CustomBarButton.h"

@implementation CustomBarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    [self centerVertically];
    [self.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    self.alpha = 0.6;
}


- (void)centerVerticallyWithPadding:(float)padding {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGFloat totalHeight = (imageSize.height + titleSize.height + padding);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
                                            0.0f,
                                            0.0f,
                                            - titleSize.width);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            - imageSize.width,
                                            - (totalHeight - titleSize.height),
                                            0.0f);
    
    self.contentEdgeInsets = UIEdgeInsetsMake(25.0f,
                                              0.0f,
                                              titleSize.height,
                                              0.0f);
}

- (void)centerVertically {
    const CGFloat kDefaultPadding = 0.0f;
    [self centerVerticallyWithPadding:kDefaultPadding];
}

@end
