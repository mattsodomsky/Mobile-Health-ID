//
//  Patient.m
//  mobilehealthid
//
//  Created by Matt Sodomsky on 2014-11-16.
//  Copyright (c) 2014 Matt Sodomsky. All rights reserved.
//

#import "Patient.h"

@implementation Patient

-(id)init {
    
    self = [super init];
    
    self.emergencyContacts = [[NSMutableArray alloc] init];
    self.generalAllergies = [[NSMutableArray alloc] init];
    self.implants = [[NSMutableArray alloc] init];
    self.medicalConditions = [[NSMutableArray alloc] init];
    self.medicalAllergies = [[NSMutableArray alloc] init];
    self.doctors = [[NSMutableArray alloc] init];
   
    return self;
}

@end
