//
//  CQSBDelCellView.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/2/6.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CQSBDelCellView;

@protocol CQSBDelCellViewDelegate <NSObject>

/**
 代理回调

 @param index button的tag值 01234...
 @param indexPath cell位置
 */
-(void)CQSBDelCellViewDelegate_ClickBtnIndex:(NSInteger)index withIndexPath:(NSIndexPath*)indexPath;

@end


@interface CQSBDelCellView : UIView

@property (nonatomic,weak)id<CQSBDelCellViewDelegate> delegate;

@property (nonatomic,copy)NSIndexPath *indexPath;

/**
 初始化方法

 @param frame [UIScreen mainScreen].bounds
 @param point 箭头点位置
 @param titles 屏蔽理由数组
 @param indexpath 当前cell位置
 @param delegate 代理
 @return 初始化
 */
-(instancetype)initWithFrame:(CGRect)frame withPoint:(CGPoint)point withTites:(NSArray *)titles withIndexPath:(NSIndexPath*)indexpath withDelegate:(id)delegate;

/**
 显示
 */
-(void)show;

/**
 隐藏
 */
-(void)dismiss;



@end
