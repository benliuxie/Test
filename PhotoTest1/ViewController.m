//
//  ViewController.m
//  PhotoTest1
//
//  Created by Ben Liu on 2016-11-24.
//  Copyright © 2016 Ben Liu. All rights reserved.
//

#import "ViewController.h"
#import "PhotoNameTableViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *user;
@property (weak, nonatomic) IBOutlet UILabel *contact;

@property (strong, nonatomic) NSArray *photos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *user = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"user"];
    
    NSString *contact = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"contact"];
    
    self.user.text = user;
    self.contact.text = contact;
    
    NSLog(@"user %@ contact %@", user, contact);
    
    [self login];
    
}


- (void)login{
    NSURL *url = [NSURL URLWithString:@"http://mobilelive.getsandbox.com/users/login"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 3
    NSDictionary *dictionary = @{@"username": @"userben", @"password" : @"userliu"};
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:kNilOptions error:&error];
    
    if (!error) {
        // 4
        
        __weak ViewController *weakSelf = self;
        
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];

        request.HTTPBody = data;
        request.HTTPMethod = @"POST";
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString* responseStr = [NSString stringWithUTF8String:[data bytes]];
            NSLog(@"response: %@",  responseStr);

            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];
            NSString *cookie = [fields valueForKey:@"Set-Cookie"];
            
            [weakSelf getPhotosWithCookie:cookie];

        }];
        [postDataTask resume];
        
    }
}


- (void)getPhotosWithCookie:(NSString*)cookie{
    
    NSURL *url = [NSURL URLWithString:@"http://mobilelive.getsandbox.com/v2/photos"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    // 3
    NSError *error = nil;
    __weak ViewController *weakSelf = self;

    if (!error) {
        // 4
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request addValue:cookie forHTTPHeaderField:@"Cookie"];
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:kNilOptions
                                                                           error:&error];
            NSLog(@"getPhotos response: %@ count %d",  jsonResponse, (int)jsonResponse.count);
            
            [weakSelf parseResponse:jsonResponse];
        }];
        [postDataTask resume];
        
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PhotoNameTableViewController     *destViewController = segue.destinationViewController;
    
    destViewController.photos = self.photos;
}


- (void)parseResponse:(NSDictionary*)response{
    NSArray *images = [response allValues];
    for(NSDictionary *dic in images){
        NSLog(@"name %@ data %@", dic[@"name"], dic[@"data"]);
    }
    self.photos = images;
    [self performSegueWithIdentifier:@"photoNames" sender:self];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
