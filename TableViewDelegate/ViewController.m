//
//  ViewController.m
//  TableViewDelegate
//
//  Created by Mac on 2021/4/22.
//  Copyright © 2021 Mac. All rights reserved.
//

#import "ViewController.h"
#import "LeftViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self getDataSource];
    [self initView];
    [self initRightBar];
}

#pragma mark == 懒加载 ==

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell description]];
        
    }
    return _tableView;
}

#pragma mark == init ==

-(void)initData{
    self.dataArr = [NSMutableArray array];
}

-(void)getDataSource{
    for (int i=0; i<26; i++) {
        
        NSString * str = [NSString stringWithFormat:@"%c",'A'+i];

        [self.dataArr addObject:str];
        
}

}

-(void)initView{
//    [self.tableView setEditing:YES];
    [self.view addSubview:self.tableView];
}

-(void)initRightBar{
    UIButton * rightBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [rightBtn setTitle:@"编辑" forState:0];
    [rightBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = item;
    
    
    UIButton * leftBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [leftBtn setTitle:@"跳转" forState:0];
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark == btnClick ==

-(void)rightButtonClick:(UIButton * )sender{
    
    sender.selected = !sender.selected;
    [self.tableView setEditing:sender.selected];
    
}

-(void)leftButtonClick{
    [self.navigationController pushViewController:[[LeftViewController alloc] init] animated:YES];
}

#pragma mark == delegate ==

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description] forIndexPath:indexPath];
    
//    if (!tableView.dragging && !tableView.decelerating) {
//         cell.textLabel.text = [NSString stringWithFormat:@"这是%ld-%@",indexPath.section,self.dataArr[indexPath.section]];
        
        cell.imageView.image = [UIImage imageNamed:@"back2"];
        [self performSelector:@selector(p_loadImage:) withObject:indexPath afterDelay:0.0 inModes:@[NSDefaultRunLoopMode]];
//    }else{
//        cell.imageView.image = [UIImage imageNamed:@"back2"];
//    }
//
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%@",self.dataArr[section]];
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.dataArr;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index-1;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (@available(iOS 11.0, *)) {

        __weak typeof(self) weakSelf = self;
        UIContextualAction * config = [UIContextualAction contextualActionWithStyle:(UIContextualActionStyleDestructive) title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {

            [weakSelf.dataArr removeObjectAtIndex:indexPath.section];
            [weakSelf.tableView reloadData];

        }];
        UISwipeActionsConfiguration * swipeConfig = [UISwipeActionsConfiguration  configurationWithActions:@[config]];
              return swipeConfig;
    }else {
        // Fallback on earlier versions
    }
    return nil;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
//
//}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [self.dataArr exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
//    // 取出要拖动的模型数据
//       NSString *goods = self.dataArr[sourceIndexPath.row];
//       //删除之前行的数据
//       [self.dataArr removeObject:goods];
//       // 插入数据到新的位置
//       [self.dataArr insertObject:goods atIndex:destinationIndexPath.row];
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//
//    [self p_loadImage];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//
//    if(!decelerate){
//        //直接停止-无动画
//        [self p_loadImage];
//    }else{
//        //有惯性的-会走`scrollViewDidEndDecelerating`方法，这里不用设置
//    }
//}

- (void)p_loadImage:(NSIndexPath *)indexPath{

    //拿到界面内-所有的cell的indexpath
//    NSArray *visableCellIndexPaths = self.tableView.indexPathsForVisibleRows;
//
//
//    for (NSIndexPath *indexPath in visableCellIndexPaths) {
          UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    dispatch_async(dispatch_get_main_queue(), ^{
         cell.imageView.image = [UIImage imageNamed:@"back"];
    });
       
//    }
}



@end
