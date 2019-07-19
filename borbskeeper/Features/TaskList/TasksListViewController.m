//
//  TasksListViewController.m
//  borbskeeper
//
//  Created by cassanene on 7/16/19.
//  Copyright © 2019 juliapark628. All rights reserved.
//

#import "TasksListViewController.h"
#import "Task.h"
#import "BorbParseManager.h"

@interface TasksListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *incompleteTaskList;
@property (strong, nonatomic) NSString *current_username;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation TasksListViewController

static NSString *const COMPOSE_SEGUE_ID = @"composeTaskSegue";
static NSString *const EDIT_SEGUE_ID = @"editTaskSegue";
static NSString *const TASK_TABLE_VIEW_CELL_ID = @"TaskCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.current_username = [PFUser currentUser].username;
    [self fetchData];
    [self refreshTaskList];
    
    
}

- (IBAction)tapTaskCell:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:EDIT_SEGUE_ID sender:nil];
}

- (IBAction)didTapNewTask:(id)sender {
    [self performSegueWithIdentifier:COMPOSE_SEGUE_ID sender:nil];
}

- (IBAction)didTapSignOut:(id)sender {
    [BorbParseManager signOutUser];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.incompleteTaskList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:TASK_TABLE_VIEW_CELL_ID];
    
    Task *currTask = self.incompleteTaskList[indexPath.row];
    
    [cell setDataAtCellWithTask:currTask];
    
    return cell;
}
-(void)refreshTaskList{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    [self.activityIndicator startAnimating];
}

-(void)fetchData {
    [BorbParseManager fetchIncompleteTasksOfUser:self.current_username WithCompletion:^(NSMutableArray *posts) {
        self.incompleteTaskList = posts;
        [self.tableView reloadData];
        [self.activityIndicator stopAnimating];
        [self.refreshControl endRefreshing];
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//}

@end