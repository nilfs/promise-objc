//
//  NIPromise.m
//  promise-objc
//
//  Created by nilfs on 13/05/04.
//  Copyright (c) 2013年 nilfs. All rights reserved.
//

#import "NIPromise.h"

@interface NIMethod : NSObject

@property(nonatomic, strong)id receiver;
@property(nonatomic, strong)NSValue* funcPointer;

@end

@implementation NIMethod

@end

@interface NIPromise()

@property(nonatomic, strong)NSMutableArray* selectorCallbacks;
@property(nonatomic, strong)NSArray* results;
@property(nonatomic, strong)id error;

@end

@implementation NIPromise

-(id)init
{
    self = [super init];
    if( self )
    {
        _selectorCallbacks = [NSMutableArray array];
    }
    
    return self;
}

-(NIPromise *)then:(id)obj withSelector:(SEL)callback
{
    NSMethodSignature* signature = [obj methodSignatureForSelector:callback];
    if( signature )
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setSelector:callback];
        [invocation setTarget:obj];
                
        [_selectorCallbacks addObject:invocation];
        
        [self _exec];
    }
    else
    {
        NSLog(@"error invalid selector");
    }
    return self;
}

-(NIPromise *)resolveWithResult:(id)result, ...
{
    if( _results )
    {
        NSLog(@"warning resolved promise...");
    }
    else
    {
        NSMutableArray* argArray = [NSMutableArray array];
        va_list args;
        va_start( args, result );
        id arg = result;
        for (int i=2; arg != nil; i++) {
            [argArray addObject:arg];
            arg = va_arg(args, id);
        }
        va_end( args );
        
        _results = argArray;
    }
    
    [self _exec];
    return self;
}

-(NIPromise *)reject:(id)error
{
    _error = error;
    return self;
}

-(void)_exec
{
    if( 0 < _selectorCallbacks.count )
    {
        if( _error )
        {
            NSLog(@"not impl error callback");
        }
        else if( _results )
        {
            for ( NSInvocation* invocation in _selectorCallbacks ) {
                
                int argIndex = 2;
                for( id result in _results )
                {
                    [invocation setArgument:(void*)&result atIndex:argIndex];
                    ++argIndex;
                }
                [invocation invoke];
            }
            
            [_selectorCallbacks removeAllObjects];
        }
    }
    else
    {
        // まだ揃っていないので実行しない
    }
}

@end
