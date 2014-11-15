//
//  ScanViewController.m
//  mobilehealthid
//
//  Created by Matt Sodomsky on 2014-11-15.
//  Copyright (c) 2014 Matt Sodomsky. All rights reserved.
//

#import "ScanViewController.h"
#import "RSScannerViewController.h"
#import <Parse/Parse.h>

@interface ScanViewController ()

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)viewDidAppear:(BOOL)animated {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
    [query whereKey:@"ExternalIDValue" equalTo:@"45dfe4thdfhw4drg"];
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
    
    RSScannerViewController *scanner = [[RSScannerViewController alloc] initWithCornerView:YES
                                                                               controlView:NO
                                                                           barcodesHandler:^(NSArray *barcodeObjects) {
                                                                               if (barcodeObjects.count > 0) {
                                                                                   [barcodeObjects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                                                           AVMetadataMachineReadableCodeObject *code = obj;
                                                                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Barcode found"
                                                                                                                                           message:code.stringValue
                                                                                                                                          delegate:self
                                                                                                                                 cancelButtonTitle:@"OK"
                                                                                                                                 otherButtonTitles:nil];
                                                                                           //[scanner dismissViewControllerAnimated:true completion:nil];
                                                                                           //[scanner.navigationController popViewControllerAnimated:YES];
                                                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                                                               [scanner dismissViewControllerAnimated:true completion:nil];
                                                                                               [alert show];
                                                                                           });
                                                                                       });
                                                                                   }];
                                                                               }
                                                                           }
                                                                   preferredCameraPosition:AVCaptureDevicePositionBack];
    [scanner setStopOnFirst:YES];
    [self presentViewController:scanner animated:true completion:nil];
}

@end
