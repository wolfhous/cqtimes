//
//  CQSBNewTypeCollectionReusableView.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBNewTypeCollectionReusableView.h"

@implementation CQSBNewTypeCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.layer.cornerRadius = self.rightBtn.xmg_height/2;
    self.rightBtn.layer.borderColor = CQSBMainColor.CGColor;
    self.rightBtn.layer.borderWidth = 0.7;
    
    
    [self.rightBtn setTitle:@"排序/删除" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"完成" forState:UIControlStateSelected];
    
    
}

@end
