//
//  PhotoDetailViewController.m
//  PhotoTest1
//
//  Created by Ben Liu on 2016-11-24.
//  Copyright © 2016 Ben Liu. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *photoLabel;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoLabel.text = self.photoDescription;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
