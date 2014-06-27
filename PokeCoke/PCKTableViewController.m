//
//  PCKTableViewController.m
//  PokeCoke
//
//  Created by Savitha Reddy on 6/25/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "PCKTableViewController.h"
#import "PCKTableViewCell.h"
#import <Parse/Parse.h>
#import "PCKMapViewController.h"



@interface PCKTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation PCKTableViewController
{
    NSArray *alphabets;
    NSDictionary *cokeProducts;
    NSArray *productSectionTitles;
    NSDictionary *products;
    NSArray *sectionProducts;
    
    UIBarButtonItem * back;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.rowHeight = 50;
        self.tableView.separatorColor = HEADER_COLOR;
        
        back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goStartScreen)];
        back.tintColor = BACKGROUND_COLOR;
        
        self.navigationItem.leftBarButtonItem = back;

        
        
    }
    return self;
}

-(void)goStartScreen
{

    [self.navigationController popViewControllerAnimated:YES];

}



-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = HEADER_COLOR;
    self.navigationController.toolbarHidden = YES;
    
    UILabel *headerName = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH)/2-50, 10, 100, 36)];
    [headerName setText:@"Products"];
    headerName.textAlignment = NSTextAlignmentCenter;
    [headerName setTextColor:BACKGROUND_COLOR];
    [headerName setFont:[UIFont fontWithName:@"LOKICOLA" size:30]];
    [self.navigationController.navigationBar addSubview:headerName];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *letters= @"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z";
    
    alphabets = [letters componentsSeparatedByString:@" "];
    cokeProducts = @{@"C" : @[@{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Coca Cola"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Coca-Cola Classic"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Coca Cola Zero"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Coca Cola Diet"}],
                     @"P" : @[@{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Paani"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Paani"}],
                     @"F" : @[@{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Fanta"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Fanta Grape"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Fanta Strawberry"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Fanta Lemon"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Fanta Pineapple"}],
                     @"Z" : @[@{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Zico"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Zico"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Zico"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Zico"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Zico"}],
                     @"M" : @[@{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Minute"},
                              @{@"image": [UIImage imageNamed:@"Coke"],@"name": @"Minute"}]};
       
    productSectionTitles = [[cokeProducts allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionTitle = [productSectionTitles objectAtIndex:section];
    sectionProducts = [cokeProducts objectForKey:sectionTitle];
    return [sectionProducts count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return [productSectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [productSectionTitles objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    PCKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[PCKTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *sectionTitle = [productSectionTitles objectAtIndex:indexPath.section];
    sectionProducts = [cokeProducts objectForKey:sectionTitle];
    products = [sectionProducts objectAtIndex:indexPath.row];
    
    cell.productsInfo = products;
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return alphabets;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [productSectionTitles indexOfObject:title];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *sectionTitle = [productSectionTitles objectAtIndex:indexPath.section];
    sectionProducts = [cokeProducts objectForKey:sectionTitle];
    products = [sectionProducts objectAtIndex:indexPath.row];
    
    PCKMapViewController *passValue = [[PCKMapViewController alloc] init];
    if (passValue.view) {
    passValue.productName.text = products[@"name"];
    }
    [self.navigationController pushViewController:passValue animated:YES];

}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
