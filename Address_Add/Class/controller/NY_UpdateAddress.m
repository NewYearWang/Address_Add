//
//  NY_UpdateAddress.m
//  中安生态商城
//
//  Created by NewYear on 2017/7/18.
//  Copyright © 2017年 王鑫年. All rights reserved.
//

#import "NY_UpdateAddress.h"

#import "WXNProvincialPickerview.h"
#import "WXNAddressManager.h"

@interface NY_UpdateAddress ()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) WXNProvincialPickerview *regionPickerView;
@property (weak, nonatomic) IBOutlet UITextField *tx_name;
@property (weak, nonatomic) IBOutlet UITextField *tx_phone;
@property (weak, nonatomic) IBOutlet UILabel *lb_adress;
@property (weak, nonatomic) IBOutlet UITextView *tx_detailAddress;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (assign, nonatomic) NSString *pid;
@property (assign, nonatomic) NSString *ciid;
@property (assign, nonatomic) NSString *coid;

@property (copy, nonatomic) NSArray *addressArr;

@property (nonatomic, strong) NSString *isTure;
@end

@implementation NY_UpdateAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addRightNavBarWithText:@"保存"];
    
    _addressArr = kAddressManager.provinceDicAry;
    
    _tx_name.text = _addressModel.name;
    _tx_phone.text = _addressModel.mobile;
    _lb_adress.text = _addressModel.region;
    _tx_detailAddress.text = _addressModel.address;
    
//    _tx_detailAddress.placeholder = @"请填写详细地址，不少于5个字...";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewEndEditing)];
    [self.backView addGestureRecognizer:tap];
    _isTure = @"";
//    [self createRac];
}

- (void)addRightNavBarWithText:(NSString*)title {
    
    if (self.navigationItem.rightBarButtonItem)
    {
        self.navigationItem.rightBarButtonItem= nil;
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button addTarget:self action:@selector(naviRightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}

- (void)viewEndEditing {
    [self.view endEditing:YES];
}

//- (void)createRac {
//
//    // 创建验证用户名的信道
//    RACSignal *Signal1 = [self.tx_name.rac_textSignal
//                          map:^id(NSString *text) {
//                              return @([self isValidName:text]);
//                          }];
//
//
//    // 创建用户名的信道
//    RACSignal *Signal2 = [self.tx_phone.rac_textSignal
//                          map:^id(NSString *text) {
//                              return @([self isValidTel:text]);
//                          }];
//
//    // 创建验证身份证的信号
//    RACSignal *Signal3 = [self.tx_detailAddress.rac_textSignal
//                          map:^id(NSString *text) {
//                              return @([self isValidDetailAddress:text]);
//                          }];
//
//    // 创建登录按扭的信号，把用户名与密码合成一个信道
//    RACSignal *step2NextSignal = [RACSignal
//                                  combineLatest:@[
//                                                  Signal1,
//                                                  Signal2,
//                                                  Signal3
//                                                  ]
//                                  reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid, NSNumber *detailValid) {
//                                      return @([usernameValid boolValue] && [passwordValid boolValue] && [detailValid boolValue]);
//                                  }];
//
//
//    // 订阅 loginActiveSignal, 使按扭是否可用
//    [step2NextSignal subscribeNext:^(NSNumber*loginActiveSignal) {
//
//        if ([loginActiveSignal boolValue]) {
//            _isTure = @"1";
//        }
//        else {
//            _isTure = @"";
//        }
//    }];
//
//
//}

- (BOOL )isValidName:(NSString *)nameStr {
    return nameStr.length > 1;
}

- (BOOL )isValidTel:(NSString *)tel {
    return tel.length > 10;
}

- (BOOL )isValidDetailAddress:(NSString *)address {
    return address.length > 4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)naviRightAction {

        if (_pid == nil || ([_pid.class isSubclassOfClass:NSString.class] && [_pid isEqualToString:@""])) {

        } else if (_ciid == nil || ([_ciid.class isSubclassOfClass:NSString.class] && [_ciid isEqualToString:@""])) {

        } else if (_coid == nil || ([_coid.class isSubclassOfClass:NSString.class] && [_coid isEqualToString:@""])) {

        }
        else {
            
            NY_AddressModel *address = [[NY_AddressModel alloc] init];
            address.address = _tx_detailAddress.text;
            address.province = _pid != nil ? _pid : @"";
            address.city = _ciid != nil ? _ciid : @"";;
            address.district = _coid != nil ? _coid : @"";
            address.is_default = false;
            address.mobile = _tx_phone.text;
            address.name = _tx_name.text;
            address.tel = _tx_phone.text;
            
            // 取本地地址列表
            NSMutableArray *arr = [NSMutableArray array];
            NSData * data1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"Test"];
            [arr addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithData:data1]];
            // 添加新地址
            [arr addObject:address];
            
            
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject:arr];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Test"];
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }
}

- (IBAction)selectAddress:(UIButton *)sender {
    NSString *address = _lb_adress.text;
    NSArray *array = [address componentsSeparatedByString:@" "];
    
    NSString *province = @"";//省
    NSString *city = @"";//市
    NSString *county = @"";//县
    if (array.count > 2) {
        province = array[0];
        city = array[1];
        county = array[2];
    } else if (array.count > 1) {
        province = array[0];
        city = array[1];
    } else if (array.count > 0) {
        province = array[0];
    }
    
    [self.regionPickerView showPickerWithProvinceName:province cityName:city countyName:county];
    
}

- (IBAction)deleteAddress:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要删除该地址吗"
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleAlert ];
    
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (WXNProvincialPickerview *)regionPickerView {
    if (!_regionPickerView) {
        _regionPickerView = [[WXNProvincialPickerview alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        __weak typeof(self) wself = self;
        _regionPickerView.completion = ^(NSString *provinceName,NSString *cityName,NSString *countyName,NSString *provinceId,NSString *cityId,NSString *countyId) {
            __strong typeof(wself) self = wself;
            self.lb_adress.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName];
            self.pid = provinceId;
            self.ciid = cityId;
            self.coid = countyId;
        };
        [self.navigationController.view addSubview:_regionPickerView];
    }
    return _regionPickerView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textViewShouldReturn:(UITextView *)textView {
    [self.view endEditing:YES];
    return YES;
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
