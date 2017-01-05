//
//  UIImageView+HSRound.m
//  lkzb
//
//  Created by hou on 16/7/21.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "UIImageView+HSRound.h"

@implementation UIImageView (HSRound)
-(void)hs_setRound{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.xmg_width/2;
}
-(void)hs_setRoundRadius:(CGFloat)cornerRadius{
    
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = cornerRadius;
}
@end
