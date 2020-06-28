## Low power doorbell

### Sleep and wake

Low power doorbell is powered by battery. In order to save power, camera will sleep when no p2p connection for a certain period of time. After sleeping, it cannot be directly connected to p2p. You need to wake up the device, and then connect to the p2p channel after waking up.

Use `TuyaSmartDevice` to wake up doorbell.

**Declaration**

Awake low power device.

```objc
- (void)awakeDeviceWithSuccess:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;
```

When success callback, it is means wake up cammand has publish succeed, but doorbell is not waking up. When doorbell waking up, doorbell wiil report `YES` of data point `TuyaSmartCameraWirelessAwakeDPName`.

**Example**

ObjC

```objc
- (void)viewDidLoad {
		[super viewDidLoad];
	  self.dpManager = [[TuyaSmartCameraDPManager alloc] initWithDeviceId:self.devId];
		self.device = [TuyaSmartDevice deviceWithDeviceId:self.devId];
		[self.dpManager addObserver:self];
  
  	[self start];
}

// Determine if it is a low power doorbell
- (BOOL)isDoorbell {
    return [self.dpManager isSupportDP:TuyaSmartCameraWirelessAwakeDPName];
}

- (void)start {
    if ([self isDoorbell]) {
        __weak typeof(self) weakSelf = self;
				BOOL isAwaking = [[self.dpManager valueForDP:TuyaSmartCameraWirelessAwakeDPName] boolValue];
        if (isAwaking) { 
            if (self.isConnected) {
                [self.videoContainer addSubview:self.camera.videoView];
                self.camera.videoView.frame = self.videoContainer.bounds;
                [self.camera startPreview];
            }else {
                [self.camera connect];
            }
        }else { 
            [self.device awakeDeviceWithSuccess:nil failure:nil];
        }
    }
}
// TuyaSmartCameraDPObserver. When the device DP is updated, this listening callback will be triggered
- (void)cameraDPDidUpdate:(TuyaSmartCameraDPManager *)manager dps:(NSDictionary *)dpsData {
    // If receive an update to TuyaSmartCameraWirelessAwakeDPName and the value is YES, the device has woken up
    if ([[dpsData objectForKey:TuyaSmartCameraWirelessAwakeDPName] boolValue]) {
        [self start];
    }
}

```

Swift

``` swift
func viewDidLoad() {
  	super.viewDidLoad()
	  self.dpManager = TuyaSmartCameraDPManager(deviceId: self.devId)
		self.device = TuyaSmartDevice(deviceId: self.devId)
		self.dpManager?.addObserver(self)
  
  	self.start()
}

// Determine if it is a low power doorbell
func isDoorbell() -> Bool {
    return self.dpManager?.isSupportDP(TuyaSmartCameraWirelessAwakeDPName)
}

func start() {
    if isDoorbell() {
        let isAwaking = self.dpManager.valueForDP(TuyaSmartCameraWirelessAwakeDPName)
        guard isAwaking else {
            self.device?.awake(success: nil, failure: nil)
        }
        guard self.isConnected else {
            self.camera.connect()
        }
        self.videoContainer.addSubView(self.camera.videoView)
        self.camera.videoView.frame = self.videoContainer.bounds
        self.camera.startPreview()        
    }
}

// TuyaSmartCameraDPObserver. When the device DP is updated, this listening callback will be triggered
func cameraDPDidUpdate(_ manager: TuyaSmartCameraDPManager!, dps dpsData: [AnyHashable : Any]!) {
    // If receive an update to TuyaSmartCameraWirelessAwakeDPName and the value is YES, the device has woken up
    if let awake = dpsData[TuyaSmartCameraWirelessAwakeDPName] as? Bool, aweak == true {
        self.start()
    }
} 
    
```

### Doorbell call

When the device is successfully bound to the home and online, when someone rings the doorbell, the SDK will receive the event of the doorbell call. Events are broadcast as notifications.

* Notification name: **kNotificationMQTTMessageNotification**
* Parameters：
  * **devId**: Device id of doorbell.
  * **etype**：Event type, ```doorbell``` means doorbell call.

**Example**

ObjC

