//
//  ViewController.m
//  Word Guess
//
//  Created by Jithin Jose on 2015-03-14.
//  Copyright (c) 2015 jithz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSArray *words=nil;
NSArray *hints=nil;
+(void)initialize {
    words = @[@"POMEGRANATE", @"OTTAWA", @"PORSCHE", @"HAMLET", @"SAMSUNG", @"VOLKSWAGEN", @"TENNIS", @"FRANCE", @"MILAN", @"OKTOBERFEST", @"VENICE", @"HYATT", @"LAKME", @"PASTA", @"CIRCUMSTANCE", @"INTERPRETATION", @"APOLOGIZE", @"UNLIMITED", @"EMPHASIS", @"CONSENT", @"APPOINTMENT", @"TRADITIONAL", @"RECOGNITION", @"AMBIDEXTROUS", @"UTILIZE", @"FORTUNATE", @"TERMINATE", @"VIGOROUS", @"DEMONSTRATION", @"PROTAGONIST", @"RESPONSIBLE", @"SIMULTANEOUS", @"SINGAPORE", @"KAZAKHSTAN", @"AUSTIN", @"MANHATTAN", @"HONOLULU", @"AMSTERDAM", @"HOLLYWOOD", @"FINLAND", @"SALVADOR", @"GRENADA", @"MONTREAL", @"JOHANNESBURG", @"HIROSHIMA", @"BAHAMAS", @"PIAUI", @"IRELAND", @"LACROSSE", @"BRATISLAVA"];
    hints = @[@"fruit", @"capital of Canada", @"car manufacturer", @"tragedy written by William Shakespeare",
              @"mobile phone manufacturer", @"car manufacturer", @"french open", @"Country-center of culture in Europe", @"The moral capital of Italy", @"Festival held in Munich- Germany", @"The floating city", @"Luxury hotel chain", @"Famous Indian cosmetic brand", @"Italian food", @"A condition or case", @"An explanation", @"Acknowledge failings or faults", @"Having no restrictions", @"special importance or significance", @"Permission or approval", @"An agreement for a meeting", @"synonymous with conventional", @"attention or favourable notice", @"can work with both hands", @"to make practical or worthwhile use of", @"lucky", @"to bring to an end", @"robust", @"the act of showing", @"the leading character", @"answerable", @"concurrent", @"country-southeast Asian city-state", @"worlds largest landlocked country", @"live music capital of the world", @"Landmark-Time Square", @"Hawaiian city & birthplace of Barack Obama", @"capital of Netherlands", @"famous district in Los Angeles", @"home to Angry Birds", @"Brazil's capital of happiness", @"Island of spice", @"Canada's cultural capital", @"largest city in South Africa", @"destroyed in world war 2", @"Anation consisting of 29 islands", @"state- Brazil", @"country in United Kingdom", @"Canada- summer sport", @"capital of Slovakia"];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self disableEffects];
    self.lifeNo=7;
    self.availHintNo=10;
    self.userScore=0;
    self.winCount=0;
    self.hint.text=@"Hint:";
    self.life.text=@"X 7";
    self.score.text=@"0";
    self.availHint.text=@"10";
    self.resultLabel.text=@"";
    
    self.numbers = [[NSMutableArray alloc] init];
    self.randNo = arc4random_uniform(50);
    [self.numbers addObject:[NSString stringWithFormat:@"%ld",(long)self.randNo]];
    self.word=words[self.randNo];
    self.wordLength=[self.word length];
    int i;
    self.guessedWord=@"";
    for (i=0; i<self.wordLength; i++) {
        self.guessedWord=[NSString stringWithFormat:@"%@%@", self.guessedWord, @"*"];
    }
    self.IBword.text=self.guessedWord;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)check: (char) letter {
    int i;
    self.state=0;
    for (i=0; i<self.wordLength; i++) {
        if([self.word characterAtIndex:i] == letter)
        {
            self.guessedWord=[self.guessedWord stringByReplacingCharactersInRange:NSMakeRange(i,1) withString:[NSString stringWithFormat:@"%c", letter]];
            self.state=1;
            
        }
        
        
    }
    if(self.state!=1)
    {
        self.lifeNo=self.lifeNo-1;
        NSString* lno = [NSString stringWithFormat:@"%li", (long)self.lifeNo];
        self.life.text=[NSString stringWithFormat:@"%@%@", @"X ", lno];
    }
    self.IBword.text=self.guessedWord;
    int st=[self result];
    if(st==2)
    {
        self.state=2;
    }
    return (int)self.state;
}

