//
//  secondProblem.h
//  Atom Quiz
//
//  Created by santa naruse on 2014/12/06.
//  Copyright (c) 2014年 santa naruse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface secondProblem : NSObject
+ (id)initProblem;
- (void)setData:(NSString *)q
             c1:(NSString *)c1
             c2:(NSString *)c2
             c3:(NSString *)c3
          ansNo:(int)a;
- (NSString *)getQ;
- (NSString *)getChoice : (int)n;
- (int)getA;

@end
