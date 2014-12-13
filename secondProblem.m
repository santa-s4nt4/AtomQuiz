//
//  secondProblem.m
//  Atom Quiz
//
//  Created by santa naruse on 2014/12/06.
//  Copyright (c) 2014年 santa naruse. All rights reserved.
//

#import "secondProblem.h"

@implementation secondProblem
{
    //問題文
    NSString *question;
    NSString *choise1;
    NSString *choise2;
    NSString *choise3;
    
    //答え（「○」なら「0」、「☓」なら「1」）
    int answerNo;
}

//問題文と選択肢と答えを格納
- (void)setData:(NSString *)q c1:(NSString *)c1 c2:(NSString *)c2 c3:(NSString *)c3 ansNo:(int)a{
    question = q;
    choise1 = c1;
    choise2 = c2;
    choise3 = c3;
    
    answerNo = a;
}

//問題文を読み出し
- (NSString *)getQ {
    return question;
}

- (NSString *)getChoice : (int)n{
    
    NSString *ss;
    
    switch (n) {
        case 1:
            ss = choise1;
            break;
        case 2:
            ss = choise2;
            break;
        case 3:
            ss = choise3;
            break;
        default:
            ss = nil;
            break;
    }
    return ss;
}

//答えを読み出し
- (int)getA {
    return answerNo;
}

//初期化処理
+ (id)initProblem {
    return [[self alloc] init];
}

@end