-(int)result {
    if([self.word isEqualToString: self.guessedWord])
    {
       
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"CongratZz.." message:@"click OK to get the next word" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"", nil];
        [alert show];
        
        self.userScore=self.userScore+(self.lifeNo*10);
        self.score.text=[NSString stringWithFormat:@"%li", (long)self.userScore];
        self.winCount+=1;
        if((self.winCount%3)==0)
        {
            self.availHintNo+=1;
        }
        
        self.state=2;
        [self getWord];
    }
    else if (self.lifeNo<1)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Game Over" message:@"click OK to play again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"", nil];
        [alert show];
        [self viewDidLoad];
        self.state=2;
    }
    return (int)self.state;
}

-(void)getWord {
    
    
    self.randNo = arc4random_uniform(50);
    if ([self.numbers containsObject:[NSString stringWithFormat:@"%ld",(long)self.randNo]])
    {
        [self getWord];
    }
    else{
        [self.numbers addObject:[NSString stringWithFormat:@"%ld",(long)self.randNo]];
    }
    self.lifeNo=7;
    self.availHint.text=[NSString stringWithFormat:@"%li", (long)self.availHintNo];
    self.life.text=@"X 7";
    self.resultLabel.text=@"";
    self.hint.text=@"";
    
    self.word=words[self.randNo];
    self.wordLength=[self.word length];
    int i;
    self.guessedWord=@"";
    for (i=0; i<self.wordLength; i++) {
        self.guessedWord=[NSString stringWithFormat:@"%@%@", self.guessedWord, @"*"];
    }
    [self disableEffects];
    self.IBword.text=self.guessedWord;
    
    
}
- (IBAction)IBhint:(id)sender {
    self.hi.userInteractionEnabled=NO;
    self.hi.backgroundColor=[UIColor orangeColor];
    if(self.availHintNo<1)
    {
        self.hint.text=@"Sorry No Hints available for you";
    }
    else {
        self.hint.text=hints[self.randNo];
        self.availHintNo=self.availHintNo-1;
        self.availHint.text=[NSString stringWithFormat:@"%li", (long)self.availHintNo];
    }
}

