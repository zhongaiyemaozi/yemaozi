//
//  QQChatViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/19.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQChatViewController.h"
#import "QQChatMeCell.h"
#import "QQChatOtherCell.h"
#import "YYKit.h"
#import "YHExpressionKeyboard.h"
#import "QQMessageViewController.h"

@interface QQChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,YHExpressionKeyboardDelegate>

@property (nonatomic, strong) NSDictionary *autoreply;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSString *lastTime;

@property (nonatomic, strong) NSMutableArray *chatData;

@property (nonatomic, strong) YHExpressionKeyboard *v;


@end

static NSString *chatMeCellID = @"chatMe_cell";
static NSString *chatOtherCellID = @"chatOther_cell";

@implementation QQChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chatData = [self loadChatData];

    
}


#pragma mark - 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.chatData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQChat *chat = self.chatData[indexPath.row];
    if (chat.type == QQChatTypeMe) {
        QQChatMeCell *cell = [tableView dequeueReusableCellWithIdentifier:chatMeCellID forIndexPath:indexPath];
        cell.chat = chat;
        return cell;
    }else {
        
        QQChatOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:chatOtherCellID forIndexPath:indexPath];
        cell.chat = chat;
        return cell;
        
    }
 
}


#pragma mark - 页面搭建
- (void)setupUI {
    
    self.navigationController.navigationBar.translucent = NO;

    self.navigationItem.title = @"夜猫子";
    
    //MARK: tableView创建
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    tableView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+64);
    [self.view addSubview:tableView];
    
    //遵守协议和代理
    tableView.dataSource = self;
    tableView.delegate = self;
    
    self.tableView = tableView;
    //注册cell
    [tableView registerClass:[QQChatMeCell class] forCellReuseIdentifier:chatMeCellID];
    [tableView registerClass:[QQChatOtherCell class] forCellReuseIdentifier:chatOtherCellID];
    
    //进度条取消
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    //设置行高的问题
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60;

    YHExpressionKeyboard *v = [[YHExpressionKeyboard alloc]initWithViewController:self aboveView:tableView];
    _v = v;
    [self.view addSubview:v];
    
    //滚动tanbleView键盘叫回
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}


#pragma mark - 加载聊天数据
- (NSMutableArray *)loadChatData{
    
    NSArray *data = [NSArray objectListWithPlistName:@"messages.plist" clsName:@"QQChat"];
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:data];
    
    NSString *tempTime = [data[0] time];
    for (NSInteger i = 0; i < data.count; i++) {
        
        if ([[arrM[i] time] isEqualToString:tempTime]) {
            
            [arrM[i] setTime:@""];
        }else {
            tempTime = [arrM[i] time];
        }
    }
    return arrM;
}

#pragma mark - 完成自动回复
- (void)sendBtnClick {
    [self textFieldShouldReturn:self.textField];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat transformY = keyboardFrame.origin.y - self.view.bounds.size.height ;
    self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    
}

#pragma mark - 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - textField的代理方法,当点击键盘上的return键时调用此方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // 自己发送一条消息
    [self sendMessageWithText:self.textField.text messageType:QQChatTypeMe];
    
    // 对方回复一条消息
    NSString *replayText = [self replyWithText:self.textField.text];
    [self sendMessageWithText:replayText messageType:QQChatTypeOther];
    
    // 清空文本框的文字
    self.textField.text = nil;
    
    return YES;
}

// 传入自己发送的文字来获取自动回复内容
- (NSString *)replyWithText:(NSString *)text {
    // 遍历截取字符串
    for (int i = 0; i < text.length; ++i) {
        NSString *word = [text substringWithRange:NSMakeRange(i, 1)];
        if (self.autoreply[word]) {
            return self.autoreply[word];
        }
    }
    return @"88";
}

// 传入消息内容和消息类型,自己发送一条消息
- (void)sendMessageWithText:(NSString *)text messageType:(QQChatType)type {
    // 创建数据模型
    QQChat *chat = [[QQChat alloc] init];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    NSString *time = [dateFormatter stringFromDate:date];
    chat.time = time;
    chat.type = type;
    chat.text = text;

    if ([self.lastTime isEqualToString:chat.time]) {
        chat.time = @"";
    } else {
        self.lastTime = chat.time;
        
    }

    [self.chatData addObject:chat];
    
    //    [self.tableV iew reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.chatData.count - 1) inSection:0];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

// 加载自动回复数据
- (NSDictionary *)autoreply {
    if (_autoreply == nil) {
        _autoreply = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoreply.plist" ofType:nil]];
    }
    return _autoreply;
}


#pragma mark - @protocol UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_v endEditing];
}

#pragma mark - @protocol YHExpressionKeyboardDelegate
- (void)didSelectExtraItem:(NSString *)itemName{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:itemName message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - 点击发送
- (void)sendBtnDidTap:(NSString *)text{
    
    // 自己发送一条消息
    [self sendMessageWithText:text messageType:QQChatTypeMe];
    
    // 对方回复一条消息
    NSString *replayText = [self replyWithText:text];
    [self sendMessageWithText:replayText messageType:QQChatTypeOther];
    
    // 清空文本框的文字
    text = nil;
    
    
}


@end
