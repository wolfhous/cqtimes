//
//  CQSBLoginVC.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/2/28.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBLoginVC.h"

@interface CQSBLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *uesrPwdTextField;

@end

@implementation CQSBLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)clickLoginBtn:(id)sender {
    
    if (self.uesrPwdTextField.text.length < 1 || self.uesrPwdTextField.text.length < 1) {
        DLog(@"用户名密码不能为空")
        return;
    }
    
    
}


@end
