//
//  SignUpViewController.m
//  borbskeeper
//
//  Created by rodrigoandrade on 7/16/19.
//  Copyright © 2019 juliapark628. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation SignUpViewController

static NSString *const SUCCESSFUL_SIGNUP_ALERT_TITLE = @"Signup Successful";
static NSString *const SUCCESSFUL_SIGNUP_ALERT_MESSAGE = @"Please login with your new account.";
static NSString *const UNSUCCESSFUL_SIGNUP_ALERT_TITLE = @"Signup not successful";
static NSString *const UNSUCCESSFUL_SIGNUP_ALERT_MESSAGE = @"Please try signing up again.";
static NSString *const OK_ACTION_TITLE = @"OK";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)registerUser {
    UIAlertController *signUpSuccessAlert = [UIAlertController alertControllerWithTitle:SUCCESSFUL_SIGNUP_ALERT_TITLE
                                                                                message:SUCCESSFUL_SIGNUP_ALERT_MESSAGE
                                                                         preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:OK_ACTION_TITLE
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                     }];
    [signUpSuccessAlert addAction:okAction];
    
    UIAlertController *signUpNotSuccessfulAlert = [UIAlertController alertControllerWithTitle:UNSUCCESSFUL_SIGNUP_ALERT_TITLE
                                                                                      message:UNSUCCESSFUL_SIGNUP_ALERT_MESSAGE
                                                                               preferredStyle:(UIAlertControllerStyleAlert)];
    [signUpNotSuccessfulAlert addAction:okAction];
    
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameField.text;
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;

    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            [self presentViewController:signUpNotSuccessfulAlert animated:YES completion:nil];
        } else {
            [self presentViewController:signUpSuccessAlert animated:YES completion:nil];
        };
    }];
}

- (IBAction)didTapSignUp:(id)sender {
    [self registerUser];
}
- (IBAction)didTapLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapSignUpView:(id)sender {
    [self.view endEditing:YES];
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
