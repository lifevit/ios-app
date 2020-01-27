//
//  ViewController.m
//  BraceletSDKTest
//
//  Created by David Casas on 5/9/17.
//  Copyright © 2017 LifeVit. All rights reserved.
//

#import "BraceletViewController.h"


@interface BraceletViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UITextView *txtReceivedData;
@property (weak, nonatomic) IBOutlet UIButton *btnAction;
@property (weak, nonatomic) IBOutlet UIButton *btnSendCommand;
@property (weak, nonatomic) IBOutlet UISegmentedControl *braceletSelector;
@property (strong,nonatomic) NSTimer* timer;

@end

@implementation BraceletViewController{
    int deviceStatus;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"AT250/AT500HR"];
    
    // Do any additional setup after loading the view, typically from a nib.
    [LifevitSDKManager sharedInstance].deviceDelegate = self;
    [LifevitSDKManager sharedInstance].braceletDelegate = self;
    [LifevitSDKManager sharedInstance].braceletAT250Delegate = self;
    
    if([[LifevitSDKManager sharedInstance] isDeviceConnected:DEVICE_BRACELET_AT500HR]){
        deviceStatus = STATUS_CONNECTED;
        [_braceletSelector setEnabled:false];
        [_braceletSelector setSelectedSegmentIndex:1];
        [self device:DEVICE_BRACELET_AT500HR onConnectionChanged:deviceStatus];
    }
    if([[LifevitSDKManager sharedInstance] isDeviceConnected:DEVICE_BRACELET_AT250]){
        deviceStatus = STATUS_CONNECTED;
        [_braceletSelector setEnabled:false];
        [_braceletSelector setSelectedSegmentIndex:0];
        [self device:DEVICE_BRACELET_AT250 onConnectionChanged:deviceStatus];
    }
    else{
        deviceStatus = STATUS_DISCONNECTED;
        [self device:DEVICE_BRACELET_AT500HR onConnectionChanged:deviceStatus];
        [self device:DEVICE_BRACELET_AT250 onConnectionChanged:deviceStatus];
    }
    
    
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(initBraceletChecks) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onActionPressed:(id)sender {
    [self reconnectDevice];
}

- (void) reconnectDevice{
    
    int braceletDevice = _braceletSelector.selectedSegmentIndex == 0 ? DEVICE_BRACELET_AT250: DEVICE_BRACELET_AT500HR;
    
    switch(deviceStatus){
        case STATUS_DISCONNECTED:
            [[LifevitSDKManager sharedInstance] connectDevice:braceletDevice withTimeout:30];
            
            
            // [[LifevitSDKManager sharedInstance] connectDevice:DEVICE_OXIMETER withTimeout:30];
            // [[LifevitSDKManager sharedInstance] connectDevice:DEVICE_HEART withTimeout:30];
            break;
        case STATUS_CONNECTED:
        case STATUS_SCANNING:
        case STATUS_CONNECTING:
            [[LifevitSDKManager sharedInstance] disconnectDevice:braceletDevice];
            break;
    }
}

