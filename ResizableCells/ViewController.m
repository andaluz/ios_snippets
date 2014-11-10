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
        DVChatCell *textCell = (DVChatCell *)cell;

        textCell.labelMessage.text = @"Note that we set the preferred font for the two labels each time we configure the cell in case the user has changed the text size. And this is a much longer message :)";
        //textCell.labelMessage.text = @"Note that we set the preferred font for the two labels each time we configure the cell in case the user has changed the text size.";
        //textCell.labelMessage.text = @"Een kort bericht.";
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
    [self.prototypeCell.labelMessage sizeToFit];
    [self.prototypeCell.labelUser sizeToFit];
    [self.prototypeCell layoutIfNeeded];
    [self.prototypeCell sizeToFit];

    //float cellHeight = self.prototypeCell.frame.size.height;
    float cellHeight = self.prototypeCell.contentView.frame.size.height;
    float labelUserHeigth = self.prototypeCell.labelUser.frame.size.height;
    float labelMessgeHeight = self.prototypeCell.labelMessage.frame.size.height;
    
    float height = labelMessgeHeight+labelUserHeigth+[self getDifferenceHeightOfMessage:labelMessgeHeight
                                                                                 ofUser:labelUserHeigth
                                                                                andCell:cellHeight];
    
    NSLog(@"Cell height: %f", height);
    return height;
    
    //CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //return size.height;
}

- (float) getDifferenceHeightOfMessage: (float) msg ofUser: (float) user andCell: (float) cell {
    float diff = 0;
    float content = msg+user;
    
    if(content>cell) {
        diff = content - cell;
    } else {
        diff = cell-content;
    }
    
    //diff = cell;
    
    return diff-8;
}


@end
