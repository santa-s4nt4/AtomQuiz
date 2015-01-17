//
//  secondQuizViewController.m
//  Atom Quiz
//
//  Created by santa naruse on 2014/12/06.
//  Copyright (c) 2014年 santa naruse. All rights reserved.
//

#import "secondQuizViewController.h"

#import "secondLastViewController.h"

@interface secondQuizViewController ()

@end

@implementation secondQuizViewController
{
    //問題（Quizクラスのインスタンス）を格納する配列
    NSMutableArray *problemSet;
    
    //出題する問題数
    int totalProblems;
    //現在の進捗（出題済み問題数）を記録
    int currentProblem;
    //正答数
    int correctAnswers;
    
    //問題文を表示するText View
    IBOutlet UITextView *problemText;
    
    // 選択肢を表示するLabel
    IBOutlet UILabel *lbChoise1;
    IBOutlet UILabel *lbChoise2;
    IBOutlet UILabel *lbChoise3;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [problemText setEditable:NO];
    [problemText setSelectable:NO];
    problemText.font = [UIFont fontWithName:@"AdobeMingStd-Light" size:40];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; //ステータスバーを白色にする
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"seikai" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.seikai_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    
    NSString *fuseikai = [[NSBundle mainBundle] pathForResource:@"fuseikai" ofType:@"mp3"];
    NSURL *sound = [NSURL fileURLWithPath:fuseikai];
    self.fuseikai_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:sound error:NULL];
    
    // 問題を格納する可変配列のproblemSetを初期化
    problemSet = [[NSMutableArray alloc] init];
    
    
    // 例　[self addProblem:@"1月1日は何の日？" c1:@"クリスマス" c2:@"元旦" c3:@"大晦日" ans:2];
    // ======================     ここから下に命令を追加してください。   ==================
    [self addProblem:@"水" c1:@"H2O" c2:@"HO" c3:@"HO2" ans:1];
    [self addProblem:@"アンモニア" c1:@"N3H" c2:@"NH3" c3:@"NH2" ans:2];
    [self addProblem:@"塩化ナトリウム(食塩)" c1:@"NaCl" c2:@"NAcl" c3:@"ClNa" ans:1];
    [self addProblem:@"水素" c1:@"O2" c2:@"H2" c3:@"N2" ans:2];
    [self addProblem:@"二酸化炭素" c1:@"CO2" c2:@"CO3" c3:@"CO" ans:1];
    [self addProblem:@"エタノール" c1:@"I" c2:@"CH5OH" c3:@"C2H5OH" ans:3];
    [self addProblem:@"窒素" c1:@"O2" c2:@"N2" c3:@"N" ans:2];
    [self addProblem:@"炭素" c1:@"N2" c2:@"C2" c3:@"C" ans:3];
    [self addProblem:@"塩化水素(塩酸)" c1:@"HCl" c2:@"H2Cl" c3:@"HCl2" ans:1];
    [self addProblem:@"塩化銅" c1:@"CuCl" c2:@"Cu2Cl" c3:@"CuCl2" ans:3];
    [self addProblem:@"酸化銀" c1:@"AgO" c2:@"Ag2O" c3:@"CuO2" ans:2];
    [self addProblem:@"酸化鉄" c1:@"Fe2O" c2:@"FeO2" c3:@"FeO" ans:3];
    [self addProblem:@"酸化銅" c1:@"CuO" c2:@"CuO2" c3:@"Ag2O" ans:1];
    [self addProblem:@"酸化マグネシウム" c1:@"MgS" c2:@"MgO" c3:@"MgO2" ans:2];
    [self addProblem:@"硫化鉄" c1:@"Fe2O" c2:@"FeO" c3:@"FeS" ans:3];
    [self addProblem:@"塩化銅" c1:@"CuCl" c2:@"CuCl2" c3:@"CuO" ans:1];
    [self addProblem:@"炭酸水素ナトリウム" c1:@"NaCO3" c2:@"NaHCO3" c3:@"Na2CO3" ans:2];
    [self addProblem:@"硫化銅" c1:@"CuCl" c2:@"CuO" c3:@"CuS" ans:3];
    [self addProblem:@"炭酸ナトリウム" c1:@"Na2CO3" c2:@"NaHCO3" c3:@"NaCO3" ans:1];
    
    //クイズ問題をランダムに並び替え（シャッフル）
    // シャッフルする場合はコメント解除('//'を先頭から削除)してください
    [self shuffleProblemSet];
    
    
    
    
    //現在の問題番号と正答数を0にする
    currentProblem = 0;
    correctAnswers = 0;
    
    //　problemSetの最初の要素の問題文をクイズ画面にセット
    if(totalProblems > 0){
        problemText.text = [[problemSet objectAtIndex:currentProblem] getQ];
        lbChoise1.text = [[problemSet objectAtIndex:currentProblem] getChoice:1];
        lbChoise2.text = [[problemSet objectAtIndex:currentProblem] getChoice:2];
        lbChoise3.text = [[problemSet objectAtIndex:currentProblem] getChoice:3];
    }
}

