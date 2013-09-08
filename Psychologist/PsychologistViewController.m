//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by he yiyu on 13-9-8.
//  Copyright (c) 2013年 he yiyu. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@interface PsychologistViewController()
@property (nonatomic) int diagnosis;
@end

@implementation PsychologistViewController

@synthesize diagnosis = _diagnosis;

- (void) setAndShowDiagnosis:(int) diagnosis
{
    self.diagnosis = diagnosis;
    [self performSegueWithIdentifier:@"ShowDiagonsis" sender:self];
}

- (IBAction)flying {
    [self setAndShowDiagnosis:60];
}
- (IBAction)apple {
    [self setAndShowDiagnosis:100];
}
- (IBAction)dragons {
    [self setAndShowDiagnosis:20];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"ShowDiagonsis"])
    {
        [segue.destinationViewController setHappiness:self.diagnosis];
    } else if ([segue.identifier isEqualToString:@"celebrity"]) {
        [segue.destinationViewController setHappiness:60];
    } else if ([segue.identifier isEqualToString:@"problem"]) {
        [segue.destinationViewController setHappiness:20];
    } else if ([segue.identifier isEqualToString:@"tv"]) {
        [segue.destinationViewController setHappiness:100];
    }
}

@end
