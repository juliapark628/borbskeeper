//
//  AddFriendsViewController.m
//  borbskeeper
//
//  Created by juliapark628 on 7/26/19.
//  Copyright © 2019 juliapark628. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "BorbParseManager.h"
#import "User.h"
#import "FriendRequest.h"
#import "AlertManager.h"

@interface AddFriendsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;


@end

@implementation AddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapCancel:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapAdd:(id)sender {
    if ([self.userNameTextField.text isEqualToString:[User currentUser].username]){
        [AlertManager presentRequestToSelfAlert:self];
        
    } else {
        [BorbParseManager fetchUser:self.userNameTextField.text withCompletion:^(User *recipient) {
            if (recipient == nil){
                [AlertManager presentCannotFindUserAlert:self];
                
            } else {
                [BorbParseManager fetchFriendRequestFrom:[User currentUser] withRecipient:recipient withCompletion:^(BOOL friendRequestFound) {
                    if (friendRequestFound){
                        [AlertManager presentRequestAlreadyExistsAlert:self];
                        
                    } else {
                        FriendRequest *newRequest = [FriendRequest createFriendRequestWithSender:[User currentUser] withRecipient:recipient];
                        [BorbParseManager saveFriendRequest:newRequest withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                            if (!succeeded){
                                [AlertManager presentRequestNotSavedAlert:self];
                            }
                        }];
                    }
                }];
            }
        }];
    }
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