- (void)addProblem : (NSString *)q c1:(NSString *)c1 c2:(NSString *)c2 c3:(NSString *)c3 ans:(int)a{
    
    // 新しくProblemクラスのインスタンスを生成・初期化し、問題文と答えを格納
    secondProblem *p = [secondProblem initProblem];
    [p setData:q c1:c1 c2:c2 c3:c3 ansNo:a];
    
    // 提示問題数をカウントアップ
    totalProblems++;
    
    // 新たに生成したProblemクラスのインスタンスをproblemSetに追加
    [problemSet addObject:p];
    
}

//問題文をシャッフル
- (void)shuffleProblemSet {
    
    //problemSetに格納された全問題の数を取得
    int totalQuestions = [problemSet count];
    
    //Fisher-Yatesアルゴリズム用のカウンターを取得
    int i = totalQuestions;
    
    //Fisher-Yatesアルゴリズムによって配列の要素をシャッフル
    while (i > 0) {
        
        //乱数を発生
        srand((unsigned int)time(0));
        int j = rand() % i;
        
        //要素を並び替え
        [problemSet exchangeObjectAtIndex:(i-1) withObjectAtIndex:j];
        
        //カウンターを減少させる
        i = i - 1;
    }
    
}

// 選択肢1のボタンが押された時
- (IBAction)answerIsChoise1{
    // 答えが合っているか（答えが選択肢1か）チェック
    if ([[problemSet objectAtIndex:currentProblem] getA] == 1) {
        //　正解数のカウントを増やす
        correctAnswers++;
        [self.seikai_sound play];
        //[NSThread sleepForTimeInterval:2.04f]; //2.04秒待ってから動く動作
    }else{
        [self.fuseikai_sound play];
    }
    
    // 次の問題へ
    [self nextProblem];
}

// 選択肢2のボタンが押された時
- (IBAction)answerIsChoise2{
    // 答えが合っているか（答えが選択肢2か）チェック
    if ([[problemSet objectAtIndex:currentProblem] getA] == 2) {
        //　正解数のカウントを増やす
        correctAnswers++;
        [self.seikai_sound play];
        //[NSThread sleepForTimeInterval:2.04f]; //2.04秒待ってから動く動作
    }else{
        [self.fuseikai_sound play];
    }
    
    // 次の問題へ
    [self nextProblem];
}

// 選択肢3のボタンが押された時
- (IBAction)answerIsChoise3{
    // 答えが合っているか（答えが選択肢3か）チェック
    if ([[problemSet objectAtIndex:currentProblem] getA] == 3) {
        //　正解数のカウントを増やす
        correctAnswers++;
        [self.seikai_sound play];
        //[NSThread sleepForTimeInterval:2.04f]; //2.04秒待ってから動く動作
    }else{
        [self.fuseikai_sound play];
    }
    
    // 次の問題へ
    [self nextProblem];
}


//次の問題提示 or 全問時終わっていたら結果表画面へ
- (void)nextProblem {
    
    //currentProblemを繰り上げ
    currentProblem++;
    
    //これまで出題した問題が、提示問題数に達していない場合
    if (currentProblem < totalProblems) {
        
        //次の問題の問題文を表示
        problemText.text = [[problemSet objectAtIndex:currentProblem] getQ];
        lbChoise1.text = [[problemSet objectAtIndex:currentProblem] getChoice:1];
        lbChoise2.text = [[problemSet objectAtIndex:currentProblem] getChoice:2];
        lbChoise3.text = [[problemSet objectAtIndex:currentProblem] getChoice:3];
        //全問題解き終わった場合
    } else {
        
        //結果表示画面へのSegueを始動
        [self performSegueWithIdentifier:@"tosecondLastView" sender:self];
    }
}

//結果表示画面へのSegueの発動
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //正答率を算出
    int percentage = (correctAnswers * 100 / totalProblems) ;
    
    //secondLastViewController（RVC）のインスタンスを作成し、//
    //RVCクラスのメンバー変数である「correctPercentage」に値を渡す
    //NSLog(@":%@",[segue identifier] );
    if ([[segue identifier] isEqualToString:@"tosecondLastView"]) {
        secondLastViewController *rvc = (secondLastViewController*)[segue destinationViewController];
        rvc.correctPercentage = percentage;
    }
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

-(IBAction)home
{
    [self.navigationController popToRootViewControllerAnimated:YES]; //ルートまで一気に戻る
}

@end
