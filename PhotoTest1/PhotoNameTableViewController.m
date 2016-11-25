//
//  PhotoNameTableViewController.m
//  PhotoTest1
//
//  Created by Ben Liu on 2016-11-24.
//  Copyright © 2016 Ben Liu. All rights reserved.
//

#import "PhotoNameTableViewController.h"
#import "PhotoDetailViewController.h"


static NSString *CellIdentifier = @"photoCell";

@interface PhotoNameTableViewController ()

@end

@implementation PhotoNameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *dict = [self.photos objectAtIndex:indexPath.row];
    cell.textLabel.text = (NSString*)dict[@"name"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = [self.photos objectAtIndex:indexPath.row];
    
    NSString *data = (NSString*)dict[@"data"];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PhotoDetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"photoDetails"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    vc.photoDescription = data;
    [self presentViewController:vc animated:YES completion:NULL];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
