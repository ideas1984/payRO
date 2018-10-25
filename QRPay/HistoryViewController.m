//
//  HistoryViewController.m
//  QRPay
//
//  Created by Marius Tanasoiu on 10/12/18.
//  Copyright © 2018 PayRO. All rights reserved.
//

#import "HistoryViewController.h"
#import "CustomTabBar.h"

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet CustomTabBar *tabBar;


@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar.homeButton addTarget:self action:@selector(clickHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar.walletButton addTarget:self action:@selector(clickWallet:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar.messagesButton addTarget:self action:@selector(clickMessages:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar.historyButton addTarget:self action:@selector(clickHistory:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) viewDidAppear:(BOOL)animated {
    self.tabBar.homeButton.alpha = 0.6;
    self.tabBar.walletButton.alpha = 0.6;
    self.tabBar.messagesButton.alpha = 0.6;
}


- (IBAction)clickHome:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)clickWallet:(id)sender {
    [self.tabBarController setSelectedIndex:1];
}

- (IBAction)clickMessages:(id)sender {
    [self.tabBarController setSelectedIndex:2];
}

- (IBAction)clickHistory:(id)sender {
    //nothing here
}

@end
