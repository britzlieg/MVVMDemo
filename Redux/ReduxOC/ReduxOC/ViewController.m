//
//  ViewController.m
//  ReduxOC
//
//  Created by ZhijieLi on 09/06/2017.
//  Copyright © 2017 britzlieg. All rights reserved.
//

#import "ViewController.h"
#import "YKDispatchCenter.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    YKDispatchCenterHandler handler = ^(YKMessage *message, id ext){
        NSLog(@"ab");
    };

    self.testView = [UIView new];

    [[YKDispatchCenter shared]registerMessageWithIdentify:@"test"];
    [[YKDispatchCenter shared]subscribeWithBinder:self.testView messageIdentify:@"test" handler:handler];
    [[YKDispatchCenter shared]subscribeWithBinder:self messageIdentify:@"test" handler:^(YKMessage *message, id ext) {
        NSLog(@"dd");
    }];

    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 50, 50)];
    addButton.backgroundColor = [UIColor redColor];
    [addButton addTarget:self action:@selector(addButtonTapAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)addButtonTapAction {
    YKMessage *message = [[YKMessage alloc]initWithIdentify:@"test" context:@[@"1",@"2"]];
    [[YKDispatchCenter shared]dispatchMessage:message];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(4);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.testView = nil;
        });
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
