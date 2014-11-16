//
//  Patient.h
//  mobilehealthid
//
//  Created by Matt Sodomsky on 2014-11-16.
//  Copyright (c) 2014 Matt Sodomsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Patient : NSObject

@property NSString *firstName;
@property NSString *middleName;
@property NSString *lastName;
@property NSString *sex;
@property NSString *bloodType;
@property NSString *idNumber;

@property NSString *birthDate;
@property NSString *age;

@property NSMutableArray *generalAllergies;
@property NSMutableArray *implants;
@property NSMutableArray *medicalConditions;
@property NSMutableArray *medicalAllergies;
@property NSMutableArray *emergencyContacts;
@property NSMutableArray *doctors;


@end
