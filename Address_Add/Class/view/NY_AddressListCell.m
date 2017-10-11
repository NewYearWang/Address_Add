//
//  NY_AddressListCell.m
//  中安生态商城
//
//  Created by NewYear on 2017/7/18.
//  Copyright © 2017年 王鑫年. All rights reserved.
//

#import "NY_AddressListCell.h"


@interface NY_AddressListCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb_name;
@property (weak, nonatomic) IBOutlet UILabel *lb_tel;
@property (weak, nonatomic) IBOutlet UILabel *lb_address;

@property (weak, nonatomic) IBOutlet UIImageView *im_isDefalt;
@property (weak, nonatomic) IBOutlet UILabel *lb_isDefalt;

@end

@implementation NY_AddressListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setAddressModel:(NY_AddressModel *)addressModel {
    if (_addressModel != addressModel) {
        _addressModel = addressModel;
        
        _lb_name.text = addressModel.name;
        _lb_address.text = addressModel.address;
        _lb_tel.text = addressModel.tel;
        
        if (_addressModel.is_default) {
            _im_isDefalt.image = [UIImage imageNamed:@"shopcarsel"];
            _lb_isDefalt.text = @"默认地址";
            _lb_isDefalt.textColor = [UIColor redColor];
        } else {
            _im_isDefalt.image = [UIImage imageNamed:@"shopcar"];
            _lb_isDefalt.text = @"设为默认";
            _lb_isDefalt.textColor = [UIColor grayColor];
        }
        
        
    }
}
- (IBAction)defaltAddress:(UIButton *)sender {
    [self.delegate defaltAddressWithId:_addressModel.addressId withIndex:_index];
}
- (IBAction)bianjiAddress:(UIButton *)sender {
    [self.delegate upDateAddressWithId:_addressModel.addressId withIndex:_index];
}
- (IBAction)deleteAddress:(UIButton *)sender {
    [self.delegate deleteAddressWithId:_addressModel.addressId withIndex:_index];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