- (void)prepareCommandListAT250:(UIAlertController *)alert {
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"Set Datetime"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action)
                             {
                                 [[LifevitSDKManager sharedInstance] configureBraceletAT250Datetime: [NSDate date]];
                             }];
    [alert addAction:action];
    
    action = [UIAlertAction actionWithTitle:@"Set User Information Height: (190) Weight: (90) Gender: (Male/0) Birthday: (24/12/1980) Vibrate: (YES)"
                                      style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
              {
                  NSString *dateStr = @"1980-12-24";
                  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                  NSDate *date = [dateFormatter dateFromString:dateStr];
                  
                  [[LifevitSDKManager sharedInstance] configureBraceletAT250UserInfo: @190
                                                                          userWeight: @90
                                                                          userGender: @0
                                                                        userBirthday: date
                                                                             vibrate: YES];
              }];
    [alert addAction:action];
    
    action = [UIAlertAction actionWithTitle:@"Update Firmware"
                                      style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
              {
                  [[LifevitSDKManager sharedInstance] updateBraceletAT250Firmware];
              }];
    
    [alert addAction:action];
    
    action = [UIAlertAction actionWithTitle:@"Set Steps Goal: (8000)"
                                      style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
              {
                  [[LifevitSDKManager sharedInstance] configureBraceletAT250StepsGoal: @8000];
              }];
    
    [alert addAction:action];
    
    action = [UIAlertAction actionWithTitle:@"Get Data from today"
                                      style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
              {
                  [[LifevitSDKManager sharedInstance] getBraceletAT250TodayData];
              }];
    
    [alert addAction:action];
    
    action = [UIAlertAction actionWithTitle:@"Get History Data 3 days ago"
                                      style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
              {
                  [[LifevitSDKManager sharedInstance] getBraceletAT250HistoryData:@6];
                  [[LifevitSDKManager sharedInstance] getBraceletAT250HistoryData:@5];
                  [[LifevitSDKManager sharedInstance] getBraceletAT250HistoryData:@4];
                  [[LifevitSDKManager sharedInstance] getBraceletAT250HistoryData:@3];
                  [[LifevitSDKManager sharedInstance] getBraceletAT250HistoryData:@2];
                  [[LifevitSDKManager sharedInstance] getBraceletAT250HistoryData:@1];
                  [[LifevitSDKManager sharedInstance] getBraceletAT250HistoryData:@0];
              }];
    
    [alert addAction:action];
    
    action = [UIAlertAction actionWithTitle:@"Get HR Sync Data"
                                      style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
              {
                  
                  //-(void)getBraceletAT250HeartRateValue;
                  //-(void)setBraceletAT250RealtimeHREnabled:(BOOL) enabled;
                  //-(void)setBraceletAT250MonitoringHREnabled:(BOOL) enabled;
                  //-(void)setBraceletAT250MonitoringHRAuto:(BOOL) enabled withTimeRange: (LifevitSDKAT250TimeRange*) range;
                  [[LifevitSDKManager sharedInstance] getBraceletAT250HeartRateSync];
              }];
    
    [alert addAction:action];
    
    action = [UIAlertAction actionWithTitle:@"Enable realtime HR"
                                      style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
              {
                  [[LifevitSDKManager sharedInstance] setBraceletAT250RealtimeHREnabled:YES];
              }];
    
    [alert addAction:action];
    action = [UIAlertAction actionWithTitle:@"Disable realtime HR"
                                      style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
              {
                  [[LifevitSDKManager sharedInstance] setBraceletAT250RealtimeHREnabled:NO];
              }];
    
    [alert addAction:action];
    
    action = [UIAlertAction actionWithTitle:@"Enable monitoring HR"
                                      style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
              {
                  [[LifevitSDKManager sharedInstance] setBraceletAT250MonitoringHREnabled:YES];
              }];
    
    [alert addAction:action];
    action = [UIAlertAction actionWithTitle:@"Disable monitoring HR"
                                      style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
              {
                  [[LifevitSDKManager sharedInstance] setBraceletAT250MonitoringHREnabled:NO];
              }];
    
    [alert addAction:action];
    action = [UIAlertAction actionWithTitle:@"Set monitoring HR time range"
                                      style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
              {
                  LifevitSDKAT250TimeRange* range = [LifevitSDKAT250TimeRange new];
                  [[LifevitSDKManager sharedInstance] setBraceletAT250MonitoringHRAuto:YES withTimeRange:range];
              }];
    
    [alert addAction:action];
}

