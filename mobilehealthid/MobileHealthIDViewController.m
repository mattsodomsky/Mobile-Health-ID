//
//  MobileHealthIDViewController.m
//  mobilehealthid
//
//  Created by Matt Sodomsky on 2014-11-15.
//  Copyright (c) 2014 Matt Sodomsky. All rights reserved.
//

#import "MobileHealthIDViewController.h"

@interface MobileHealthIDViewController ()

@end

@implementation MobileHealthIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.949f green:0.945f blue:0.914f alpha:1.00f];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.929f green:0.110f blue:0.141f alpha:1.00f];
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo.png"]];
    [self.navigationItem setTitleView:titleView];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
