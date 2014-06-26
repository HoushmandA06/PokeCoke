//
//  PCKViewController.m
//  PokeCoke
//
//  Created by Ali Houshmand on 6/26/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "PCKViewController.h"
#import "PCKMapViewController.h"

@interface PCKViewController ()

@end

@implementation PCKViewController
{
    
    UIButton * noCoke;
    UIButton * cokeProductList;
    UIButton * callCoke;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.view.backgroundColor = HEADER_COLOR;
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cokeProductList = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50,75,100,100)];
    cokeProductList.layer.cornerRadius = 50;
    cokeProductList.backgroundColor = BACKGROUND_COLOR;
    [cokeProductList addTarget:self action:@selector(pushCokeProductList) forControlEvents:UIControlEventTouchUpInside];
    cokeProductList.titleLabel.textAlignment = NSTextAlignmentCenter;
    cokeProductList.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [cokeProductList setTitle:@"I wish you\nsold it here!" forState:UIControlStateNormal];
    cokeProductList.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:15];
    [cokeProductList setTitleColor:HEADER_COLOR forState:UIControlStateNormal];
    [self.view addSubview:cokeProductList];
    
    noCoke = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50,cokeProductList.frame.origin.y+125,100,100)];
    noCoke.layer.cornerRadius = 50;
    noCoke.backgroundColor = BACKGROUND_COLOR;
    [noCoke addTarget:self action:@selector(pushSubmitForm:) forControlEvents:UIControlEventTouchUpInside];
    noCoke.titleLabel.textAlignment = NSTextAlignmentCenter;
    noCoke.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [noCoke setTitle:@"Gasp!\nNo Coke Products!" forState:UIControlStateNormal];
    [noCoke setTitleColor:HEADER_COLOR forState:UIControlStateNormal];
    noCoke.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:15];
    [self.view addSubview:noCoke];
        
    callCoke = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50,noCoke.frame.origin.y+125,100,100)];
    callCoke.layer.cornerRadius = 50;
    callCoke.backgroundColor = BACKGROUND_COLOR;
    [callCoke addTarget:self action:@selector(phone) forControlEvents:UIControlEventTouchUpInside];
    callCoke.titleLabel.textAlignment = NSTextAlignmentCenter;
    callCoke.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [callCoke setTitle:@"Call Coke,\nSpeak to a Human" forState:UIControlStateNormal];
    callCoke.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:15];
    [callCoke setTitleColor:HEADER_COLOR forState:UIControlStateNormal];
    [self.view addSubview:callCoke];
    
}



-(void)pushCokeProductList
{
    
    // PUSH TO SAVITHA'S FILE
    
    
}


-(void)pushSubmitForm:(UIButton*)sender
{
    
    
    PCKMapViewController * submitVC = [[PCKMapViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:submitVC animated:NO completion:nil];
    submitVC.productName.text = @"No Coca-Cola products at all!";
    
}


-(void)phone
{
    
 
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://7706303262"]];


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
