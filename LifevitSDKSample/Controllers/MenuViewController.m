//
//  MenuViewController.m
//  LifevitSDKSample
//
//  Created by iNMovens Solutions on 11/5/18.
//  Copyright © 2018 Lifevit. All rights reserved.
//

#import "MenuViewController.h"
@import LifevitSDK;

#define MENU_CONNECT_ALL 0
#define MENU_SCAN_ALL 1
#define MENU_HEART 2
#define MENU_TENSIO_BRACELET 3
#define MENU_BRACELET 4
#define MENU_OXIMETER 5
#define MENU_THERMOMETER 6
#define MENU_BABY_THERMOMETER 7
#define MENU_WEIGHT_SCALE 8
#define MENU_PILL_REMINDER 9

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Register the table view cell class and its reuse id
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSString* version = [[NSBundle bundleForClass:[LifevitSDKManager class]] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];

    [self.lblTitle setText:[NSString stringWithFormat:@"SDK version: %@", version]];
    
    [self setTitle:@"Lifevit SDK Sample"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    switch (indexPath.row) {
        case MENU_CONNECT_ALL:
            [cell.textLabel setText:@"Connect All"];
            break;
        case MENU_SCAN_ALL:
            [cell.textLabel setText:@"Scan All"];
            break;
        case MENU_HEART:
            [cell.textLabel setText:@"Tensiometer"];
            break;
        case MENU_TENSIO_BRACELET:
            [cell.textLabel setText:@"Tensiometer Bracelet"];
            break;
        case MENU_OXIMETER:
            [cell.textLabel setText:@"Oximeter"];
            break;
        case MENU_BRACELET:
            [cell.textLabel setText:@"Bracelet AT-250/AT-500HR"];
            break;
        case MENU_THERMOMETER:
            [cell.textLabel setText:@"Thermometer"];
            break;
        case MENU_BABY_THERMOMETER:
            [cell.textLabel setText:@"Baby Thermometer"];
            break;
        case MENU_WEIGHT_SCALE:
            [cell.textLabel setText:@"Weight Scale"];
            break;
        case MENU_PILL_REMINDER:
            [cell.textLabel setText:@"Pill Reminder"];
            break;
            
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case MENU_CONNECT_ALL:
            [self performSegueWithIdentifier:@"showConnectAllDevices" sender:self];
            break;
        case MENU_SCAN_ALL:
            [self performSegueWithIdentifier:@"showScanAll" sender:self];
            break;
        case MENU_HEART:
            [self performSegueWithIdentifier:@"showTensio" sender:self];
            break;
        case MENU_TENSIO_BRACELET:
            [self performSegueWithIdentifier:@"showTensioBracelet" sender:self];
            break;
        case MENU_OXIMETER:
            [self performSegueWithIdentifier:@"showOximeter" sender:self];
            break;
        case MENU_BRACELET:
            [self performSegueWithIdentifier:@"showBracelet" sender:self];
            break;
        case MENU_THERMOMETER:
            [self performSegueWithIdentifier:@"showThermometer" sender:self];
            break;
        case MENU_BABY_THERMOMETER:
            [self performSegueWithIdentifier:@"showBabyThermometer" sender:self];
            break;
        case MENU_WEIGHT_SCALE:
            [self performSegueWithIdentifier:@"showWeightScale" sender:self];
            break;
        case MENU_PILL_REMINDER:
            [self performSegueWithIdentifier:@"showPillReminder" sender:self];
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}



@end
