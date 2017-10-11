//
//  NY_AddressListVC.m
//  中安生态商城
//
//  Created by NewYear on 2017/7/18.
//  Copyright © 2017年 王鑫年. All rights reserved.
//

#import "NY_AddressListVC.h"
#import "NY_AddressListCell.h"

#import "NY_UpdateAddress.h"
#import "NY_AddAddressVC.h"




@interface NY_AddressListVC ()<UITableViewDelegate, UITableViewDataSource,AddressListCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic, copy) NSMutableArray<NY_AddressModel *> *addressListArr;


@end

@implementation NY_AddressListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self getAddressList];
    self.title = @"我的地址";
        
    [_mTableView registerNib:[UINib nibWithNibName:@"NY_AddressListCell" bundle:nil] forCellReuseIdentifier:@"NY_AddressListCell"];
}

- (void)getAddressList {
    
    // 取本地地址列表
//    _addressListArr = [NSMutableArray array];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"Test"];
    _addressListArr = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    [_mTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _addressListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NY_AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NY_AddressListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.addressModel = [_addressListArr objectAtIndex:indexPath.row];
    cell.index = indexPath.row;
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (_addressBlcok) {
//        NY_AddressModel *model = _addressListArr[indexPath.row];
//        _addressBlcok(model);
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}
- (void)deleteAddressWithId:(NSInteger)addressId withIndex:(NSInteger)index {
    NSDictionary *dic = @{@"consignee":[NSNumber numberWithInteger:addressId]};
    
}

- (void)upDateAddressWithId:(NSInteger)addressId withIndex:(NSInteger)index {
    
    NY_UpdateAddress *addAddressVC = [[NY_UpdateAddress alloc] initWithNibName:@"NY_UpdateAddress" bundle:nil];
    addAddressVC.addressModel = [_addressListArr objectAtIndex:index];
    addAddressVC.title = @"编辑地址";
    [self.navigationController pushViewController:addAddressVC animated:YES];
    
}

- (void)defaltAddressWithId:(NSInteger)addressId withIndex:(NSInteger)index {
    
    NSDictionary *dic = @{@"consignee":[NSNumber numberWithInteger:addressId]};
    
}


- (IBAction)addNewAddresss:(UIButton *)sender {
    
    NY_AddAddressVC *addAddressVC = [[NY_AddAddressVC alloc] initWithNibName:@"NY_AddAddressVC" bundle:nil];
    addAddressVC.title = @"添加新地址";
    [self.navigationController pushViewController:addAddressVC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self getAddressList];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
