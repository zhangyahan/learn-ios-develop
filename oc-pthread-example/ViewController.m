//
//  ViewController.m
//  oc-pthread-example
//
//  Created by 张亚瀚 on 2023/2/10.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    pthread_t pthread;
//    NSString *name = @"张三";
//
//    int result = pthread_create(&pthread, NULL, run, (__bridge void *) name);
//    NSLog(@"thread exec result is %d", result);
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];
    [thread start];
    
    [self performSelectorInBackground:@selector(demo) withObject:nil];
}

- (void) demo {
    NSLog(@"running in thread...");
}

//void *run(void *param) {
//    NSString *name = (__bridge NSString *)param;
//    NSLog(@"running in thread... my name is %@", name);
//    return NULL;
//}
@end
