//
//  QuizViewController.m
//  Atom Quiz
//
//  Created by santa naruse on 2014/10/25.
//  Copyright (c) 2014年 santa naruse. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@end

@implementation QuizViewController
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
    // ======================     ここから下に命令を追加   ==================
    //[self addProblem:@"亜鉛" c1:@"Zn" c2:@"He" c3:@"Mg" ans:1];
    [self addProblem:@"アルゴン" c1:@"Ne" c2:@"Ar" c3:@"Al" ans:2];
    [self addProblem:@"窒素" c1:@"O" c2:@"P" c3:@"N" ans:3];
    [self addProblem:@"硫黄" c1:@"S" c2:@"Si" c3:@"Hg" ans:1];
    [self addProblem:@"水素" c1:@"He" c2:@"H" c3:@"Cu" ans:2];
    [self addProblem:@"ヘリウム" c1:@"He" c2:@"Au" c3:@"Ag" ans:1];
    [self addProblem:@"ホウ素" c1:@"I" c2:@"F" c3:@"B" ans:3];
    [self addProblem:@"ヨウ素" c1:@"F" c2:@"I" c3:@"B" ans:2];
    [self addProblem:@"フッ素" c1:@"B" c2:@"I" c3:@"F" ans:3];
    [self addProblem:@"塩素" c1:@"Cl" c2:@"Cu" c3:@"Ca" ans:1];
    [self addProblem:@"カリウム" c1:@"P" c2:@"Ca" c3:@"K" ans:3];
    [self addProblem:@"カルシウム" c1:@"K" c2:@"Ca" c3:@"Ne" ans:2];
    [self addProblem:@"ネオン" c1:@"S" c2:@"He" c3:@"Ne" ans:3];
    [self addProblem:@"炭素" c1:@"C" c2:@"Na" c3:@"Pb" ans:1];
    [self addProblem:@"鉛" c1:@"Hg" c2:@"Pb" c3:@"Li" ans:2];
    [self addProblem:@"スズ" c1:@"H" c2:@"S" c3:@"Sn" ans:3];
    [self addProblem:@"白金(プラチナ)" c1:@"Pt" c2:@"Pb" c3:@"Si" ans:1];
    [self addProblem:@"ケイ素" c1:@"Cu" c2:@"Si" c3:@"Ag" ans:2];
    [self addProblem:@"水銀" c1:@"H" c2:@"Ag" c3:@"Hg" ans:3];
    [self addProblem:@"リン" c1:@"P" c2:@"I" c3:@"H" ans:1];
    [self addProblem:@"金" c1:@"Ag" c2:@"Au" c3:@"Cu" ans:2];
    [self addProblem:@"ベリリウム" c1:@"Mg" c2:@"Li" c3:@"Be" ans:3];
    [self addProblem:@"マグネシウム" c1:@"Mg" c2:@"Al" c3:@"Fe" ans:1];
    [self addProblem:@"鉄" c1:@"Pt" c2:@"Fe" c3:@"Cu" ans:2];
    [self addProblem:@"バリウム" c1:@"Be" c2:@"B" c3:@"Ba" ans:3];
    [self addProblem:@"アルミニウム" c1:@"Al" c2:@"Au" c3:@"Ne" ans:1];
    [self addProblem:@"銀" c1:@"Cu" c2:@"Ag" c3:@"Hg" ans:2];
    [self addProblem:@"銅" c1:@"Ag" c2:@"Au" c3:@"Cu" ans:3];
    [self addProblem:@"リチウム" c1:@"Li" c2:@"Ne" c3:@"Ar" ans:1];
    [self addProblem:@"ナトリウム" c1:@"Ne" c2:@"Na" c3:@"N" ans:2];
    [self addProblem:@"酸素" c1:@"H" c2:@"C" c3:@"O" ans:3];
    
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

// 問題を追加する
- (void)addProblem : (NSString *)q c1:(NSString *)c1 c2:(NSString *)c2 c3:(NSString *)c3 ans:(int)a{
    
    // 新しくProblemクラスのインスタンスを生成・初期化し、問題文と答えを格納
    Problem *p = [Problem initProblem];
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
        [self performSegueWithIdentifier:@"toLastView" sender:self];
    }
}

//結果表示画面へのSegueの発動
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //正答率を算出
    int percentage = (correctAnswers * 100 / totalProblems) ;
    
    //LastViewController（RVC）のインスタンスを作成し、//
    //RVCクラスのメンバー変数である「correctPercentage」に値を渡す
    if ([[segue identifier] isEqualToString:@"toLastView"]) {
        LastViewController *rvc = (LastViewController*)[segue destinationViewController];
        rvc.correctPercentage = percentage;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