-(void) prepareCommandList: (UIAlertController*) alert {
    
    int braceletDevice = _braceletSelector.selectedSegmentIndex == 0 ? DEVICE_BRACELET_AT250: DEVICE_BRACELET_AT500HR;
    switch (braceletDevice) {
        case DEVICE_BRACELET_AT250: {
            [self prepareCommandListAT250:alert];
            
        }
            break;
            
        default: {
            if(![[LifevitSDKManager sharedInstance] isBraceletInActivity]){
                
                UIAlertAction* action = [UIAlertAction actionWithTitle:@"Send HOLA"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action)
                                         {
                                             [[LifevitSDKManager sharedInstance] sendTextToAT500HR:@"HOLA"];
                                         }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Set User Height (190)"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action)
                                         {
                                             [[LifevitSDKManager sharedInstance] configureBraceletUserHeight:190];
                                         }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Set User Weight (90)"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              [[LifevitSDKManager sharedInstance] configureBraceletUserWeight:90];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Set current date"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              [[LifevitSDKManager sharedInstance] configureBraceletDate:[NSDate new]];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure All ACNS"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              NSArray* ancsTypes = [NSArray arrayWithObjects:@(ACNS_CALL),@(ACNS_QQ),@(ACNS_SMS),@(ACNS_LINE),@(ACNS_EMAIL),@(ACNS_SKYPE),@(ACNS_WECHAT),@(ACNS_TWITTER),@(ACNS_FACEBOOK),@(ACNS_WHATSAPP),@(ACNS_INSTAGRAM), nil];
                              
                              [[LifevitSDKManager sharedInstance] configureBraceletACNS:ancsTypes];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure NO ACNS"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              NSArray* ancsTypes = [NSArray new];
                              
                              [[LifevitSDKManager sharedInstance] configureBraceletACNS:ancsTypes];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure NO Hand"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              
                              [[LifevitSDKManager sharedInstance] configureBraceletRiseHand:BRACELET_HAND_NONE];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure Right Hand"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              
                              [[LifevitSDKManager sharedInstance] configureBraceletRiseHand:BRACELET_HAND_RIGHT];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure Left Hand"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              [[LifevitSDKManager sharedInstance] configureBraceletRiseHand:BRACELET_HAND_LEFT];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure Antitheft"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              
                              [[LifevitSDKManager sharedInstance] configureBraceletAntitheft:YES];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure NO Antitheft"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              
                              [[LifevitSDKManager sharedInstance] configureBraceletAntitheft:NO];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure Monitor HeartRate"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              
                              [[LifevitSDKManager sharedInstance] configureBraceletMonitorHeartRate:YES];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure NO Monitor HeartRate"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              
                              [[LifevitSDKManager sharedInstance] configureBraceletMonitorHeartRate:NO];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure FindPhone"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              
                              [[LifevitSDKManager sharedInstance] configureBraceletSettingFindPhone:YES];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure NO FindPhone"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              
                              [[LifevitSDKManager sharedInstance] configureBraceletSettingFindPhone:NO];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Get current Steps"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              [[LifevitSDKManager sharedInstance] getBraceletCurrentSteps];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Get HeartBeat"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              [[LifevitSDKManager sharedInstance] getBraceletHeartBeat];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Sync History"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              [[LifevitSDKManager sharedInstance] synchronizeBraceletHistoryData];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Start Activity"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              [[LifevitSDKManager sharedInstance] sendBraceletStartOrFinishExercise:YES];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Bind bracelet"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              [[LifevitSDKManager sharedInstance] bindBracelet];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Activate bracelet"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              [[LifevitSDKManager sharedInstance] activateBracelet];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure alarm next minute"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              LifevitSDKBraceletAlarm * alarm = [[LifevitSDKBraceletAlarm alloc] init];
                              alarm.monday = NO;
                              alarm.tuesday = NO;
                              alarm.wednesday = YES;
                              alarm.thursday = NO;
                              alarm.friday = NO;
                              alarm.saturday = NO;
                              alarm.sunday = NO;
                              
                              NSDate * date = [NSDate dateWithTimeIntervalSinceNow:1*60];
                              NSDateFormatter * df = [NSDateFormatter new];
                              [df setDateFormat:@"HH"];
                              alarm.hour = @([[df stringFromDate:date] intValue]);
                              [df setDateFormat:@"mm"];
                              alarm.minute = @([[df stringFromDate:date] intValue]);
                              
                              [[LifevitSDKManager sharedInstance] configureBraceletAlarm:alarm];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Disable alarm"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                             
                              
                              [[LifevitSDKManager sharedInstance] disableBraceletAlarm:NO];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Disable sedentary alarm"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              [[LifevitSDKManager sharedInstance] disableBraceletSedentaryAlarm];
                          }];
                [alert addAction:action];
                
                action = [UIAlertAction actionWithTitle:@"Configure sedentary alarm from 9 to 17"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                          {
                              LifevitSDKBraceletSedentaryAlarm* alarm = [LifevitSDKBraceletSedentaryAlarm new];
                              alarm.startHour = @(9);
                              alarm.startMinute = @(0);
                              alarm.endHour = @(17);
                              alarm.endMinute = @(0);
                              alarm.interval = @(5);
                              
                              [[LifevitSDKManager sharedInstance] configureBraceletSedentaryAlarm:alarm];
                          }];
                [alert addAction:action];
                
            }else{
                UIAlertAction* action = [UIAlertAction actionWithTitle:@"Stop Activity"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action)
                                         {
                                             
                                             [[LifevitSDKManager sharedInstance] sendBraceletStartOrFinishExercise:NO];
                                         }];
                [alert addAction:action];
            }
            
            UIAlertAction* version = [UIAlertAction actionWithTitle:@"Get version"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action)
                                      {
                                          [[LifevitSDKManager sharedInstance] getBraceletVersion];
                                      }];
            
            [alert addAction:version];
            UIAlertAction* battery = [UIAlertAction actionWithTitle:@"Get battery"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action)
                                      {
                                          [[LifevitSDKManager sharedInstance] getBraceletBattery];
                                      }];
            
            [alert addAction:battery];
            

        }
            break;
    }

    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action)
                             {
                                 
                             }];
    
    [alert addAction:cancel];
}

