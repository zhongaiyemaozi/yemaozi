# QQ
#空余时间做了一个QQ框架

##做了很多效果,若你需要可以直接移植走,请不要忘记点赞啊
**QQ**是无聊的自己搭的一个框架,并且里面的效果都对齐进行了封装,特点概述：

- **首先登陆效果**:内部做了网络判断,一个效果图,内部需要随意可以更改,以封装;

![image](https://github.com/zhongaiyemaozi/TallQQ-QQ/blob/master/QQ/Gif/start.gif)
### 代码块
``` python
self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

//设置window的根控制器
self.window.rootViewController = [[YFLoginTransitionViewController alloc] init];

[self.window makeKeyAndVisible];

```
- **侧滑效果**:仿QQ做了一个侧滑效果,已经对内部做了判断,在主页面进行了push后侧滑效果手势自动删除,并且进行了封装;

![image](https://github.com/zhongaiyemaozi/TallQQ-QQ/blob/master/QQ/Gif/sideslip.gif)

### 代码块
``` python
QQLeftViewController *leftVC = [[QQLeftViewController alloc] init];
QQMainViewController *rightVC = [[QQMainViewController alloc] init];

QQSliderViewController *controller = [[QQSliderViewController alloc]initWithLeftVC:leftVC andRightVC:rightVC];

controller.transitioningDelegate = self;

[self presentViewController:controller animated:YES completion:nil];

```
- **搜索框效果**:若你的项目需要搜索框,直接可以移植走,进行了封装;

![image](https://github.com/zhongaiyemaozi/TallQQ-QQ/blob/master/QQ/Gif/%20search.gif)
### 代码块
``` python

self.tableView.tableHeaderView = self.searchController.searchBar;
self.searchController.searchResultsUpdater = self;

#pragma mark - 搜索框
- (UISearchController *)searchController
{
if (!_searchController) {
QQSearchResultsTableViewController *searchResultsViewController = [[QQSearchResultsTableViewController alloc] init];
_searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsViewController]; // 传入nil表示使用当前控制器
_searchController.searchBar.frame = CGRectMake(0, 0, 200, 44);
_searchController.searchBar.placeholder = @"搜索号码";
}
return _searchController;
}


#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
// 创建临时数组，存放搜索到的内容
NSMutableArray *tempArray = [NSMutableArray array];
NSString *text = searchController.searchBar.text;
for (QQMessage *item in _TwodataList) {
if (text.length != 0 && [item.name containsString:text]) {
[tempArray addObject:item.name];
}
}

// 给searchResultViewController进行传值，并且reloadData
QQSearchResultsTableViewController *searchResultsViewController = (QQSearchResultsTableViewController *)searchController.searchResultsController;
searchResultsViewController.tableView.frame = CGRectMake(0, 64, YFScreen.width, YFScreen.height - 64);
searchResultsViewController.searchDataArray = [NSMutableArray arrayWithArray:tempArray];
[searchResultsViewController.tableView reloadData];
}

```
- **聊天界面**:进行了高仿QQ的聊天界面,每个人一句话,并且对此增加了自动回复,而且进行了封装,并且聊天界面的键盘也进行了高度封装,可以自己加入需要的表情,大概我增加了两个类的表情,都可以使用,类中做了判断,并且使用起来很简单;

![image](https://github.com/zhongaiyemaozi/TallQQ-QQ/blob/master/QQ/Gif/reply.gif)
### 代码块
``` python
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

[tableView deselectRowAtIndexPath:indexPath animated:YES];

QQChatViewController *chat = [[QQChatViewController alloc]init];

[self.navigationController pushViewController:chat animated:YES];

}

```
- **相册类效果**:聊天界面右上角进行了对扫一扫功能进行优化,可以进行访问相机进行扫一扫,并且还可以访问本机相册的二维码,还能在扫一扫相机页面打开闪光灯;

![image](https://github.com/zhongaiyemaozi/TallQQ-QQ/blob/master/QQ/Gif/photo.gif)
### 代码块
``` python

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

if (indexPath.section == 0) {

// 1、 获取摄像设备
AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
if (device) {
AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
if (status == AVAuthorizationStatusNotDetermined) {
[AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
if (granted) {
dispatch_async(dispatch_get_main_queue(), ^{
SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
[self.navigationController pushViewController:scanningQRCodeVC animated:YES];
NSLog(@"主线程 - - %@", [NSThread currentThread]);
});
NSLog(@"当前线程 - - %@", [NSThread currentThread]);

// 用户第一次同意了访问相机权限
NSLog(@"用户第一次同意了访问相机权限");

} else {

// 用户第一次拒绝了访问相机权限
NSLog(@"用户第一次拒绝了访问相机权限");
}
}];
} else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
[self.navigationController pushViewController:scanningQRCodeVC animated:YES];
} else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
[alertView show];
} else if (status == AVAuthorizationStatusRestricted) {
NSLog(@"因为系统原因, 无法访问相册");
}
} else {
SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头, 请在真机上测试" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
[alertView show];
}


}else {
//取消选中状态
[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
QQCommonViewController *commonVC = [[QQCommonViewController alloc]init];

[self.navigationController pushViewController:commonVC animated:YES];

}

}
```
- **联系人页面添加效果**:联系人右上角跳转到添加,进行了布局效果,可以进行滑动,也可以根据自己的需求添加内容;

![image](https://github.com/zhongaiyemaozi/TallQQ-QQ/blob/master/QQ/Gif/ScrollView.gif)
### 代码块
``` python

#pragma mark - 右上角添加的点击事件
- (void)rightToVC {

QQAddAnyViewController *addAny = [[QQAddAnyViewController alloc]init];

[self.navigationController pushViewController:addAny animated:YES];

}
```
- **好友动画**:好友动画页面对大概布局做了一个整理,里面主要目前添加了电话本和小画板的两个小功能;

- **电话本**:电话本对数据进行了实例化,并且可以随便跳转,保存并修改数据
![image](https://github.com/zhongaiyemaozi/TallQQ-QQ/blob/master/QQ/Gif/photo.gif)
### 代码块
``` python
QQPhoneTableViewController *phoneVC = [[QQPhoneTableViewController alloc]init];

[self.navigationController pushViewController:phoneVC animated:YES];

```
- **小画板**:小画板可以根据自己的要求,粗细颜色都集成,当然颜色不够自己还可以再加,而且保存可以把屏幕进行截屏保存到你的相册.
### 代码块
``` python
UIStoryboard *SB = [UIStoryboard storyboardWithName:@"CXLDrawViewController" bundle:nil];

UIViewController *drawVC = [SB instantiateInitialViewController];

[self.navigationController pushViewController:drawVC animated:YES];

```

##关于功能
后续有时间会继续增加功能,尽请期待!




## 反馈与建议
- 邮箱：<873456034@qq.com>

---------
感谢阅读这份帮助文档。请点击右上角，点赞并分享。
