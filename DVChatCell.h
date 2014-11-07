//
//  DVChatCell.h
//  ResizableCells
//
//  Created by Nordin on 04/11/14.
//  Copyright (c) 2014 Fennan Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVChatCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *labelUser;
@property (nonatomic, weak) IBOutlet UILabel *labelTimestamp;
@property (nonatomic, weak) IBOutlet UILabel *labelMessage;

@end
