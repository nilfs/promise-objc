//
//  NIPromise.h
//  promise-objc
//
//  Created by nilfs on 13/05/04.
//  Copyright (c) 2013年 nilfs. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  http://blog.jcoglan.com/2013/03/30/callbacks-are-imperative-promises-are-functional-nodes-biggest-missed-opportunity/
 */
@interface NIPromise : NSObject

-(NIPromise*)then:(id)obj withSelector:(SEL)callback;
-(NIPromise*)then:(id)callback withError:(id)error;
-(NIPromise*)resolveWithResult:(id)result, ... NS_REQUIRES_NIL_TERMINATION;
-(NIPromise*)reject:(id)error;

@end
