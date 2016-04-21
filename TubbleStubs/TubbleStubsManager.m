#import "TubbleStubsManager.h"
#import <OHHTTPStubs/OHHTTPStubsUmbrella.h>

@implementation TubbleStubsManager

+ (void)load
{
    [self start];
}

+ (void)start
{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:@"http://jsonplaceholder.typicode.com/posts"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString *fixture = OHPathForFile(@"posts.json", self.class);
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
}

+ (void)stop
{
    [OHHTTPStubs removeAllStubs];
}

@end
