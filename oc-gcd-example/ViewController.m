//
//  ViewController.m
//  oc-gcd-example
//
//  Created by 张亚瀚 on 2023/2/10.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    dispatch_sync(dispatch_get_global_queue(0, 0), ^ {
        NSLog(@"thread running dispatch_sync");
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^ {
        NSLog(@"thread running dispatch_async");
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            NSLog(@"主线程方法");
        });
        
        dispatch_barrier_sync(dispatch_get_main_queue(), ^ {
            NSLog(@"主线程方法");
        });
    });
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create(0, 0);
    
    dispatch_group_async(group, queue, ^ {});
    dispatch_group_async(group, queue, ^ {});
    dispatch_group_async(group, queue, ^ {});
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{});
}


@end
