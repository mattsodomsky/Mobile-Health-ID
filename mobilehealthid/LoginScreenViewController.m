//
//  LoginScreenViewController.m
//  mobilehealthid
//
//  Created by Matt Sodomsky on 2014-11-15.
//  Copyright (c) 2014 Matt Sodomsky. All rights reserved.
//

#import "LoginScreenViewController.h"
#import "HomeScreenViewController.h"

@interface LoginScreenViewController ()

@property HomeScreenViewController *homeVc;

- (IBAction)loginButtonClicked:(id)sender;
@end

@implementation LoginScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButtonClicked:(id)sender {
    
    if (!self.homeVc) {
        self.homeVc = [[HomeScreenViewController alloc] initWithNibName:@"HomeScreenViewController" bundle:nil];
    }
    
    [self.navigationController pushViewController:self.homeVc animated:true];
}
@end
