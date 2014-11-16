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
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)loginButtonClicked:(id)sender;
@end

@implementation LoginScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButtonClicked:(id)sender {
    
    if (!self.homeVc) {
        self.homeVc = [[HomeScreenViewController alloc] initWithNibName:@"HomeScreenViewController" bundle:nil];
    }
    
    [self.navigationController pushViewController:self.homeVc animated:false];
}

-(void)viewWillAppear:(BOOL)animated  {
    [self.navigationController setNavigationBarHidden:YES];

}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
