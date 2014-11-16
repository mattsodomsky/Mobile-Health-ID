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
#import "MobileHealthIDViewController.h"

@interface HomeScreenViewController ()
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property MobileHealthIDViewController *idVC;

- (IBAction)scanButtonPressed:(id)sender;
- (IBAction)signoutButtonPressed:(id)sender;
- (void)decodeCardAndPresentResults:(AVMetadataMachineReadableCodeObject*)cardInfo;

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
                                                                                           [self decodeCardAndPresentResults:code];
                                                                                       });
                                                                                       

                                                                                   }];
                                                                               }
                                                                           }
                                                                   preferredCameraPosition:AVCaptureDevicePositionBack];
    [scanner setIsButtonBordersVisible:YES];
    [scanner setStopOnFirst:YES];
    
    
    [self presentViewController:scanner animated:true completion:nil];
}

-(void)decodeCardAndPresentResults:(AVMetadataMachineReadableCodeObject *)cardInfo {
    
    NSLog(@"HERE");

    NSString *codeString = cardInfo.stringValue;
    
    NSRange startRange = [codeString rangeOfString:@"DAQ"];
    NSInteger startIndex = startRange.location + 3;
    
    NSRange idCodeRange = NSMakeRange(startIndex, 15);
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
    [query whereKey:@"ExternalIDValue" equalTo:[codeString substringWithRange:idCodeRange]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // Do something with the found objects
            for (PFObject *object in objects) {
                
                NSLog(@"%@", object[@"Name_First"]);
                NSLog(@"%@", object[@"Name_Middle"]);
                NSLog(@"%@", object[@"Name_Last"]);
                NSLog(@"%@", object[@"Sex"]);
                NSLog(@"%@", object[@"DateOfBirth"]);
                
                NSLog(@"%@", object[@"ExternalIDValue"]);
                NSLog(@"%@", object[@"BloodType"]);
                
                for (PFObject *generalAllergy in object[@"GeneralAllergies"]) {
                    NSLog(@"%@", generalAllergy[@"Description"]);
                    NSLog(@"%@", generalAllergy[@"Severity"]);
                    NSLog(@"%@", generalAllergy[@"UserSeverity"]);
                }
                
                for (PFObject *implant in object[@"Implants"]) {
                    NSLog(@"%@", implant[@"Description"]);
                    NSLog(@"%@", implant[@"Severity"]);
                    
                }
                
                for (PFObject *allergy in object[@"MedicalAllergies"]) {
                    NSLog(@"%@", allergy[@"Description"]);
                    NSLog(@"%@", allergy[@"Severity"]);
                    NSLog(@"%@", allergy[@"UserSeverity"]);
                }
                
                
                for (PFObject *condition in object[@"MedicalConditions"]) {
                    NSLog(@"%@", condition[@"Description"]);
                    NSLog(@"%@", condition[@"Severity"]);
                    
                }
                
                for (PFObject *contact in object[@"MyContacts"]) {
                    NSLog(@"%@", contact[@"contactName"]);
                    NSLog(@"%@", contact[@"contactNumber"]);
                    NSLog(@"%@", contact[@"contactRelation"]);
                }
                
                for (PFObject *doctor in object[@"Physician"]) {
                    NSLog(@"%@", doctor[@"Institution"]);
                    NSLog(@"%@", doctor[@"PhysicianName"]);
                    NSLog(@"%@", doctor[@"PhysicianNumber"]);
                }
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    if (!self.idVC) {
        self.idVC = [[MobileHealthIDViewController alloc] initWithNibName:@"MobileHealthIDViewController" bundle:nil];
    }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:true completion:nil];
        });
    
    [self.navigationController pushViewController:self.idVC animated:YES];
    
    
    
}

- (IBAction)signoutButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:false];
}
@end
