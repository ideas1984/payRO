//
//  Header.m
//  QRPay
//
//  Created by Marius Tanasoiu on 10/18/18.
//  Copyright © 2018 PayRO. All rights reserved.
//

#import "Header.h"


@interface Header()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation Header

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
//    UIGraphicsBeginImageContext(self.frame.size);
//    [[UIImage imageNamed:@"tabbar_background"] drawInRect:self.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    self.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [[NSBundle mainBundle] loadNibNamed:@"Header" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
}
@end
