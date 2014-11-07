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
    
    [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
    [self.prototypeCell layoutIfNeeded];
    [self.prototypeCell.labelMessage sizeToFit];

    float cellHeight = self.prototypeCell.frame.size.height;
    float labelHeight = self.prototypeCell.labelMessage.frame.size.height;
    //float height = (labelHeight - cellHeight)/2+labelHeight;
    float height = labelHeight;//+cellHeight/2;
    
    NSLog(@"Cell height: %f", height);
    return height;
}



@end
