//
//  HomeViewController.m
//  QRPay
//
//  Created by Marius Tanasoiu on 10/12/18.
//  Copyright © 2018 PayRO. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomTabBar1.h"
#import "MTBBarcodeScanner.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet CustomTabBar1 *tabBar;
@property (weak, nonatomic) IBOutlet UIView *scanningView;
@property (weak, nonatomic) IBOutlet UIView *controlsView;
@property (weak, nonatomic) IBOutlet UIImageView *welcomeImage;
@property (weak, nonatomic) IBOutlet UIImageView *placeQRImage;

@property (nonatomic, strong) MTBBarcodeScanner *scanner;
@property (nonatomic, strong) NSMutableArray *uniqueCodes;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar.homeButton addTarget:self action:@selector(clickHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar.walletButton addTarget:self action:@selector(clickWallet:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar.messagesButton addTarget:self action:@selector(clickMessages:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar.historyButton addTarget:self action:@selector(clickHistory:) forControlEvents:UIControlEventTouchUpInside];
    

    [self.startScanButton setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickStartScan:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.startScanButton addGestureRecognizer:singleTap];

//    [self.scanningView setHidden:YES];

}

- (void) viewDidAppear:(BOOL)animated {
    self.tabBar.walletButton.alpha = 0.6;
    self.tabBar.messagesButton.alpha = 0.6;
    self.tabBar.historyButton.alpha = 0.6;
    
    [self.scanningView setHidden:YES];
    [self.controlsView setHidden:NO];
    [self.placeQRImage setHidden:YES];
    
}

- (IBAction)clickStartScan:(id)sender {

    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            [self.scanningView setHidden:NO];
            [self.controlsView setHidden:YES];
            [self.placeQRImage setHidden:NO];
            [self.view bringSubviewToFront:self.welcomeImage];
            [self.view bringSubviewToFront:self.placeQRImage];
            [self startScanning];
        } else {
            [self displayPermissionMissingAlert];
        }
    }];

}

- (IBAction)clickHome:(id)sender {
    //nothing
}

- (IBAction)clickWallet:(id)sender {
    [self.tabBarController setSelectedIndex:1];
}

- (IBAction)clickMessages:(id)sender {
    [self.tabBarController setSelectedIndex:2];
}

- (IBAction)clickHistory:(id)sender {
    [self.tabBarController setSelectedIndex:3];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.scanner stopScanning];
    [super viewWillDisappear:animated];
}

- (MTBBarcodeScanner *)scanner {
    if (!_scanner) {
        _scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:self.scanningView];
    }
    return _scanner;
}

#pragma mark - Scanning

- (void)startScanning {
    self.uniqueCodes = [[NSMutableArray alloc] init];
    
    NSError *error = nil;
    [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
        for (AVMetadataMachineReadableCodeObject *code in codes) {
            if (code.stringValue && [self.uniqueCodes indexOfObject:code.stringValue] == NSNotFound) {
                [self.uniqueCodes addObject:code.stringValue];
                
                NSLog(@"Found unique code: %@", code.stringValue);

                [self sendDataToServer:code.stringValue];

            }
        }
    } error:&error];
    
    if (error) {
        NSLog(@"An error occurred: %@", error.localizedDescription);
    }
    
    //    [self.toggleScanningButton setTitle:@"Stop Scanning" forState:UIControlStateNormal];
    //    self.toggleScanningButton.backgroundColor = [UIColor redColor];
}

- (void) sendDataToServer:(NSString *) json {
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@"http://89.38.131.30:8082/QRResult"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *requestData = [NSData dataWithBytes:[json UTF8String] length:[json length]];
    [request setHTTPBody: requestData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
    }];
    
    [postDataTask resume];
}

- (void)stopScanning {
    [self.scanningView setHidden:YES];
    [self.controlsView setHidden:NO];
    [self.placeQRImage setHidden:YES];
    [self.scanner stopScanning];
    
    //    [self.toggleScanningButton setTitle:@"Start Scanning" forState:UIControlStateNormal];
    //    self.toggleScanningButton.backgroundColor = self.view.tintColor;
    
    //    self.captureIsFrozen = NO;
}

- (void)displayPermissionMissingAlert {
    NSString *message = nil;
    if ([MTBBarcodeScanner scanningIsProhibited]) {
        message = @"This app does not have permission to use the camera.";
    } else if (![MTBBarcodeScanner cameraIsPresent]) {
        message = @"This device does not have a camera.";
    } else {
        message = @"An unknown error occurred.";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Scanning Unavailable" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
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
