//
//  LoginViewController.m
//  NowExerciseipad
//
//  Created by mac on 16/10/26.
//  Copyright © 2016年 Guodong. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>


@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WINDOW_backgroundColor;
    
    [self createUI];

    // Do any additional setup after loading the view from its nib.
}
- (void)createUI{
    
    _iconImageV = [[UIImageView alloc]init];
    _nameTF = [[UITextField alloc]init];
    _passwordTF = [[UITextField alloc]init];
    _LoginBtn = [[UIButton alloc]init];
    _nameTF.delegate = self;
    _passwordTF.delegate = self;

    _iconImageV.layer.cornerRadius = 80.0;
    _iconImageV.layer.masksToBounds = YES;
    _iconImageV.image = [UIImage imageNamed:@"icon.png"];
    
    _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _nameTF.backgroundColor = WINDOW_backgroundColor;
    _nameTF.clearsOnBeginEditing = YES;
    _nameTF.borderStyle = UITextBorderStyleBezel;
    _nameTF.layer.borderWidth = 2.0;
    _nameTF.layer.borderColor = LOGINVIEW_COLEOR.CGColor;
    _nameTF.layer.cornerRadius = 25.0;
    _nameTF.layer.masksToBounds = YES;
    _nameTF.textColor = LOGINVIEW_COLEOR;
    _nameTF.placeholder = @"账号";
    [_nameTF setValue:LOGINVIEW_COLEOR forKeyPath:@"_placeholderLabel.textColor"];
    

    
    UIButton * btn = [_nameTF valueForKey:@"_clearButton"];
    [btn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    _nameTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    _nameTF.leftViewMode = UITextFieldViewModeAlways;
    
    _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _passwordTF.backgroundColor = WINDOW_backgroundColor;
    _passwordTF.clearsOnBeginEditing = YES;
    _passwordTF.borderStyle = UITextBorderStyleBezel;
    _passwordTF.layer.borderWidth = 2.0;
    _passwordTF.layer.borderColor = LOGINVIEW_COLEOR.CGColor;
    _passwordTF.layer.cornerRadius = 25.0;
    _passwordTF.layer.masksToBounds = YES;
    _passwordTF.textColor = [UIColor whiteColor];
    _passwordTF.placeholder = @"密码";
    [_passwordTF setValue:LOGINVIEW_COLEOR forKeyPath:@"_placeholderLabel.textColor"];
    _passwordTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"登 录"];
    NSRange titleRange = {0,[title length]};

    [title addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0],NSForegroundColorAttributeName:[UIColor orangeColor],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:titleRange];
    
    [_LoginBtn setAttributedTitle:title forState:UIControlStateNormal];
    [_LoginBtn addTarget:self action:@selector(Btnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:_iconImageV];
    [self.view addSubview:_nameTF];
    [self.view addSubview:_LoginBtn];
    [self.view addSubview:_passwordTF];
    
    
    [self uploadUI];
    
    
}
- (void)uploadUI{
    [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(-180);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(160);

    }];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.centerX.mas_equalTo(0);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(280.0, 50));

    }];
    
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(0);
        make.centerY.offset(80.0);
        make.size.mas_equalTo(CGSizeMake(280.0, 50.0));
        
    }];
    
    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(0);
        make.centerY.offset(160.0);
        make.size.mas_equalTo(CGSizeMake(80.0, 50.0));

        
        
        
    }];
}
#pragma mark 文本框代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    
    self.view.frame = CGRectMake(0, - 120, UISCREEN_W, UISCREEN_H);
}
- (void)keyboardWillHide:(NSNotification *)noti{
    [_nameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
}
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateFocusIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
        
    }];
}

#pragma mark 登录按钮
- (void)Btnclick:(UIButton *)btn{
    
    NSString *url = [NSString stringWithFormat:@"%@gdlogin/?number=%@&passwd=%@",BASEURL,_nameTF.text,[_passwordTF.text MD5]];

    
    
    [HttpRequest PostHttpwithUrl:url andparameters:nil andProgress:^(NSProgress * progress) {
        
        
        
    } andsuccessBlock:^(NSData *data) {
        if (data) {
            
        }
        
        
    } andfailBlock:^(NSError *error) {
        
        
        
        
    }];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];

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
