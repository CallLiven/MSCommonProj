//
//  MSTableViewController.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSViewController.h"
#import "MSTableViewModel.h"
#import "MSTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSTableViewController : MSViewController
/* tableView **/
@property (nonatomic, strong, readonly) MSTableView *tableView;
/* 内容缩进 默认是UIEdgeInsetsMake(64,0,0,0) **/
@property (nonatomic, assign, readonly) UIEdgeInsets contentInset;


/**
 reload tableView Data
 */
- (void)reloadData;



/**
 dequeueReusableCell

 @param tableView tableView
 @param identifier identifier
 @param indexPath indexPath
 */
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;




/**
 configure cell data

 @param cell cell
 @param indexPath indexPath
 @param object object
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;



@end

NS_ASSUME_NONNULL_END