```objc
#define kTuyaDoorbellNotification @"kNotificationMQTTMessageNotification"

- (void)observeDoorbellCall:(void(^)(NSString *devId, NSString *type))callback {
    if (!callback) {
        return;
    }
		// Add observer for doorbell call
    [[NSNotificationCenter defaultCenter] addObserverForName:kTuyaDoorbellNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSDictionary *eventInfo = note.object;
        NSString *devId = eventInfo[@"devId"];
        NSString *eType = [eventInfo objectForKey:@"etype"];
        if ([eType isEqualToString:@"doorbell"]) {
            callback(devId, eType);
        }
    }];
}
```

Swift

```swift
func obserDoorbellCall(_ callBack: @escaping (String, String) -> Void) {
		// Add observer for doorbell call
    NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "kNotificationMQTTMessageNotification"), object: nil, queue: nil) { (noti) in
        if let eventInfo = noti.object as? [String: Any?] {
            let devId = eventInfo["devId"] as! String
            let eType = eventInfo["etype"] as! String
            if eType == "doorbell" {
                callBack(devId, eType)
            }
        }
    }
}
```

### Battery management

There are two ways to power low-power doorbells, plug-in and battery-powered. The SDK can query the current power supply mode and current power of the device. You can also set a low battery alarm threshold. When the battery is too low, an alarm notification will be triggered.

**Example**

ObjC

```objc
- (void)viewDidLoad {
		if ([self.dpManager isSupportDP:TuyaSmartCameraWirelessPowerModeDPName]) {
        TuyaSmartCameraPowerMode powerMode = [[self.dpManager valueForDP:TuyaSmartCameraWirelessPowerModeDPName] tysdk_toString];
        if ([powerMode isEqualToString:TuyaSmartCameraPowerModePlug]) {
						// plug-in power
        }else if ([powerMode isEqualToString:TuyaSmartCameraPowerModeBattery]) {
            // battery-power
        }
    }
    
    if ([self.dpManager isSupportDP:TuyaSmartCameraWirelessElectricityDPName]) {
        NSInteger electricity = [[self.dpManager valueForDP:TuyaSmartCameraWirelessElectricityDPName] tysdk_toInt];
        NSLog(@"current power: %@%%", @(electricity));
    }
    
    if ([self.dpManager isSupportDP:TuyaSmartCameraWirelessLowpowerDPName]) {
        // When the battery level is lower than 20%, low battery warning will be triggered
        [self.dpManager setValue:@(20) forDP:TuyaSmartCameraWirelessLowpowerDPName success:^(id result) {
            
        } failure:^(NSError *error) {
            // Network error
        }];
    }
    
    if ([self.dpManager isSupportDP:TuyaSmartCameraWirelessBatteryLockDPName]) {
        // Unlock the battery to remove the battery
        [self.dpManager setValue:@(NO) forDP:TuyaSmartCameraWirelessBatteryLockDPName success:^(id result) {
            
        } failure:^(NSError *error) {
            // Network error
        }];
    }
}
```

Swift

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    if self.dpManager.isSupportDP(.wirelessPowerModeDPName) {
        let powerMode = self.dpManager.value(forDP: .wirelessPowerModeDPName) as! String
        switch TuyaSmartCameraPowerMode(rawValue: powerMode) {
        case .plug: break
            // plug-in power
        case .battery: break
            // battery-power
        default: break
        }
    }

    if self.dpManager.isSupportDP(.wirelessElectricityDPName) {
        let electricity = self.dpManager.value(forDP: .wirelessElectricityDPName) as! Int
        print("current power: ", electricity)
    }

    if self.dpManager.isSupportDP(.wirelessLowpowerDPName) {
        // When the battery level is lower than 20%, low battery warning will be triggered
        self.dpManager.setValue(20, forDP: .wirelessLowpowerDPName, success: { _ in

        }) { _ in
            // Network error
        }
    }

    if self.dpManager.isSupportDP(.wirelessBatteryLockDPName) {
        // Unlock the battery to remove the battery
        self.dpManager.setValue(false, forDP: .wirelessBatteryLockDPName, success: { _ in

        }) { _ in
            // Network error
        }
    }
}
```

