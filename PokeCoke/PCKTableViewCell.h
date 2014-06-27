//
//  PCKTableViewCell.h
//  PokeCoke
//
//  Created by Savitha Reddy on 6/26/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PCKTableViewCellDelegate;

@interface PCKTableViewCell : UITableViewCell

@property (nonatomic) NSDictionary *productsInfo;

@property (nonatomic,assign) id<PCKTableViewCellDelegate> delegate;


@property (nonatomic) UILabel *productName;

@end

@protocol PCKTableViewCellDelegate <NSObject>

@optional


@end
