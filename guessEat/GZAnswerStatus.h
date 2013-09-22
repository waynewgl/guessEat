//
//  GZAnswerStatus.h
//  guessEat
//
//  Created by Guiwei LIN on 9/17/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GZAnswerStatus : NSObject


@property (nonatomic, strong) NSNumber *ans_btn_tag;
@property (nonatomic, assign) Boolean ans_to_filled;
@property (nonatomic, strong) NSString *ans_content;

@end
