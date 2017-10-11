//
//  NY_AddressListVC.h
//  中安生态商城
//
//  Created by NewYear on 2017/7/18.
//  Copyright © 2017年 王鑫年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NY_AddressModel.h"
typedef void(^ SelectAddressBlock)(NY_AddressModel *model);
@interface NY_AddressListVC : UIViewController

@property (nonatomic,copy)SelectAddressBlock addressBlcok;
@end
