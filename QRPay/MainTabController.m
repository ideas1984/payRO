//
//  MainTabControllerViewController.m
//  QRPay
//
//  Created by Marius Tanasoiu on 10/11/18.
//  Copyright © 2018 PayRO. All rights reserved.
//

#import "MainTabController.h"

@interface MainTabController ()

@end

@implementation MainTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"background_menu_crop"]];
//    [UITabBar appearance].layer.borderWidth = 0.0f;
//    [UITabBar appearance].clipsToBounds = true;

    
//    [[UITabBar appearance] setBarTintColor:[UIColor clearColor]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"transparent"]];
//    [[UITabBar appearance] setBackgroundColor:[UIColor clearColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"transparent"]];
//    [[UITabBar appearance] setShadowImage:[UIImage new]];
    
//    UIImageView *dot =[[UIImageView alloc] initWithFrame:self.tabBar.frame];
//    [dot setContentMode:UIViewContentModeScaleToFill];
//    dot.image = [UIImage imageNamed:@"background_menu_crop"];
//    [self.view addSubview:dot];
//    [self.view sendSubviewToBack:dot];
    
    UITabBarItem *item = [self.tabBar.items objectAtIndex:0];
//    item.contentMode = UIViewContentModeScaleAspectFill;
    item.image = [UIImage imageNamed:@"white-semi-circle"];
    item.selectedImage = [UIImage imageNamed:@"white-semi-circle"];
    
    
    UIView *v = [[UIView alloc] init];
    v.contentMode = UIViewContentModeScaleAspectFill;
    
    [self makeTabBarHidden:YES];
    
}

- (void)makeTabBarHidden:(BOOL)hide {
    if ( [self.view.subviews count] < 2 )
        return;
    UIView *contentView;
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    if (hide) {
        contentView.frame = self.view.bounds;
    } else {
        contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                       self.view.bounds.origin.y,
                                       self.view.bounds.size.width,
                                       self.view.bounds.size.height - self.tabBar.frame.size.height);
    }
    self.tabBar.hidden = hide;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

const CGFloat kBarHeight = 80;

- (void)viewWillLayoutSubviews {
//
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = kBarHeight;
    tabFrame.origin.y = self.view.frame.size.height - kBarHeight;
    self.tabBar.frame = tabFrame;

    UIImageView *dot =[[UIImageView alloc] initWithFrame:self.tabBar.frame];
    [dot setContentMode:UIViewContentModeScaleToFill];
    dot.image = [UIImage imageNamed:@"background_menu_crop"];
    [self.view addSubview:dot];
    [self.view sendSubviewToBack:dot];
//
//
//
////    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"background_menu_crop"]];
////    [UITabBar appearance].layer.borderWidth = 0.0f;
////    [UITabBar appearance].clipsToBounds = true;
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
