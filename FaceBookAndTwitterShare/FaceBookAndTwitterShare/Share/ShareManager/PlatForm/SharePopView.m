//
//  SharePopView.m
//  house591
//
//  Created by xiwu on 17/1/16.
//
//

#import "SharePopView.h"
#import "SharePicModel.h"

#define SharePopView_Count 4
#define marginX 27.5 //左右边距
#define itemImageW 50
#define itemIabelH 12
#define SharePopView_ContentH 200
#define SharePopView_BottomH 140

@interface SharePopView(){
    NSArray *images;
    NSArray *titles;
    CGFloat shareAngle;
    CGFloat itemX;
}

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,strong)UIButton *exitBtn;

@property(nonatomic,strong)NSArray *shareModels;

@end

@implementation SharePopView

-(instancetype)initWithButtonModels:(NSArray *)models{
    self = [super initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        _shareModels = models;
        images = [self imagesArray:YES models:models];
        titles = [self imagesArray:NO models:models];
        shareAngle = 0;
        [self loadSubViews];
        [self addEvent];
    }
    return self;
}

- (NSArray *)imagesArray:(BOOL)isPic models:(NSArray *)models{
    NSMutableArray *imageArray = [NSMutableArray array];
    if (models) {
        for (SharePicModel *model in models) {
            [imageArray addObject:(isPic ? [UIImage imageNamed:model.plateImageName] : model.plateTitle)];
        }
    }
    return imageArray;
}

- (void)addEvent{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelfBtn:)]];
}

#pragma mark getter
-(void)setImageUrl:(NSString *)imageUrl {
    self.imageUrl = imageUrl;
}

#pragma mark 子视图初始化
-(void)loadSubViews {
    //模糊效果
    _backGroundView = [UIView new];
    _backGroundView.frame = self.bounds;
    _backGroundView.backgroundColor = RGBCOLOR_TRANSPARENT_NUM(0, 0, 0, 0.3);
    [self addSubview:_backGroundView];
    
    //左边的view
    itemX = (SCREEN_WIDTH-marginX*2-SharePopView_Count*itemImageW)/(SharePopView_Count-1);
    CGFloat itemHeight = itemImageW+itemIabelH+7;
    
    _contentViewLeft = [[UIView alloc] initWithFrame:CGRectMake(0,self.mj_h-SharePopView_ContentH,self.mj_w,SharePopView_ContentH)];
    _contentViewLeft.backgroundColor = TWColor_ffffff;
    [_backGroundView addSubview:_contentViewLeft];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = SYSFontSize(17);
    _titleLabel.text = @"分享到";
    _titleLabel.textColor = TWColor_4c4c4c;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.frame = CGRectMake(0,13,self.mj_w,27.5);
    [_contentViewLeft addSubview:_titleLabel];
    
    //根据传入的图片数组进行初始化对应的点击item
    for (int j = 0; j<images.count; j++) {
        UIView *item = [[UIView alloc] init];
        item.frame = CGRectMake(marginX+(itemX+itemImageW)*(j%SharePopView_Count),_contentViewLeft.mj_h, itemImageW,itemHeight);
        item.tag = 100+j;
        [_contentViewLeft addSubview:item];
        
        UIImageView *img = [[UIImageView alloc] initWithImage:images[j]];
        img.backgroundColor = [UIColor clearColor];
        img.frame = CGRectMake(0, 0, itemImageW, itemImageW);
        img.layer.masksToBounds = YES;
        [item addSubview:img];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-10, itemImageW+7,itemImageW+20,itemIabelH)];
        label.text = titles[j];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = TWColor_808080;
        [item addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = item.bounds;
        [button setTitle:titles[j] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        SharePicModel *model = _shareModels[j];
        button.tag = 1000+model.type;
        //弹出的对应item的点击事件
        [button addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [item addSubview:button];
    }
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,_contentViewLeft.mj_h-35,self.mj_w,35)];
    _bottomView.backgroundColor = TWColor_f2f2f2;
    [_contentViewLeft addSubview:_bottomView];
    
    _exitBtn = [[UIButton alloc] initWithFrame:CGRectMake((_bottomView.mj_w-60)/2,0,60, _bottomView.mj_h)];
    [_exitBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_exitBtn setTitleColor:TWColor_999999 forState:UIControlStateNormal];
    [_exitBtn setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    _exitBtn.titleLabel.font = SYSFontSize(15);
    [_exitBtn addTarget:self action:@selector(dismissSelfBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_exitBtn];
    
}

#pragma mark 关闭当前视图
-(void)dismissSelfBtn:(UIButton *)btn {
    WS(weakSelf)
    for (id vbc in _contentViewLeft.subviews) {
        if ([vbc isKindOfClass:[UIView class]]&&vbc!=_titleLabel&&vbc!=_bottomView) {
            UIView *itemView = (UIView *)vbc;
            NSInteger index = itemView.tag - 100;
            [UIView animateWithDuration:1 delay:0.2-(0.06)*index/SharePopView_Count usingSpringWithDamping:0.5f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseIn animations:^{
                itemView.frame = CGRectMake(itemView.frame.origin.x, itemView.frame.origin.y + SharePopView_BottomH, itemView.frame.size.width, itemView.frame.size.height);
                weakSelf.alpha = 0;
            } completion:^(BOOL finished) {
            }];
        }
    }
}


#pragma mark item点击事件
-(void)itemBtnClick:(UIButton *)btn {
    [self.delegate itemDidSelected:(btn.tag - 1000)];
    if (btn.tag>=110 && btn.tag<116) {
       
    }else{
        //点击左边视图item
        btn.layer.masksToBounds = YES;
        UIView *itemview = [btn superview];
        [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            itemview.alpha = 0;
            [UIView animateWithDuration:.2f animations:^{
                //取出当前在左边视图显示的所有item。注：item为view，但点击事件在button上面
                for (id vbc in _contentViewLeft.subviews) {
                    if ([vbc isKindOfClass:[UIView class]]&&vbc!=_titleLabel&&vbc!=_bottomView) {
                        UIView *vbcc = (UIView *)vbc;
                        //判断是否为点击的item，如果是，则放大item。如果不是，则缩小item
                        if (vbcc.tag != itemview.tag) {
                            vbcc.layer.transform = CATransform3DMakeScale(.1f, .1f, 1);
                            vbcc.alpha = 0;
                        }else{
                            itemview.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1);
                        }
                    }
                }
            } completion:^(BOOL finished) {
                self.alpha = 0;
            }];
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark 弹出当前视图
-(void)show {
    WS(weakSelf)
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.backGroundView.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        });
    });
    
    //取出当前左边视图显示的所有item
    for (id vbb in _contentViewLeft.subviews) {
        if ([vbb isKindOfClass:[UIView class]]&&vbb!=_titleLabel&&vbb!=_bottomView) {
            UIView *itemview = (UIView *)vbb;
            itemview.transform = CGAffineTransformScale(itemview.transform, .9f, .9f);  //修改大小
            NSInteger index = itemview.tag - 100;
            _contentViewLeft.alpha = 0;
            [UIView animateWithDuration:.7f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                weakSelf.contentViewLeft.alpha = 1;
                [UIView animateWithDuration:.9f delay:(0.06)*index/SharePopView_Count usingSpringWithDamping:.6725f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    itemview.frame = CGRectMake(itemview.frame.origin.x, itemview.frame.origin.y - SharePopView_BottomH, itemview.frame.size.width, itemview.frame.size.height);
                } completion:^(BOOL finished) {
                }];
            } completion:nil];
        }
    }
}


@end
