//
//  ViewController.m
//  SBRF-Swift+ObjC
//
//  Created by Artem Balashov on 15/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

#import "ViewController.h"
#import "SBRF_Swift_ObjC-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LinkedListObjC *list = [LinkedListObjC new]; // очень жаль что нелья строго типизировать
    [list append:@1];
    [list append:@2];
    NSLog(@"%@", list);
    NSLog(@"%ld", (long)list.count);
    NSLog(@"%@", [list elementAt:1]);
    // Do any additional setup after loading the view, typically from a nib.
}


@end
