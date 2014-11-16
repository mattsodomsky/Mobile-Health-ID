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
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property ScanViewController *scanVC;
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
    [self.navigationController setNavigationBarHidden:YES];
    self.backgroundView.image = [UIImage imageNamed:@"background667.png"];
}


- (IBAction)scanButtonPressed:(id)sender {
    if (!self.scanVC) {
        self.scanVC = [[ScanViewController alloc]initWithNibName:@"ScanViewController" bundle:nil];
    }
    
    [self.navigationController pushViewController:self.scanVC animated:true];
}

- (IBAction)signoutButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
