//
//  CQSBDelCellView.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/2/6.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQSBDelCellView : UIView


-(instancetype)initWithFrame:(CGRect)frame withPoint:(CGPoint)point withTites:(NSArray *)titles;

-(void)show;

-(void)dismiss;

@end
