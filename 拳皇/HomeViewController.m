
#import "HomeViewController.h"
#define w [UIScreen mainScreen].bounds.size.width
#define h [UIScreen mainScreen].bounds.size.height
@interface HomeViewController ()
{
    UIScrollView *scroll;
    UIPageControl *page;
    NSTimer *myTimer;
    int index;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    index = 0;
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, w, h-50)];
    for (int i=0; i<=25; i++) {
        NSString *name = [NSString stringWithFormat:@"%02d.png",i];
        UIImage *img = [UIImage imageNamed:name];
        UIImageView *view = [[UIImageView alloc]initWithImage:img];
        view.frame = CGRectMake(i*w, 0, w, h);
        [scroll addSubview:view];
    }
    scroll.contentSize= CGSizeMake(26*w, h);
    scroll.scrollEnabled = NO;
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scroll];
    //
    page = [[UIPageControl alloc]initWithFrame:CGRectMake(100, 600, 350, 40)];
    page.numberOfPages=25;
    page.currentPage=0;
    //  开始左不可点
    self.aa.userInteractionEnabled = NO;
    [self.aa setTitle:@"不可" forState:UIControlStateNormal];
    //
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(action:) userInfo:page repeats:YES];
    //停止定时器
    myTimer.fireDate = [NSDate distantFuture];
}


- (IBAction)a:(UIButton *)sender {
    page.currentPage--;
    NSLog(@"%ld",(long)page.currentPage);
    //
    self.bb.userInteractionEnabled = YES;
    [self.bb setTitle:@"可" forState:UIControlStateNormal];
    //
    if (page.currentPage == 0) {
        self.aa.userInteractionEnabled = NO;
        [self.aa setTitle:@"不可" forState:UIControlStateNormal];
    }
    [scroll setContentOffset:CGPointMake(page.currentPage*w, 0)];
    
}

- (IBAction)b:(UIButton *)sender {
    page.currentPage++;
    NSLog(@"%ld",(long)page.currentPage);
    //
    self.aa.userInteractionEnabled = YES;
    [self.aa setTitle:@"可" forState:UIControlStateNormal];
    //
    if (page.currentPage == page.numberOfPages-1) {
        self.bb.userInteractionEnabled = NO;
        [self.bb setTitle:@"不可" forState:UIControlStateNormal];
    }
    [scroll setContentOffset:CGPointMake(page.currentPage*w, 0)];
}

- (IBAction)cc:(UIButton *)sender {
    //
    //
    if (page.currentPage == page.numberOfPages-1)
    {
        self.aa.userInteractionEnabled = YES;
        [self.aa setTitle:@"可" forState:UIControlStateNormal];
        self.bb.userInteractionEnabled = NO;
        [self.bb setTitle:@"不可" forState:UIControlStateNormal];
    }
    else
    {
        self.aa.userInteractionEnabled = YES;
        [self.aa setTitle:@"可" forState:UIControlStateNormal];
        self.bb.userInteractionEnabled = YES;
        [self.bb setTitle:@"可" forState:UIControlStateNormal];
    }
    //
    //
    if (index == 0) {
        // 启动定时器
        myTimer.fireDate = [NSDate distantPast];
        index = 1;
        [self.cc setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else if (index == 1)
    {
        //停止定时器
        myTimer.fireDate = [NSDate distantFuture];
        [self.cc setTitle:@"继续" forState:UIControlStateNormal];
        index = 2;
    }
    else if (index == 2)
    {
        //继续。
        [myTimer setFireDate:[NSDate date]];
        [self.cc setTitle:@"暂停" forState:UIControlStateNormal];
        index = 1;
    }
    else if (index == 3)
    {
        // 启动定时器
        myTimer.fireDate = [NSDate distantPast];
        index = 1;
        [self.cc setTitle:@"暂停" forState:UIControlStateNormal];
        //
        if (page.currentPage == page.numberOfPages-1) {
            page.currentPage = 0;
            self.bb.userInteractionEnabled = YES;
            [self.bb setTitle:@"可" forState:UIControlStateNormal];
            self.aa.userInteractionEnabled = YES;
            [self.aa setTitle:@"可" forState:UIControlStateNormal];
        }
        //page.currentPage = 0;
    }
}


- (void)action:(NSTimer *)timer{
    page = timer.userInfo;
    page.currentPage++;
    [scroll setContentOffset:CGPointMake(page.currentPage*w, 0)];
    if (page.currentPage == page.numberOfPages-1) {
        //停止定时器
        myTimer.fireDate = [NSDate distantFuture];
        [self.cc setTitle:@"重新播放" forState:UIControlStateNormal];
        index = 3;
        //
        self.bb.userInteractionEnabled = NO;
        [self.bb setTitle:@"不可" forState:UIControlStateNormal];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [myTimer invalidate];
    myTimer = nil;
}

@end
