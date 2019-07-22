//
//  TaskCell.m
//  borbskeeper
//
//  Created by cassanene on 7/16/19.
//  Copyright © 2019 juliapark628. All rights reserved.
//

#import "TaskCell.h"
#import "User.h"
#import "Borb.h"
#import "GameConstants.h"

@implementation TaskCell
static NSString *const DATE_FORMAT = @"'Due' yyyy-MM-dd 'at' hh:mm a";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)didTapCheckbox:(id)sender {
    if (self.task.completed == NO){
        self.checkboxButton.selected = YES;
        [Task markTaskAsFinished:self.task];
        [User increaseUserCoins:[User currentUser] byCoins:COIN_REWARD_OPTOUT];
        
        [BorbParseManager fetchBorb:[User currentUser].usersBorb.objectId WithCompletion:^(NSMutableArray *borbs) {
            Borb *userBorb = borbs[0];
            [Borb increaseBorbExperience:userBorb byExperiencePoints:XP_GAINED_PER_COMPLETE_TASK];
            [BorbParseManager saveBorb:userBorb withCompletion:nil];
        }];

    } else {
        self.checkboxButton.selected = NO;
        [Task markTaskAsUnfinished:self.task];
        [User decreaseUserCoins:[User currentUser] byCoins:COIN_REWARD_OPTOUT];
        
        [BorbParseManager fetchBorb:[User currentUser].usersBorb.objectId WithCompletion:^(NSMutableArray *borbs) {
            Borb *userBorb = borbs[0];
            [Borb decreaseBorbExperience:userBorb byExperiencePoints:XP_GAINED_PER_COMPLETE_TASK];
            [BorbParseManager saveBorb:userBorb withCompletion:nil];
        }];
    }
    [BorbParseManager saveTask:self.task withCompletion:nil];
    [BorbParseManager saveUser:[User currentUser] withCompletion:nil];
}

- (void)setDataAtCellWithTask:(Task *)task {
    self.task = task;
    self.taskNameLabel.text = task.taskName;
    if (self.task.completed == YES){
        self.checkboxButton.selected = YES;
    } else {
        self.checkboxButton.selected = NO;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = DATE_FORMAT;
    self.dueDate.text = [dateFormatter stringFromDate:self.task.dueDate];
}

@end
