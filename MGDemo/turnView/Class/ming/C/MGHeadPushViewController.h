
//

#import "MGHeadPushViewController.h"

#import "MGHomeModel.h"

@interface MGHeadPushViewController : UIViewController

//headModel用来设置导航条的属性，在推荐页面push来时直接把headModel正向传值传来,需要注意这里重写set方法赋值的时
//当前控制器的navigationController是空的,无法修改导航条的属性
@property (nonatomic, strong) MGHomeModel *headModel;

/** 显示的tableView */
@property (nonatomic, strong) UITableView *tableView;

@end
