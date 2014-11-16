//
//  MobileHealthIDViewController.h
//  mobilehealthid
//
//  Created by Matt Sodomsky on 2014-11-15.
//  Copyright (c) 2014 Matt Sodomsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MobileHealthIDViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UILabel *birthDate;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *bloodType;
@property (weak, nonatomic) IBOutlet UILabel *medicalCondition;
@property (weak, nonatomic) IBOutlet UILabel *implant;
@property (weak, nonatomic) IBOutlet UILabel *contactName;

@end
