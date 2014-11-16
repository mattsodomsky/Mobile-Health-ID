//
//  HomeScreenViewController.m
//  mobilehealthid
//
//  Created by Matt Sodomsky on 2014-11-15.
//  Copyright (c) 2014 Matt Sodomsky. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "RSScannerViewController.h"
#import <Parse/Parse.h>

@interface HomeScreenViewController ()
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

- (IBAction)scanButtonPressed:(id)sender;
- (IBAction)signoutButtonPressed:(id)sender;

@end

@implementation HomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    self.backgroundView.image = [UIImage imageNamed:@"background667.png"];
    [self.navigationController setNavigationBarHidden:YES];

}


- (IBAction)scanButtonPressed:(id)sender {
    RSScannerViewController *scanner = [[RSScannerViewController alloc] initWithCornerView:YES
                                                                               controlView:NO
                                                                           barcodesHandler:^(NSArray *barcodeObjects) {
                                                                               if (barcodeObjects.count > 0) {
                                                                                   [barcodeObjects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                                                           AVMetadataMachineReadableCodeObject *code = obj;
//                                                                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Barcode found"
//                                                                                                                                           message:code.stringValue
//                                                                                                                                          delegate:self
//                                                                                                                                 cancelButtonTitle:@"OK"
//                                                                                                                                 otherButtonTitles:nil];
                                                                                           //[scanner.navigationController popViewControllerAnimated:YES];
//                                                                                           dispatch_async(dispatch_get_main_queue(), ^{
//                                                                                               [scanner dismissViewControllerAnimated:true completion:nil];
//                                                                                               [alert show];
//                                                                                           });
                                                                                       });
                                                                                       [scanner dismissViewControllerAnimated:true completion:nil];

                                                                                   }];
                                                                               }
                                                                           }
                                                                   preferredCameraPosition:AVCaptureDevicePositionBack];
    [scanner setIsButtonBordersVisible:YES];
    [scanner setStopOnFirst:YES];
    
    
    [self presentViewController:scanner animated:true completion:nil];
}

- (IBAction)signoutButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:false];
}
@end
