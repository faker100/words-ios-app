//
//  LGTextSearchController.m
//  Word
//
//  Created by caoguochi on 2018/4/15.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTextSearchController.h"
#import "LGWordDetailController.h"

@interface LGTextSearchController () 

@property (nonatomic, strong) NSMutableArray<LGSearchModel *> *searchResultArray;

@end

@implementation LGTextSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *str = searchController.searchBar.text;
    if (str.length != 0) {
        [self requestDataWithStr:str];
    }
    
}

- (void)requestDataWithStr:(NSString *)str{
    [self.request requestSearchWordWithStr:str completion:^(id response, LGError *error) {
        if ([self isNormal:error]) {
            self.searchResultArray = [LGSearchModel mj_objectArrayWithKeyValuesArray:response];
        }
    }];
}

- (void)setSearchResultArray:(NSMutableArray<LGSearchModel *> *)searchResultArray{
    _searchResultArray = searchResultArray;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGSearchResultCell"];
    cell.textLabel.text = self.searchResultArray[indexPath.row].word;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate) {
        [self.delegate selctedSearchModel:self.searchResultArray[indexPath.row]];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
