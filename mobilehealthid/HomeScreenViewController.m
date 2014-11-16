//
//  HomeScreenViewController.m
//  mobilehealthid
//
//  Created by Matt Sodomsky on 2014-11-15.
//  Copyright (c) 2014 Matt Sodomsky. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "ScanViewController.h"

@interface HomeScreenViewController ()
@property ScanViewController *scanVC;
- (IBAction)scanButtonPressed:(id)sender;
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


- (IBAction)scanButtonPressed:(id)sender {
    if (!self.scanVC) {
        self.scanVC = [[ScanViewController alloc]initWithNibName:@"ScanViewController" bundle:nil];
    }
    
    [self.navigationController pushViewController:self.scanVC animated:true];
}
@end