- (IBAction)onSendCommand:(id)sender {
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Bracelet TEST"
                                                                  message:@"Choose the command you want to send"
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    [self prepareCommandList:alert];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Device delegate

-(void)device:(int)device onConnectionChanged:(int)status{
    
    int braceletDevice = _braceletSelector.selectedSegmentIndex == 0 ? DEVICE_BRACELET_AT250: DEVICE_BRACELET_AT500HR;
    if(device == braceletDevice){
    dispatch_async(dispatch_get_main_queue(), ^{
        
        deviceStatus = status;
        switch(status){
            case STATUS_CONNECTED:
                [self.btnSendCommand setHidden:NO];
                self.lblStatus.text = @"Connected";
                [self.lblStatus setTextColor:[UIColor greenColor]];
                [self.btnAction setTitle:@"Disconnect" forState:UIControlStateNormal];
                [_braceletSelector setEnabled:false];
                break;
            case STATUS_DISCONNECTED:
                [self.btnSendCommand setHidden:YES];
                self.lblStatus.text = @"Disconnected";
                [self.lblStatus setTextColor:[UIColor redColor]];
                [self.btnAction setTitle:@"Connect" forState:UIControlStateNormal];
                [_braceletSelector setEnabled:true];
                break;
            case STATUS_SCANNING:
                [self.btnSendCommand setHidden:YES];
                self.lblStatus.text = @"Scanning near devices...";
                [self.lblStatus setTextColor:[UIColor blackColor]];
                [self.btnAction setTitle:@"Cancel connection" forState:UIControlStateNormal];
                [_braceletSelector setEnabled:false];
                break;
            case STATUS_CONNECTING:
                [self.btnSendCommand setHidden:YES];
                self.lblStatus.text = @"Connecting";
                [self.lblStatus setTextColor:[UIColor blackColor]];
                [self.btnAction setTitle:@"Disconnect" forState:UIControlStateNormal];
                [_braceletSelector setEnabled:false];
        }
    });
    }
    else{
        switch (device) {
            case DEVICE_HEART:
                [[LifevitSDKManager sharedInstance] startMeasurement];
                break;
                
            default:
                break;
        }
    }
}

- (void)device:(int)device onConnectionError:(int)error{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.lblStatus setTextColor:[UIColor redColor]];
        _lblStatus.text = [@"On result error: " stringByAppendingString:[@(error) stringValue]];
        
    });}

