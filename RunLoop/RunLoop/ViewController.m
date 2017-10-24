//
//  ViewController.m
//  RunLoop
//
//  Created by soliloquy on 2017/8/10.
//  Copyright © 2017年 soliloquy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     RunLoop实际上是一个对象，这个对象在循环中用来处理程序运行过程中出现的各种事件（比如说,触摸事件、UI刷新事件、定时器事件、Selector事件），从而保持程序的持续运行；而且在没有事件处理的时候，会进入睡眠模式，从而节省CPU资源，提高程序性能。
     
     
     1. 一条线程对应一个RunLoop对象，每条线程都有唯一一个与之对应的RunLoop对象。
     2. 我们只能在当前线程中操作当前线程的RunLoop，而不能去操作其他线程的RunLoop。
     3. RunLoop对象在第一次获取RunLoop时创建，销毁则是在线程结束的时候。
     4. 主线程的RunLoop对象系统自动帮助我们创建好了(原理如下)，而子线程的RunLoop对象需要我们主动创建。
     http://upload-images.jianshu.io/upload_images/1877784-6ab632fc118e31f3.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
     
     从上图中可以看出，RunLoop就是线程中的一个循环，RunLoop在循环中会不断检测，通过Input sources（输入源）和Timer sources（定时源）两种来源等待接受事件；然后对接受到的事件通知线程进行处理，并在没有事件的时候进行休息。
    RunLoop原理:
     http://upload-images.jianshu.io/upload_images/1877784-94c6cdb3a7864593.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240
     */
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self runloopDemo2];
}

- (void)runloopDemo2 {
     // 创建观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"监听到RunLoop发生改变---%zd",activity);
    });
    // 添加观察者到当前RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    // 释放observer，最后添加完需要释放掉
    CFRelease(observer);
}

- (void)runloopDemo1 {
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(run:) userInfo:nil repeats:YES];
//    / 将定时器添加到当前RunLoop的NSDefaultRunLoopMode下
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)run:(NSTimer *)timer {
     NSLog(@"---run");
}


@end
