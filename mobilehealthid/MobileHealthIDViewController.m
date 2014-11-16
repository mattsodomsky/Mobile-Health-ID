//
//  MobileHealthIDViewController.m
//  mobilehealthid
//
//  Created by Matt Sodomsky on 2014-11-15.
//  Copyright (c) 2014 Matt Sodomsky. All rights reserved.
//

#import "MobileHealthIDViewController.h"
#import "Patient.h"
#import "EmergencyContact.h"
#import "Condition.h"
#import "Allergy.h"

@interface MobileHealthIDViewController ()
@property (weak, nonatomic) IBOutlet UILabel *allergy;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation MobileHealthIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.949f green:0.945f blue:0.914f alpha:1.00f];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.929f green:0.110f blue:0.141f alpha:1.00f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo.png"]];
    [self.navigationItem setTitleView:titleView];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.firstName.text = self.patient.firstName;
    self.lastName.text = self.patient.lastName;
    self.birthDate.text = self.patient.birthDate;
    self.age.text = self.patient.age;
    self.bloodType.text = self.patient.bloodType;
    
    self.medicalCondition.text = ((Condition *) [self.patient.medicalConditions objectAtIndex:0]).name;
    
    self.implant.text = ((Condition *) [self.patient.implants objectAtIndex:0]).name;
    
    self.allergy.text = ((Allergy *) [self.patient.generalAllergies objectAtIndex:0]).allergyName;
    
//    self.contactName.text = ((EmergencyContact *)[self.patient.emergencyContacts objectAtIndex:0]).contactName;
    
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrollView.contentSize = CGSizeMake(375, 720);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
