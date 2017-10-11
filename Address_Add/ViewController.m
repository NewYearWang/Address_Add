//
//  ViewController.m
//  Address_Add
//
//  Created by NewYear on 2017/10/11.
//  Copyright © 2017年 NewYear. All rights reserved.
//

#import "ViewController.h"
#import "NY_AddressListVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)MyAddress:(UIButton *)sender {
    NY_AddressListVC *vc = [[NY_AddressListVC alloc]initWithNibName:@"NY_AddressListVC" bundle:nil];
    __weak typeof(self) weakSelf = self;
    vc.addressBlcok = ^(NY_AddressModel *model){
//        _defaultModel = model;
//        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
