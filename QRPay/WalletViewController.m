//
//  WalletViewController.m
//  QRPay
//
//  Created by Marius Tanasoiu on 10/17/18.
//  Copyright © 2018 PayRO. All rights reserved.
//

#import "WalletViewController.h"
#import "CustomTabBar1.h"

@interface WalletViewController ()

@property (weak, nonatomic) IBOutlet CustomTabBar1 *tabBar;

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar.homeButton addTarget:self action:@selector(clickHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar.walletButton addTarget:self action:@selector(clickWallet:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar.messagesButton addTarget:self action:@selector(clickMessages:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar.historyButton addTarget:self action:@selector(clickHistory:) forControlEvents:UIControlEventTouchUpInside];

}

- (void) viewDidAppear:(BOOL)animated {
    self.tabBar.walletButton.alpha = 1;
}

- (IBAction)clickHome:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)clickWallet:(id)sender {
    //nothing here
}

- (IBAction)clickMessages:(id)sender {
    [self.tabBarController setSelectedIndex:2];
}

- (IBAction)clickHistory:(id)sender {
    [self.tabBarController setSelectedIndex:3];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