- (void)device:(int)device onSendInformation:(id)data{
    if([data isKindOfClass:[NSString class]]){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString* text = self.txtReceivedData.text;
            
            text = [text stringByAppendingString:@"\n"];
            text = [text stringByAppendingString:data];
            self.txtReceivedData.text = text;
            
        });
    }
}


#pragma mark - bracelet delegate

- (void) braceletActivityStarted{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* text = self.txtReceivedData.text;
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:@"ACTIVITY STARTED"];
        self.txtReceivedData.text = text;
        
    });
}

- (void) braceletActivityFinished{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* text = self.txtReceivedData.text;
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:@"ACTIVITY FINISHED"];
        self.txtReceivedData.text = text;
        
    });
}

- (void)braceletBatteryReceived:(int)battery{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* text = self.txtReceivedData.text;
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Battery level: %d", battery]];
        self.txtReceivedData.text = text;
        
    });
}

- (void)braceletHeartDataReceived:(LifevitSDKHeartBeatData *)data{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* text = self.txtReceivedData.text;
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Heart Data Received: %d", [data.heartRate intValue]]];
        self.txtReceivedData.text = text;
        
    });
}

- (void)braceletParameterSet:(int)parameter{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* text = self.txtReceivedData.text;
        
        text = [text stringByAppendingString:@"\n"];
        
        switch (parameter) {
            case BRACELET_PARAM_ACNS:
                
                text = [text stringByAppendingString:@"ACNS Configured"];
                break;
            case BRACELET_PARAM_DATE:
                
                text = [text stringByAppendingString:@"Date Configured"];
                break;
            case BRACELET_PARAM_HANDS:
                
                text = [text stringByAppendingString:@"Hands Configured"];
                break;
            case BRACELET_PARAM_HEIGHT:
                
                text = [text stringByAppendingString:@"Height Configured"];
                break;
            case BRACELET_PARAM_TARGET:
                
                text = [text stringByAppendingString:@"Target Configured"];
                break;
            case BRACELET_PARAM_WEIGHT:
                
                text = [text stringByAppendingString:@"Weight Configured"];
                break;
            case BRACELET_PARAM_ANTILOST:
                
                text = [text stringByAppendingString:@"Antilost Configured"];
                break;
            case BRACELET_PARAM_HRMONITOR:
                
                text = [text stringByAppendingString:@"HRMonitor Configured"];
                break;
            case BRACELET_PARAM_FIND_PHONE:
                
                text = [text stringByAppendingString:@"Find Phone Configured"];
                break;
            case BRACELET_PARAM_FIND_DEVICE:
                
                text = [text stringByAppendingString:@"Find Device Configured"];
                break;
                
            default:
                break;
        }
        
        self.txtReceivedData.text = text;
        
    });
}

- (void)braceletBeepReceived{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* text = self.txtReceivedData.text;
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:@"Beep Received"];
        self.txtReceivedData.text = text;
        
    });
}

