//
//  main.m
//  WLUserPackagePodspecEdit
//
//  Created by three stone 王 on 2019/4/11.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}


@protocol WLPrototcol <NSObject>

@property (nonatomic ,copy ,readonly) NSString *name;

@end

@interface WLProtocolImpl: NSObject <WLPrototcol>


@end

@implementation WLProtocolImpl


- (NSString *)name {
    
    return @"王磊";
}
@end
