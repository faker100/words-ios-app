//
//  LGFreeLibraryWordListController.m
//  Word
//
//  Created by caoguochi on 2018/1/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGFreeLibraryWordListController.h"
#import "UIScrollView+LGRefresh.h"

@interface LGFreeLibraryWordListController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation LGFreeLibraryWordListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUserInterface];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configUserInterface{
    [self.tableView setRefreshType:LGRefreshOnlyHeader refreshBlock:^{
        [self requestData];
    }];
}

- (void)requestData{
    
    [self.request requestFreeLibraryWordList:self.wordLibraryModel.ID completion:^(id response, LGError *error) {
        NSLog(@"%@",response);
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
