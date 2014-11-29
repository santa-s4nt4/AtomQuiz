//
//  QuizViewController.h
//  Atom Quiz
//
//  Created by santa naruse on 2014/10/25.
//  Copyright (c) 2014年 santa naruse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LastViewController.h"
#import "Problem.h"

@interface QuizViewController : UIViewController

- (void)shuffleProblemSet;
- (void)nextProblem;

- (void)addProblem : (NSString *)q c1:(NSString *)c1 c2:(NSString *)c2 c3:(NSString *)c3 ans:(int)a;

-(IBAction)home;

@end
