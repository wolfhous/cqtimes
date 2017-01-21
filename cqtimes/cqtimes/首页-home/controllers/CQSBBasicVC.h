//
//  CQSBBasicVC.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/7.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQSBBasicVC : UIViewController

/**
 *新闻分类id event_id 和 type 似乎 是一个值
 */
@property (nonatomic,strong)NSString *event_id;

/**
 *新闻分类名字
 */
@property (nonatomic,strong)NSString *event_value;

/**
 *新闻分类id event_id 和 type 似乎 是一个值
 */
@property (nonatomic,strong)NSString *type;

@end
