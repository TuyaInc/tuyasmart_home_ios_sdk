# Encrypted Image

When the device triggers a detection alarm, it usually uploads a screenshot of a real-time video to Tuya Cloud. The alarm message or cloud storage event obtained through the IPC SDK will carry an encrypted video screenshot, Need to use `TYEncryptImage` component to display encrypted images.

## TYEncryptImage

Add interfaces for displaying encrypted images through the category of `UIImageView`. For details of the interfaces definition, please refer to `UIImageView+TYAESImage.h`.

**Declaration**

Display encrypted image

```
- (void)ty_setAESImageWithPath:(NSString *)imagePath
                    encryptKey:(NSString *)encryptKey;
```

**Parameters**

| Parameter  | Description    |
| ---------- | -------------- |
| imagePath  | Image url path |
| encryptKey | Encryption key |

**Declaration**

Display encrypted image, and set a placeholder image.

```objc
- (void)ty_setAESImageWithPath:(NSString *)imagePath
                    encryptKey:(NSString *)encryptKey
              placeholderImage:(UIImage *)placeholderImage;
```

**Parameters**

| Parameter        | Description                                                 |
| ---------------- | ----------------------------------------------------------- |
| placeholderImage | Placeholder image, display before image download completed. |

**Declaration**

Display encrypted image, and set a callback function that called when image download completed.

```objc
- (void)ty_setAESImageWithPath:(NSString *)imagePath
                    encryptKey:(NSString *)encryptKey
                     completed:(nullable TYEncryptWebImageCompletionBlock)completedBlock;
```

**Parameters**

| Parameter      | Description       |
| -------------- | ----------------- |
| completedBlock | Callback function |

## Alarm Message

In the alarm message, the value of the picture attachment `TuyaSmartCameraMessageModel.attachPic` consists of two parts, the picture url path and the encryption key, which are spliced in the format of "{path}@{key}". When displaying the picture, you need to split this string with "@". If the value of the picture attachment string does not have the suffix "@{key}", it means that the picture is not encrypted.

**Example**

```objc
#import <TuyaSmartCameraKit/TuyaSmartCameraKit.h>
#import <TYEncryptImage/TYEncryptImage.h>
#import <SDWebImage/UIImageView+WebCache.h>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    TuyaSmartCameraMessageModel *messageModel = [self.messageModelList objectAtIndex:indexPath.row];
    NSArray *components = [messageModel.attachPic componentsSeparatedByString:@"@"];
    if (components.count != 2) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:messageModel.attachPic] placeholderImage:[self placeHolder]];
    }else {
        [cell.imageView ty_setAESImageWithPath:components.firstObject encryptKey:components.lastObject placeholderImage:[self placeHolder]];
    }
    cell.imageView.frame = CGRectMake(0, 0, 88, 50);
    cell.textLabel.text = messageModel.msgTitle;
    cell.detailTextLabel.text = messageModel.msgContent;
    return cell;
}
```

## Cloud storage event

In the cloud storage event, the value of the event screenshot `TuyaSmartCloudTimeEventModel.snapshotUrl` is just a complete picture url path, and the key uses the unified key for cloud storage video playback.

**Example**

```objc
#import <TuyaSmartCameraKit/TuyaSmartCameraKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <TYEncryptImage/TYEncryptImage.h>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm:ss";
    });
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"event"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"event"];
    }
    TuyaSmartCloudTimeEventModel *eventModel = [self.eventModels objectAtIndex:indexPath.row];
    [cell.imageView ty_setAESImageWithPath:eventModel.snapshotUrl encryptKey:self.cloudManager.encryptKey placeholderImage:[self placeholder]];
    cell.textLabel.text = eventModel.describe;
    cell.detailTextLabel.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:eventModel.startTime]];
    return cell;
}

```



