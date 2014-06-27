//
//  PCKTableViewCell.m
//  PokeCoke
//
//  Created by Savitha Reddy on 6/26/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "PCKTableViewCell.h"

@implementation PCKTableViewCell
{
    UIImageView *image;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
        image.layer.masksToBounds=YES;
        [self.contentView addSubview:image];
        
        self.productName = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 150, 20)];
        self.productName.font = [UIFont fontWithName:@"Helvetica Neue Light " size:15];
        [self.contentView addSubview:self.productName];
        
    }
    return self;
}

-(void)setProductsInfo:(NSDictionary *)productsInfo
{
    _productsInfo = productsInfo;
    
    image.image = productsInfo[@"image"];
    self.productName.text = productsInfo[@"name"];
    
}

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}

@end
