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
#import "Patient.h"
#import "Allergy.h"
#import "Doctor.h"
#import "EmergencyContact.h"
#import "Condition.h"

@interface HomeScreenViewController ()
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property MobileHealthIDViewController *idVC;
@property (strong) Patient *patient;
@property UIAlertView *alert;

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
    
    if(!self.patient) {
        self.patient = [[Patient alloc]init];
    }

    NSString *codeString = cardInfo.stringValue;
    
    NSRange startRange = [codeString rangeOfString:@"DAQ"];
    NSInteger startIndex = startRange.location + 3;
    
    NSRange idCodeRange = NSMakeRange(startIndex, 15);

    PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
    [query whereKey:@"ExternalIDValue" equalTo:[codeString substringWithRange:idCodeRange]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if ([objects count] < 1) {
                
                if (!self.alert) {
                    self.alert = [[UIAlertView alloc] initWithTitle:@"No Mobile Health Record" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                }
                
                if (!self.alert.visible) {
                    [self.alert show];

                }
                
            } else {
                
            // Do something with the found objects
            for (PFObject *object in objects) {
                
                self.patient.firstName = object[@"Name_First"];
                self.patient.middleName = object[@"Name_Middle"];
                self.patient.lastName = object[@"Name_Last"];
                
                self.patient.sex = object[@"Sex"];
                NSString *birthDate = object[@"DateOfBirth"];
                NSRange range = NSMakeRange(0, 10);
                self.patient.birthDate = [birthDate substringWithRange:range];
                
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyyy-MM-dd"];
                NSDate *birthday = [df dateFromString: birthDate];
                NSDate* now = [NSDate date];
                NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                                   components:NSCalendarUnitYear
                                                   fromDate:birthday
                                                   toDate:now
                                                   options:0];
                NSInteger age = [ageComponents year];
                
                self.patient.age   = @(age).stringValue;
                                
                self.patient.idNumber = object[@"ExternalIDValue"];
                
                self.patient.bloodType = object[@"BloodType"];
                

                for (PFObject *generalAllergy in object[@"GeneralAllergies"]) {
                    
                    Allergy *allergy = [[Allergy alloc] init];
                    allergy.allergyName = generalAllergy[@"Description"];
                    allergy.severity = generalAllergy[@"Severity"];
                    allergy.userSeverity = generalAllergy[@"UserSeverity"];
                    [self.patient.generalAllergies addObject:allergy];
                    
                }
                
                for (PFObject *implant in object[@"Implants"]) {
                    
                    Condition *currentImplant = [[Condition alloc]init];
                    currentImplant.name = implant[@"Description"];
                    currentImplant.severity = implant[@"Severity"];
                    [self.patient.implants addObject:currentImplant];
                    
                }
                
                for (PFObject *medicalAllergy in object[@"MedicalAllergies"]) {
                    
                    Allergy *allergy = [[Allergy alloc] init];
                    allergy.allergyName = medicalAllergy[@"Description"];
                    allergy.severity = medicalAllergy[@"Severity"];
                    allergy.userSeverity = medicalAllergy[@"UserSeverity"];
                    [self.patient.medicalAllergies addObject:allergy];
                    
                }
                
                
                for (PFObject *condition in object[@"MedicalConditions"]) {
                    
                    Condition *currentCondition = [[Condition alloc]init];
                    currentCondition.name = condition[@"Description"];
                    currentCondition.severity = condition[@"Severity"];
                    [self.patient.medicalConditions addObject:currentCondition];
                    
                }
                
                for (PFObject *contact in object[@"MyContacts"]) {
                    
                    EmergencyContact *currentContact = [[EmergencyContact alloc] init];
                    currentContact.contactName = contact[@"contactName"];
                    currentContact.contactNumber = contact[@"contactNumber"];
                    currentContact.contactRelation = contact[@"contactRelation"];
                    [self.patient.emergencyContacts addObject:currentContact];
                    
                }
                
                for (PFObject *doctor in object[@"Physician"]) {
                    
                    Doctor *currentDoctor = [[Doctor alloc]init];
                    currentDoctor.institution = doctor[@"Institution"];
                    currentDoctor.name = doctor[@"PhysicianName"];
                    currentDoctor.phoneNumber = doctor[@"PhysicianNumber"];
                    [self.patient.doctors addObject:currentDoctor];
                    
                }
                
                if (!self.idVC) {
                    self.idVC = [[MobileHealthIDViewController alloc] initWithNibName:@"MobileHealthIDViewController" bundle:nil];
                }
                
                self.idVC.patient = self.patient;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:true completion:nil];
                });
                
                if(![self.navigationController.topViewController isKindOfClass:[self.idVC class]]) {
                    [self.navigationController pushViewController:self.idVC animated:YES];
                }
                
            }
        }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)signoutButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:false];
}
@end
