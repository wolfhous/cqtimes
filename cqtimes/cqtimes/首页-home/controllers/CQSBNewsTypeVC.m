//
//  CQSBNewsTypeVC.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBNewsTypeVC.h"
#import "CQSBNewsTypeModel.h"
#import "CQSBNewsTypeCell.h"
#import "CQSBNewTypeCollectionReusableView.h"
@interface CQSBNewsTypeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 *主视图
 */
@property (nonatomic,strong)UICollectionView *collectionView;
/**
 *主类型数组
 */
@property (nonatomic,strong)NSMutableArray<CQSBNewsTypeModel *> *arrayNewstype;


/**
 记录当前是否是编辑状态 默认为否
 */
@property (nonatomic,assign)BOOL isEdit;


/** 网络圈圈*/
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;


@end

@implementation CQSBNewsTypeVC

static NSString *newsTypeCellID = @"newsTypeCellID";
static NSString *headerReusableView = @"headerReusableView";
#pragma mark - 懒加载
-(UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        CGFloat w = 70;
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-w)/2, (SCREEN_HEIGHT-w)/2, w, w)];
        _activityIndicatorView.color = CQSBMainColor;
        [self.view addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}
-(NSMutableArray<CQSBNewsTypeModel *> *)arrayNewstype{
    if (!_arrayNewstype) {
        _arrayNewstype = [NSMutableArray array];
    }
    return _arrayNewstype;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 2.5;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH / 3 - 15, 40);
        layout.sectionInset = UIEdgeInsetsMake(0, 18, 0, 18);
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 44);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, SCREEN_HEIGHT - 55) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"CQSBNewsTypeCell" bundle:nil] forCellWithReuseIdentifier:newsTypeCellID];
        [_collectionView registerNib:[UINib nibWithNibName:@"CQSBNewTypeCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReusableView];
        //添加长按手势（长按移动）
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongGesture:)];
        [_collectionView addGestureRecognizer:longGesture];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
//执行长按移动方法
-(void)handleLongGesture:(UILongPressGestureRecognizer *)longGesture{
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan://开始长按的 点
        {
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath != nil) {
                //开始移动这个item
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            }
        }
            break;
        case UIGestureRecognizerStateChanged://正在移动中
        {
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
        }
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addRithtBackBtn];
    
    //开始转圈
    [self.activityIndicatorView startAnimating];
    [self loadAPI_newstype];
}
//添加返回按钮
-(void)addRithtBackBtn{
    UIButton *btn = [UIButton buttonWithType:0];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(17);
    }];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"closeBtn_27x27_"] forState:UIControlStateNormal];
}
//返回
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//加载数据
-(void)loadAPI_newstype{
    
    HSParameters;
    [HS_Http hs_postAPIName:API_newstype parameters:parameters succes:^(id responseObject) {
        self.arrayNewstype = [CQSBNewsTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"postlist"]];
        //结束转圈
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;
        [self.collectionView reloadData];
    } error:^(id error) {
        //结束转圈
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;

    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.arrayNewstype.count;
    }else{
        return 0;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CQSBNewsTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:newsTypeCellID forIndexPath:indexPath];
    cell.model = self.arrayNewstype[indexPath.row];
    cell.delCategoryImageView.hidden = !self.isEdit;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        CQSBNewTypeCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReusableView forIndexPath:indexPath];
        if (indexPath.section == 0) {
            view.titleLabel.text = @"我的频道";
            view.rightBtn.selected = self.isEdit;
            [view.rightBtn addTarget:self action:@selector(clickReusableViewRightBtn:) forControlEvents:UIControlEventTouchUpInside];
            view.rightBtn.hidden = NO;
        }else{
            view.titleLabel.text = @"推荐频道";
            view.rightBtn.hidden = YES;
        }
        return view;
    }else{
        return nil;
    }
}
#pragma mark - 点击 排序/完成 按钮
-(void)clickReusableViewRightBtn:(UIButton *)btn{
    btn.selected = !btn.isSelected;
    self.isEdit = btn.selected;
    [self.collectionView reloadData];
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.isEdit;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath{
    DLog(@"%ld->%ld",sourceIndexPath.row,destinationIndexPath.row);
    if (sourceIndexPath.section == destinationIndexPath.section) {//如果替换的分区一样
        CQSBNewsTypeModel *model = self.arrayNewstype[sourceIndexPath.row];
        [self.arrayNewstype removeObjectAtIndex:sourceIndexPath.row];
        [self.arrayNewstype insertObject:model atIndex:destinationIndexPath.row];
    }else{//如果替换的分区不一样
        DLog(@"分区替换%ld->%ld",sourceIndexPath.section,destinationIndexPath.section);
    }
}

@end
