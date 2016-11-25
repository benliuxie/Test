//
//  PhotoTest1Tests.m
//  PhotoTest1Tests
//
//  Created by Ben Liu on 2016-11-24.
//  Copyright © 2016 Ben Liu. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface PhotoTest1Tests : XCTestCase

@end

@implementation PhotoTest1Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testServerConnection {
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
    NSString *description = [NSString stringWithFormat:@"POST %@", url];

    XCTestExpectation *expectation = [self expectationWithDescription:description];

    if (!error) {
        // 4
        
        
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        request.HTTPBody = data;
        request.HTTPMethod = @"POST";
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

            XCTAssertNotNil(data, "data should not be nil");
            XCTAssertNil(error, "error should be nil");
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                XCTAssertEqual(httpResponse.statusCode, 200, @"HTTP response status code should be 200");
            } else {
                XCTFail(@"Response was not NSHTTPURLResponse");
            }
            [expectation fulfill];

            
        }];
        [postDataTask resume];
        
        [self waitForExpectationsWithTimeout:postDataTask.originalRequest.timeoutInterval handler:^(NSError *error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            }
            [postDataTask cancel];
        }];

        
    }
    
    
    
}



@end
