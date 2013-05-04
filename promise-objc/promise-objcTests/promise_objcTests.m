//
//  promise_objcTests.m
//  promise-objcTests
//
//  Created by nilfs on 13/05/04.
//  Copyright (c) 2013年 nilfs. All rights reserved.
//

#import "promise_objcTests.h"
#import "NIPromise.h"

@implementation promise_objcTests

-(void)hoge2:(NSNumber*)i :(NSNumber*)j
{
    NSLog(@"hoge2 %d %d", [i intValue], [j intValue]);
}

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NIPromise* promise = [NIPromise new];
    [promise then:self withSelector:@selector(hoge2::)];
    [promise resolveWithResult:[NSNumber numberWithInt:1000], [NSNumber numberWithInt:2000], nil];
    [promise then:self withSelector:@selector(hoge2::)];    
}

@end
