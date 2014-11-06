//
//  ViewController.m
//  ResizableCells
//
//  Created by Nordin on 04/11/14.
//  Copyright (c) 2014 Fennan Digital. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) DVChatCell *prototypeCell;

@end

@implementation ViewController

static NSString *ChatCellIdentifier = @"chatCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.tableView.estimatedRowHeight = 68.0;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// table delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ChatCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[DVChatCell class]])
    {
        //NSLog(@"Cell is of type DVChatCell");
        DVChatCell *textCell = (DVChatCell *)cell;
        //textCell.labelUser.text = [NSString stringWithFormat:@"Line %ld",(long)indexPath.row+1];
        //textCell.labelUser.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        
        //textCell.labelMessage.numberOfLines = 0;
        //textCell.labelMessage.lineBreakMode = NSLineBreakByWordWrapping;
        textCell.labelMessage.text = @"Note that we set the preferred font for the two labels each time we configure the cell in case the user has changed the text size.";
        //[textCell.labelMessage sizeToFit];
        //textCell.labelMessage.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    } else {
        NSLog(@"Cell is NOT of type DVChatCell");
    }
}

- (DVChatCell *)prototypeCell
{
    if (!_prototypeCell) {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:ChatCellIdentifier];
    }
    return _prototypeCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_prototypeCell)
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:ChatCellIdentifier];
    /*
    [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];

    [self.prototypeCell setNeedsLayout];
    [self.prototypeCell layoutIfNeeded];
    
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    */
    [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
    [self.prototypeCell layoutIfNeeded];
    [self.prototypeCell.labelMessage sizeToFit];
    float height = self.prototypeCell.labelMessage.frame.size.height;
    
    NSLog(@"Cell height: %f", height);
    return height+14;

    //NSLog(@"Cell height: %f", size.height);
    //return size.height;
    //return 120.0f;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self heightForBasicCellAtIndexPath:indexPath];
    //return 120.0;
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static DVChatCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:ChatCellIdentifier];
    });
    
    [self configureCell:sizingCell forRowAtIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}
*/

@end
