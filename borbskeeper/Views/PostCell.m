//
//  PostCell.m
//  borbskeeper
//
//  Created by juliapark628 on 7/29/19.
//  Copyright © 2019 juliapark628. All rights reserved.
//

#import "PostCell.h"
#import "DateTools.h"
#import "UIImageView+AFNetworking.h"

@implementation PostCell

static NSString *const USER_PROF_PIC_KEY = @"profilePicture";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithPost:(Post *)post {
    self.post = post;
    
    self.usernameLabel.text = post.author.username;
    self.datePostedLabel.text = [post.updatedAt timeAgoSinceNow];
    self.taskNameLabel.text = post.task.taskName;
    
    PFFileObject *profileImageFile = post.author[USER_PROF_PIC_KEY];
    NSURL *profileImageURL = [NSURL URLWithString:profileImageFile.url];
    [self.profilePhotoImageView setImageWithURL:profileImageURL];
    
    PFFileObject *userImageFile = post.image;
    NSURL *imageURL = [NSURL URLWithString:userImageFile.url];
    [self.photoImageView setImageWithURL:imageURL];
}


@end