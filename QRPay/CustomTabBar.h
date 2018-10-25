//
//  CustomTabBar1.h
//  QRPay
//
//  Created by Marius Tanasoiu on 10/17/18.
//  Copyright © 2018 PayRO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBarButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomTabBar : UIView
@property (weak, nonatomic) IBOutlet CustomBarButton *homeButton;
@property (weak, nonatomic) IBOutlet CustomBarButton *walletButton;
@property (weak, nonatomic) IBOutlet CustomBarButton *messagesButton;
@property (weak, nonatomic) IBOutlet CustomBarButton *historyButton;

@end

NS_ASSUME_NONNULL_END
