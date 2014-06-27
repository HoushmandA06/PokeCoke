//
//  PCKViewController.m
//  PokeCoke
//
//  Created by Ali Houshmand on 6/26/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "PCKViewController.h"
#import "PCKMapViewController.h"
#import "PCKTableViewController.h"
#import "PCKNavVC.h"

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
    
    
    UILabel * appLogo = [[UILabel alloc] initWithFrame:CGRectMake(0,25,SCREEN_WIDTH,60)];
    appLogo.text = @"Poke Coke";
    appLogo.textAlignment = NSTextAlignmentCenter;
    appLogo.textColor = BACKGROUND_COLOR;
    appLogo.font = [UIFont fontWithName:@"LOKICOLA" size:50];
    [self.view addSubview:appLogo];
    
    cokeProductList = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50,100,100,100)];
    cokeProductList.layer.cornerRadius = 50;
    cokeProductList.backgroundColor = BACKGROUND_COLOR;
    [cokeProductList addTarget:self action:@selector(pushCokeProductList) forControlEvents:UIControlEventTouchUpInside];
    cokeProductList.titleLabel.textAlignment = NSTextAlignmentCenter;
    cokeProductList.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
   // [cokeProductList setImage:[UIImage imageNamed:@"cap"] forState:UIControlStateNormal];
    
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


-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.toolbarHidden = YES;
    
    
}


-(void)pushCokeProductList
{
    // PUSH TO SAVITHA'S FILE
    
    PCKTableViewController * TVC = [[PCKTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:TVC animated:YES];
    
}


-(void)pushSubmitForm:(UIButton*)sender
{
    PCKMapViewController * submitVC = [[PCKMapViewController alloc] initWithNibName:nil bundle:nil];
    
    if (submitVC.view) {
        submitVC.productName.text = @"No Coca-Cola products at all!";
    }

    [self.navigationController pushViewController:submitVC animated:YES];
}


-(void)phone
{
 
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://7706303262"]];


}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
