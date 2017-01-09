//
//  FXNationTableViewCell.h
//  Football-X
//
//  Created by Hoang Dang Trung on 12/27/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface FXNationTableViewCell : BaseTableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imgFlag;
@property (nonatomic, weak) IBOutlet UILabel *lbNation;

@end
