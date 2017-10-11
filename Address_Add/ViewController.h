//
//  ViewController.h
//  Address_Add
//
//  Created by NewYear on 2017/10/11.
//  Copyright © 2017年 NewYear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NY_AddressModel.h"
typedef void(^ SelectAddressBlock)(NY_AddressModel *model);

@interface ViewController : UIViewController


@property (nonatomic,copy)SelectAddressBlock addressBlcok;


@end

