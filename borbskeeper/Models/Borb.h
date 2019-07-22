//
//  Borb.h
//  borbskeeper
//
//  Created by juliapark628 on 7/16/19.
//  Copyright © 2019 juliapark628. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface Borb : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *borbName;
@property (nonatomic, strong) NSNumber *borbHealth;
@property (nonatomic, strong) NSNumber *borbExperience;
@property (nonatomic, strong) NSNumber *borbLevel; 
@property (nonatomic, strong) PFFileObject *borbPicture;

+ (NSString *)parseClassName;

- (instancetype)initWithInitialStats;

+ (void)increaseBorbExperience:(Borb*)borb byExperiencePoints:(int)XP;

+ (void)decreaseBorbExperience:(Borb*)borb byExperiencePoints:(int)XP;

@end

NS_ASSUME_NONNULL_END
