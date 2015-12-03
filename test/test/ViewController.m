//
//  ViewController.m
//  test
//
//  Created by ZhijieLi on 11/20/15.
//  Copyright © 2015 ZhijieLi. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"

@interface ViewController ()

@property (strong,nonatomic) ViewModel *viewModel;

@property (strong,nonatomic) UITextView *showTextView;

@end

@implementation ViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // requestData
    [self _initViews];
    [self setupKVO];
    [self.viewModel getImagesList];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self removeKVO];
}

#pragma mark - KVO
- (void)setupKVO {
    [self.viewModel addObserver:self forKeyPath:@"racMsg" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
}

- (void)removeKVO {
    [self.viewModel removeObserver:self forKeyPath:@"racMsg"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"racMsg"]) {
        if ([_viewModel.racMsg isEqualToString:@"success"]) {
            _showTextView.text = [NSString stringWithFormat:@"%@",_viewModel.data];
        }
        else {
            _showTextView.text = @"error";
        }
    }
}

#pragma mark - Event Response
- (void)getPre {
    [self.viewModel getPreImagesList];
}

- (void)getNext {
    [self.viewModel getNextImagesList];
}

#pragma mark - Private
- (void)_initViews {
    UIButton *preBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 50, 200, 40)];
    [preBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [preBtn setTitle:@"Pre" forState:UIControlStateNormal];
    [preBtn addTarget:self action:@selector(getPre) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:preBtn];

    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 150, 200, 40)];
    [nextBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nextBtn setTitle:@"nextBtn" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(getNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];

    _showTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 200, 320, 200)];
    _showTextView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_showTextView];

}

#pragma mark - Getter
- (ViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[ViewModel alloc]init];
    }
    return _viewModel;
}


@end
