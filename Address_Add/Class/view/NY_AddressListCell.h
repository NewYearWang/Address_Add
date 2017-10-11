//
//  NY_AddressListCell.h
//  中安生态商城
//
//  Created by NewYear on 2017/7/18.
//  Copyright © 2017年 王鑫年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NY_AddressModel.h"

@protocol AddressListCellDelegate <NSObject>

- (void)deleteAddressWithId:(NSInteger)addressId withIndex:(NSInteger)index;
- (void)upDateAddressWithId:(NSInteger)addressId withIndex:(NSInteger)index;
- (void)defaltAddressWithId:(NSInteger)addressId withIndex:(NSInteger)index;

@end

@interface NY_AddressListCell : UITableViewCell

@property (nonatomic, weak) id<AddressListCellDelegate> delegate;

@property (nonatomic, strong) NY_AddressModel *addressModel;
@property (nonatomic, assign) NSInteger index;

@end
