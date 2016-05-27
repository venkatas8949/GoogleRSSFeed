//
//  TableViewCell.h
//  A&F
//
//  Created by Sresty Theegela on 5/25/16.
//  Copyright © 2016 icc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageThumb;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;


@end
