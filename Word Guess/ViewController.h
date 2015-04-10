//
//  ViewController.h
//  Word Guess
//
//  Created by Jithin Jose on 2015-03-14.
//  Copyright (c) 2015 jithz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *IBword;
@property (strong, nonatomic) NSString *word;
@property (nonatomic, assign) NSInteger wordLength;
@property (strong, nonatomic) NSString *guessedWord;
@property (nonatomic, assign) NSInteger res;
@property (nonatomic, assign) NSInteger userScore;
@property (nonatomic, assign) NSInteger availHintNo;
@property (nonatomic, assign) NSInteger lifeNo;
@property (nonatomic, assign) NSInteger randNo;
@property (nonatomic, assign) NSInteger winCount;
@property (nonatomic, assign) NSInteger state;
@property (weak, nonatomic) IBOutlet UILabel *life;
@property (weak, nonatomic) IBOutlet UILabel *hint;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *availHint;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, retain) NSMutableArray *numbers;
-(int)check: (char)letter;
-(int)result;
-(void)disableEffects;

@property (weak, nonatomic) IBOutlet UIButton *a;
@property (weak, nonatomic) IBOutlet UIButton *b;
@property (weak, nonatomic) IBOutlet UIButton *c;
@property (weak, nonatomic) IBOutlet UIButton *d;
@property (weak, nonatomic) IBOutlet UIButton *e;
@property (weak, nonatomic) IBOutlet UIButton *f;
@property (weak, nonatomic) IBOutlet UIButton *g;
@property (weak, nonatomic) IBOutlet UIButton *h;
@property (weak, nonatomic) IBOutlet UIButton *i;
@property (weak, nonatomic) IBOutlet UIButton *j;
@property (weak, nonatomic) IBOutlet UIButton *k;
@property (weak, nonatomic) IBOutlet UIButton *l;
@property (weak, nonatomic) IBOutlet UIButton *m;
@property (weak, nonatomic) IBOutlet UIButton *n;
@property (weak, nonatomic) IBOutlet UIButton *o;
@property (weak, nonatomic) IBOutlet UIButton *p;
@property (weak, nonatomic) IBOutlet UIButton *q;
@property (weak, nonatomic) IBOutlet UIButton *r;
@property (weak, nonatomic) IBOutlet UIButton *s;
@property (weak, nonatomic) IBOutlet UIButton *t;
@property (weak, nonatomic) IBOutlet UIButton *u;
@property (weak, nonatomic) IBOutlet UIButton *v;
@property (weak, nonatomic) IBOutlet UIButton *w;
@property (weak, nonatomic) IBOutlet UIButton *x;
@property (weak, nonatomic) IBOutlet UIButton *y;
@property (weak, nonatomic) IBOutlet UIButton *z;

@property (weak, nonatomic) IBOutlet UIButton *hi;



@end

