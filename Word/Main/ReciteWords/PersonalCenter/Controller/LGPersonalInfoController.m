//
//  LGPersonalInfoController.m
//  Word
//
//  Created by Charles Cao on 2018/3/12.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPersonalInfoController.h"
#import "LGPersonalCell.h"
#import "LGSettingModel.h"
#import "LGUserManager.h"
#import "LGSettingHeaderView.h"
#import "LGTool.h"

@interface LGPersonalInfoController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (nonatomic, strong) NSMutableArray<NSMutableArray<LGSettingModel*> *> *section_Array;


@end

@implementation LGPersonalInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"LGSettingHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LGSettingHeaderView"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//退出
- (IBAction)logoutAction:(id)sender {
	[self.navigationController popToRootViewControllerAnimated:YES];
	[[NSNotificationCenter defaultCenter] postNotificationName:NO_LOGIN_NOTIFICATION object:nil];
	
}



#pragma mark - getter
- (NSMutableArray<NSMutableArray<LGSettingModel *> *> *)section_Array{
	if (!_section_Array) {
		
		/***************************  section 1  ***************************/
		
		NSMutableArray *section_1 = [NSMutableArray array];
		LGUserModel *user = [LGUserManager shareManager].user;
		for (int i = 0; i < 6; i++) {
			
			LGSettingModel *model = [LGSettingModel new];
			model.type = i == 0 ? LGSettingHeadImage : LGSettingMore;
			switch (i) {
				case 0:
					model.info 		= user.image;
					model.infoTitle = @"头像";
					break;
				case 1:
					model.info 		= user.username;
					model.infoTitle = @"用户名";
					break;
				case 2:
					model.info 		= user.nickname;
					model.infoTitle = @"昵称";
					break;
				case 3:
					model.info 		= user.phone;
					model.infoTitle = @"电话";
					break;
				case 4:
					model.info 		= user.email;
					model.infoTitle = @"邮箱";
					break;
				case 5:
					model.info 		= @"*********";
					model.infoTitle = @"密码";
					break;
				default:
					break;
			}
			[section_1 addObject:model];
		}
		
		/***************************  section 2  ***************************/
		
		NSMutableArray *section_2 = [NSMutableArray array];
		for (int i = 0; i < 3; i++) {
			
			LGSettingModel *model = [LGSettingModel new];
			model.type = i == 0 ? LGSettingMore : LGSettingNoMore;
			switch (i) {
				case 0:
					model.info 		= @"http://www.gmatonline.cn";
					model.infoTitle = @"官方网站";
					break;
				case 1:
					model.info 		= @"LGclub";
					model.infoTitle = @"微信公众号";
					break;
				case 2:
					model.info 		= @"439324846";
					model.infoTitle = @"雷哥GMAT QQ备考群";
					break;
					
				default:
					break;
			}
			[section_2 addObject:model];
		}
		
		/***************************  section 3  ***************************/
		
		NSMutableArray *section_3 = [NSMutableArray array];
		for (int i = 0; i < 2; i++) {
			LGSettingModel *model = [LGSettingModel new];
			model.type = LGSettingMore;
			if (i == 0) {
				model.infoTitle = @"版本检测";
				model.info 		= [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
			}else{
				model.infoTitle = @"缓存";
				model.info = @"";
			}
			[section_3 addObject:model];
		}
		
		/***************************  section 4  ***************************/
		
		NSMutableArray *section_4 = [NSMutableArray array];
		LGSettingModel *model = [LGSettingModel new];
		model.type = LGSettingMore;
		model.infoTitle = @"字体大小";
		model.info = [LGUserManager shareManager].user.fontSize;
		[section_4 addObject:model];
		
		_section_Array = [NSMutableArray arrayWithObjects:section_1,section_2,section_3,section_4, nil];
	}
	return _section_Array;
}


#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.section_Array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.section_Array[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGPersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGPersonalCell"];
	cell.settingModel = self.section_Array[indexPath.section][indexPath.row];
	return cell;
}

#pragma mark -UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	
	if (section == 0 || section == 1) {
		LGSettingHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LGSettingHeaderView"];
		headerView.titleLabel.text = section == 0 ? @"个人信息" : @"关于我们";
		return headerView;
	}else{
		return nil;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	if (section == 0 || section == 1) {
		return 44;
	}else{
		return 14;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	
	return section == 3 ? 14 : 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			[self changeHead];
		}
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 弹出框

//修改头像
- (void)changeHead{
	
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	alertController.view.tintColor = [UIColor lg_colorWithType:LGColor_theme_Color];
	__block UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
	imagePicker.delegate = self;
	imagePicker.allowsEditing = YES;
	
	[alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
		if ([LGTool checkDevicePermissions:LGDeviceCamera]) {
			imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
			[self.navigationController.tabBarController presentViewController:imagePicker animated:YES completion:nil];
		}
	}]];
	[alertController addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
		BOOL flag = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
		NSLog(@"%d",flag);
		[self.navigationController.tabBarController presentViewController:imagePicker animated:YES completion:nil];
		
	}]];
	[alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
	[self.navigationController.tabBarController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
	
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [LGProgressHUD showHUDAddedTo:self.view];
   [self.request uploadHeaderImage:image completion:^(id response, LGError *error) {
       if([self isNormal:error]){
           [LGUserManager shareManager].user.image = response[@"data"][@"photourl"];
           self.section_Array = nil;   //数据源 section_Array 的get方法重新初始化
           [self.tableView reloadData];
       }
       
   }];
	
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[picker dismissViewControllerAnimated:YES completion:nil];
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