- (void)braceletSyncReceived:(LifevitSDKBraceletData *)data{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* text = self.txtReceivedData.text;
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:@"Sync Data Received"];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Step records: %lu", (unsigned long)data.stepsData.count]];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Sleep records: %lu", (unsigned long)data.sleepData.count]];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"HeartRate records: %lu", (unsigned long)data.heartData.count]];
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:@"First Results Steps:"];
        
        int i = 0;
        while(i<10 && i<data.stepsData.count){
            LifevitSDKStepData* v = [data.stepsData objectAtIndex:i];
            text = [text stringByAppendingString:@"\n"];
            text = [text stringByAppendingString:[NSString stringWithFormat:@"Date: %@ Steps: %d", v.date, [v.steps intValue]]];
            i++;
        }
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:@"First Results Sleep:"];
        
        i = 0;
        while(i<10 && i<data.sleepData.count){
            LifevitSDKSleepData* v = [data.sleepData objectAtIndex:i];
            text = [text stringByAppendingString:@"\n"];
            text = [text stringByAppendingString:[NSString stringWithFormat:@"Date: %@ sleep: %d", v.date, [v.sleepDuration intValue]]];
            i++;
        }
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:@"First Results HR:"];
        
        i = 0;
        while(i<10 && i<data.heartData.count){
            LifevitSDKHeartBeatData* v = [data.heartData objectAtIndex:i];
            text = [text stringByAppendingString:@"\n"];
            text = [text stringByAppendingString:[NSString stringWithFormat:@"Date: %@ HR: %d", v.date, [v.heartRate intValue]]];
            i++;
        }
        self.txtReceivedData.text = text;
        
        
    });
}

- (void)braceletCurrentStepsReceived:(LifevitSDKStepData *)data{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* text = self.txtReceivedData.text;
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:@"Current Day Received"];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Steps: %d", [data.steps intValue]]];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Calories: %d", [data.calories intValue]]];
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Distance: %.2f", [data.distance doubleValue]]];
        self.txtReceivedData.text = text;
        
    });
}

- (void) braceletAT250HRReceived: (int) value{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* text = self.txtReceivedData.text;
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Heart Data Received: %d", value]];
        self.txtReceivedData.text = text;
        
    });
}

-(void)braceletAT250HRSyncReceived:(NSArray *)value{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* text = self.txtReceivedData.text;
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Heart Data Received packets: %d", value.count]];
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:@"First Results:"];
        
        int i = 0;
        while(i<10 && i<value.count){
            LifevitSDKHeartBeatData* data = [value objectAtIndex:i];
            text = [text stringByAppendingString:@"\n"];
            text = [text stringByAppendingString:[NSString stringWithFormat:@"Date: %@ HR: %d", data.date, [data.heartRate intValue]]];
            i++;
        }
        self.txtReceivedData.text = text;
        
    });
}

- (void)operationFinished:(BOOL)success{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* text = self.txtReceivedData.text;
        text = [text stringByAppendingString:@"\n"];
        if (!success) {
            text = [text stringByAppendingString:@"Error on the operation requested"];
        } else {
            text = [text stringByAppendingString:@"Operation succesful"];
        }
        self.txtReceivedData.text = text;
    });
}

- (void)braceletActivityStepsReceived:(int)steps{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* text = self.txtReceivedData.text;
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Activity Steps: %d", steps]];
        
        self.txtReceivedData.text = text;
        
    });
}

- (void)braceletInfoReceived:(NSString *)info{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString* text = self.txtReceivedData.text;
        
        text = [text stringByAppendingString:@"\n"];
        text = [text stringByAppendingString:info];
        self.txtReceivedData.text = text;
        
    });
    
}


-(void) initLifevitOxy{
    [[LifevitSDKManager sharedInstance] connectDevice:DEVICE_OXIMETER withTimeout:15];
}
-(void) initLifevitTensi{
    [[LifevitSDKManager sharedInstance] connectDevice:DEVICE_HEART withTimeout:15];
}
-(void) initBraceletChecks{
    
    int braceletDevice = _braceletSelector.selectedSegmentIndex == 0 ? DEVICE_BRACELET_AT250: DEVICE_BRACELET_AT500HR;
    [[LifevitSDKManager sharedInstance] connectDevice:braceletDevice withTimeout:15];
}


@end
