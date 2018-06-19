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
#import "LGUpdateUserInfoController.h"
#import "HSUpdateApp.h"

@interface LGPersonalInfoController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>



/**
 当为 nil 时重新初始化table数据源
 */
@property (nonatomic, strong) NSMutableArray<NSMutableArray<LGSettingModel*> *> *section_Array;


@end

@implementation LGPersonalInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"LGSettingHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LGSettingHeaderView"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//退出
- (IBAction)logoutAction:(id)sender {
	
	[[LGUserManager shareManager] logout];
	[[NSNotificationCenter defaultCenter] postNotificationName:SHOW_LOGIN_NOTIFICATION object:nil];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.section_Array = nil;
	[self.tableView reloadData];
}


#pragma mark - getter

- (NSMutableArray<NSMutableArray<LGSettingModel *> *> *)section_Array{
	if (!_section_Array) {
		
		/***************************  section 0  ***************************/
		
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
		
		/***************************  section 1  ***************************/
		
		NSMutableArray *section_2 = [NSMutableArray array];
		
		/* 暂时不要
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
		*/
		/***************************  section 2  ***************************/
		
		NSMutableArray *section_3 = [NSMutableArray array];
		for (int i = 0; i < 2; i++) {
			LGSettingModel *model = [LGSettingModel new];
			model.type = LGSettingMore;
			if (i == 0) {
				model.infoTitle = @"版本检测";
				model.info 		= [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
			}else{
				model.infoTitle = @"音效开关";
				model.info = @"";
			}
		 
			[section_3 addObject:model];
		}
		
		/***************************  section 3  ***************************/
		
		NSMutableArray *section_4 = [NSMutableArray array];
		LGSettingModel *model = [LGSettingModel new];
		model.type = LGSettingMore;
		model.infoTitle = @"字体大小";
		//model.info = [LGUserManager shareManager].user.fontSizeRate;
		model.info = @"";
		[section_4 addObject:model];
		
		_section_Array = [NSMutableArray arrayWithObjects:section_1,section_2,section_3,section_4, nil];
	}
	return _section_Array;
}


#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.section_Array.count; //4个 section ,第二个 section 信息已隐藏
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
	
	if (section == 0) {
		LGSettingHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LGSettingHeaderView"];
		headerView.titleLabel.text = @"个人信息";
		return headerView;
	}else{
		return nil;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	if (section == 0) {
		return 44;
	}else if(section == 1){
		return 0.1; // 隐藏 section 1
	}else{
		
		return 14;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	
	return section == 3 ? 14 : 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//隐藏了 section == 1
	
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			[self changeHead];
		}else if (indexPath.row == 2){
			[self performSegueWithIdentifier:@"settingToNickname" sender:nil];
		}else if (indexPath.row == 3){
            [self performSegueWithIdentifier:@"settingToUpdateInfo" sender:@(LGUpdatePhone)];
        }else if (indexPath.row == 4){
            [self performSegueWithIdentifier:@"settingToUpdateInfo" sender:@(LGUpdateEmail)];
        }else if (indexPath.row == 5){
            [self performSegueWithIdentifier:@"settingToUpdateInfo" sender:@(LGUpdatePassword)];
        }
	}else if (indexPath.section == 2){
		if (indexPath.row == 0) {
			[HSUpdateApp hs_updateWithAPPID:nil withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
				if (isUpdate) {
					[self showAlertViewTitle:@"" subTitle:[NSString stringWithFormat:@"检测到新版本%@,是否更新？",storeVersion] openUrl:openUrl];
				}else{
					[LGProgressHUD showMessage:@"当前已是最新版本" toView:self.view];
				}
			}];
		}else{
			[self performSegueWithIdentifier:@"settingToSound" sender:nil];
		}
		
	}else if (indexPath.section == 3){
		if (indexPath.row == 0) {
			[self performSegueWithIdentifier:@"settingToFont" sender:nil];
		}
	}
    
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- 版本检测
-(void)showAlertViewTitle:(NSString *)title subTitle:(NSString *)subTitle openUrl:(NSString *)openUrl{
	UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:subTitle preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		
	}];
	UIAlertAction *sure = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
		if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
			if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
				if (@available(iOS 10.0, *)) {
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl] options:@{} completionHandler:^(BOOL success) {
						
					}];
				}
			} else {
				BOOL success = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
				NSLog(@"Open  %d",success);
			}
			
		} else{
			bool can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:openUrl]];
			if(can){
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
			}
		}
	}];
	[alertVC addAction:cancel];
	[alertVC addAction:sure];
	[self presentViewController:alertVC animated:YES completion:nil];
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
           [LGUserManager shareManager].user.image = response[@"image"];
           self.section_Array = nil;   //数据源, section_Array 的get方法重新初始化
           [self.tableView reloadData];
       }
       
   }];
	
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"settingToUpdateInfo"]) {
        LGUpdateUserInfoController *controller = segue.destinationViewController;
        controller.type = ((NSNumber *)sender).integerValue;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