- (IBAction)IBa:(id)sender {
    int x=[self check:'A'];
    if(x!=2){
    self.a.userInteractionEnabled=NO;
    if(x==1)
    {
        self.a.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.a.backgroundColor=[UIColor redColor];
    }
    }
    
}
- (IBAction)IBb:(id)sender {
    int x=[self check:'B'];
    if(x!=2){
    self.b.userInteractionEnabled=NO;
    if(x==1)
    {
        self.b.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.b.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBc:(id)sender {
    int x=[self check:'C'];
    if(x!=2){
    self.c.userInteractionEnabled=NO;
    if(x==1)
    {
        self.c.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.c.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBd:(id)sender {
    int x=[self check:'D'];
    if(x!=2){
    self.d.userInteractionEnabled=NO;
    if(x==1)
    {
        self.d.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.d.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBe:(id)sender {
    int x=[self check:'E'];
    if(x!=2){
    self.e.userInteractionEnabled=NO;
    if(x==1)
    {
        self.e.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.e.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBf:(id)sender {
    int x=[self check:'F'];
    if(x!=2){
    self.f.userInteractionEnabled=NO;
    if(x==1)
    {
        self.f.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.f.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBg:(id)sender {
    int x=[self check:'G'];
    if(x!=2){
    self.g.userInteractionEnabled=NO;
    if(x==1)
    {
        self.g.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.g.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBh:(id)sender {
    int x=[self check:'H'];
    if(x!=2){
    self.h.userInteractionEnabled=NO;
    if(x==1)
    {
        self.h.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.h.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBi:(id)sender {
    int x=[self check:'I'];
    if(x!=2){
    self.i.userInteractionEnabled=NO;
    if(x==1)
    {
        self.i.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.i.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBj:(id)sender {
    int x=[self check:'J'];
    if(x!=2){
    self.j.userInteractionEnabled=NO;
    if(x==1)
    {
        self.j.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.j.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBk:(id)sender {
    int x=[self check:'K'];
    if(x!=2){
    self.k.userInteractionEnabled=NO;
    if(x==1)
    {
        self.k.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.k.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBl:(id)sender {
    int x=[self check:'L'];
    if(x!=2){
    self.l.userInteractionEnabled=NO;
    if(x==1)
    {
        self.l.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.l.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBm:(id)sender {
    int x=[self check:'M'];
    if(x!=2){
    self.m.userInteractionEnabled=NO;
    if(x==1)
    {
        self.m.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.m.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBn:(id)sender {
    int x=[self check:'N'];
    if(x!=2){
    self.n.userInteractionEnabled=NO;
    if(x==1)
    {
        self.n.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.n.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBo:(id)sender {
    int x=[self check:'O'];
    if(x!=2){
    self.o.userInteractionEnabled=NO;
    if(x==1)
    {
        self.o.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.o.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBp:(id)sender {
    int x=[self check:'P'];
    if(x!=2){
    self.p.userInteractionEnabled=NO;
    if(x==1)
    {
        self.p.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.p.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBq:(id)sender {
    int x=[self check:'Q'];
    if(x!=2){
    self.q.userInteractionEnabled=NO;
    if(x==1)
    {
        self.q.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.q.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBr:(id)sender {
    int x=[self check:'R'];
    if(x!=2){
    self.r.userInteractionEnabled=NO;
    if(x==1)
    {
        self.r.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.r.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBs:(id)sender {
    int x=[self check:'S'];
    if(x!=2){
    self.s.userInteractionEnabled=NO;
    if(x==1)
    {
        self.s.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.s.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBt:(id)sender {
    int x=[self check:'T'];
    if(x!=2){
    self.t.userInteractionEnabled=NO;
    if(x==1)
    {
        self.t.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.t.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBu:(id)sender {
    int x=[self check:'U'];
    if(x!=2){
    self.u.userInteractionEnabled=NO;
    if(x==1)
    {
        self.u.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.u.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBv:(id)sender {
    int x=[self check:'V'];
    if(x!=2){
    self.v.userInteractionEnabled=NO;
    if(x==1)
    {
        self.v.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.v.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBw:(id)sender {
    int x=[self check:'W'];
    if(x!=2){
    self.w.userInteractionEnabled=NO;
    if(x==1)
    {
        self.w.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.w.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBx:(id)sender {
    int x=[self check:'X'];
    if(x!=2){
    self.x.userInteractionEnabled=NO;
    if(x==1)
    {
        self.x.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.x.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBy:(id)sender {
    int x=[self check:'Y'];
    if(x!=2){
    self.y.userInteractionEnabled=NO;
    if(x==1)
    {
        self.y.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.y.backgroundColor=[UIColor redColor];
    }
    }
}
- (IBAction)IBz:(id)sender {
    int x=[self check:'Z'];
    if(x!=2){
    self.z.userInteractionEnabled=NO;
    if(x==1)
    {
        self.z.backgroundColor=[UIColor orangeColor];
    }
    else {
        self.z.backgroundColor=[UIColor redColor];
    }
    }
}

-(void)disableEffects {
    
    self.a.userInteractionEnabled=YES;
    self.a.backgroundColor=[UIColor grayColor];
    self.b.userInteractionEnabled=YES;
    self.b.backgroundColor=[UIColor grayColor];
    self.c.userInteractionEnabled=YES;
    self.c.backgroundColor=[UIColor grayColor];
    self.d.userInteractionEnabled=YES;
    self.d.backgroundColor=[UIColor grayColor];
    self.e.userInteractionEnabled=YES;
    self.e.backgroundColor=[UIColor grayColor];
    self.f.userInteractionEnabled=YES;
    self.f.backgroundColor=[UIColor grayColor];
    self.g.userInteractionEnabled=YES;
    self.g.backgroundColor=[UIColor grayColor];
    self.h.userInteractionEnabled=YES;
    self.h.backgroundColor=[UIColor grayColor];
    self.i.userInteractionEnabled=YES;
    self.i.backgroundColor=[UIColor grayColor];
    self.j.userInteractionEnabled=YES;
    self.j.backgroundColor=[UIColor grayColor];
    self.k.userInteractionEnabled=YES;
    self.k.backgroundColor=[UIColor grayColor];
    self.l.userInteractionEnabled=YES;
    self.l.backgroundColor=[UIColor grayColor];
    self.m.userInteractionEnabled=YES;
    self.m.backgroundColor=[UIColor grayColor];
    self.n.userInteractionEnabled=YES;
    self.n.backgroundColor=[UIColor grayColor];
    self.o.userInteractionEnabled=YES;
    self.o.backgroundColor=[UIColor grayColor];
    self.p.userInteractionEnabled=YES;
    self.p.backgroundColor=[UIColor grayColor];
    self.q.userInteractionEnabled=YES;
    self.q.backgroundColor=[UIColor grayColor];
    self.r.userInteractionEnabled=YES;
    self.r.backgroundColor=[UIColor grayColor];
    self.s.userInteractionEnabled=YES;
    self.s.backgroundColor=[UIColor grayColor];
    self.t.userInteractionEnabled=YES;
    self.t.backgroundColor=[UIColor grayColor];
    self.u.userInteractionEnabled=YES;
    self.u.backgroundColor=[UIColor grayColor];
    self.v.userInteractionEnabled=YES;
    self.v.backgroundColor=[UIColor grayColor];
    self.w.userInteractionEnabled=YES;
    self.w.backgroundColor=[UIColor grayColor];
    self.x.userInteractionEnabled=YES;
    self.x.backgroundColor=[UIColor grayColor];
    self.y.userInteractionEnabled=YES;
    self.y.backgroundColor=[UIColor grayColor];
    self.z.userInteractionEnabled=YES;
    self.z.backgroundColor=[UIColor grayColor];
    self.hi.userInteractionEnabled=YES;
    self.hi.backgroundColor=[UIColor grayColor];
}


@end
