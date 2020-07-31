# 加密图片

设备在触发侦测报警时，通常会上传一张实时视频的截图到涂鸦云端，通过 IPC SDK 获取到的告警消息或者云存储事件中，都会携带一张加密后的视频截图。需要使用`TYEncryptImage`组件来展示加密图片。

## 解密组件

通过`UIImageView`的分类来添加显示加密图片的接口，接口定义详情见`UIImageView+TYAESImage.h`。

**接口说明**

显示加密图片

```
- (void)ty_setAESImageWithPath:(NSString *)imagePath
                    encryptKey:(NSString *)encryptKey;
```

**参数说明**

| 参数       | 说明     |
| ---------- | -------- |
| imagePath  | 图片地址 |
| encryptKey | 加密密钥 |

**接口说明**

显示加密图片，并设置一张占位图。

```objc
- (void)ty_setAESImageWithPath:(NSString *)imagePath
                    encryptKey:(NSString *)encryptKey
              placeholderImage:(UIImage *)placeholderImage;
```

**参数说明**

| 参数             | 说明                           |
| ---------------- | ------------------------------ |
| placeholderImage | 占位图，在图片加载完成之前展示 |

**接口说明**

显示加密图片，并添加一个图片加载完成的回调函数

```objc
- (void)ty_setAESImageWithPath:(NSString *)imagePath
                    encryptKey:(NSString *)encryptKey
                     completed:(nullable TYEncryptWebImageCompletionBlock)completedBlock;
```

**参数说明**

| 参数           | 说明         |
| -------------- | ------------ |
| completedBlock | 加载完成回调 |

## 报警消息

报警消息中，图片附件`TuyaSmartCameraMessageModel.attachPic`的值由两部分组成，图片地址和加密密钥，以 “{path}@{key}” 的格式拼接。展示图片时，需要将这个字符串拆开。如果图片附件字符串的值，没有 “@{key}” 的后缀，则表示

**示例代码**

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

## 云存储事件

云存储事件中，事件截图 `TuyaSmartCloudTimeEventModel.snapshotUrl`的值，就只是一个完整的图片地址，密钥使用云存储视频播放的统一密钥。

**示例代码**

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



