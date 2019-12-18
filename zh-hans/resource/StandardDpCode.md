# 标准控制指令集

| 序号 | 已适配产品大类 |
| ---- | -------------- |
| 1    | 加湿器         |
| 2    | 空气净化器     |
| 3    | 风扇           |

## 数据传输类型

| 数据传输类型   | 简写 | 解释                                           |
| -------------- | ---- | ---------------------------------------------- |
| 可下发，可上报 | rw   | 指令数据可以下发给设备，设备数据可以上报给云端 |
| 只上报         | ro   | 数据只支持从设备上报                           |
| 只下发         | wr   | 数据只支持从云端下发                           |

## 类型详情解释

### 1. Integer 类型示例格式

{"min":11,"unit":"s","scale":0,"max":86400,"step":1}

**解释**：

min:最小取值。示例为：11 

max:最大取直。示例为：86400 

unit:数值的单位。示例为：s 

scale:数据将以10的指数转换进行传输。示例为：0 表示，乘以10的0次方，即为1。 

step:数据增量间距（即‘步长’）。示例为：1



### 2. String 类型示例格式

{"maxlen":255}

**解释**： maxlen:值最大长度。示例为255



### 3. Enum 类型示例格式

{"range":["1","2","3","4","5"]}

**解释**： range:枚举取值限定范围。示例为：“1”,“2”,“3”,“4”,“5”



### 4. Boolean 下发布尔类型值即可



## **加湿器**

|       code       | 名称           | 传输类型 | 类型   |                           类型详情                           |
| :--------------: | -------------- | :------: | ------ | :----------------------------------------------------------: |
|       mode       | 工作模式       |    rw    | enum   |      {"range":["small","middle","large"],"type":"enum"}      |
|    countdown     | 倒计时         |    rw    | enum   | {"range":["cancel","1","2","3","4","5","6","7","8","9","10","11","12"],"type":"enum"} |
|  countdown_left  | 倒计时剩余时间 |    ro    | value  | {"unit":"min","min":0,"max":720,"scale":0,"step":1,"type":"value"} |
|    switch_led    | 熄屏           |    rw    | bool   |                       {"type":"bool"}                        |
|      fault       | 故障告警       |    ro    | bitmap |     {"label":["lack_water"],"type":"bitmap","maxlen":1}      |
|      switch      | 总开关         |    rw    | bool   |                       {"type":"bool"}                        |
|   humidity_set   | 设定湿度       |    rw    | value  | {"unit":"","min":0,"max":80,"scale":0,"step":5,"type":"value"} |
| humidity_current | 当前湿度       |    ro    | value  | {"unit":"","min":0,"max":100,"scale":0,"step":1,"type":"value"} |
|      sleep       | 睡眠模式       |    rw    | bool   |                       {"type":"bool"}                        |
| moodlighting | 氛围灯|  rw  | enum  |        {"range":["1","2","3","4","5"],"type":"enum"}         |
| colour_data  | 彩灯   |  rw  | value | {"min":0,"unit":"","scale":0,"max":255,"type":"value","step":1} |
### mode - 工作模式

* 说明

  ```
  "large":高档
  "middle":中档
  "small":低档
  ```

* 示例

  ```
  {
  	"mode" : "small" // 设置模式为低档
  }
  ```

### countdown - 倒计时

* 说明

  ```
  "cancel":取消倒计时设置
  "1":1小时
  "2":2小时
  "3":3小时
  "4":4小时
  "5":5小时
  "6":6小时
  ...
  "12":12小时
  ```

* 示例

  ```
  {
  	"countdown" : "1" // 倒计时 1 小时
  }
  ```


### switch_led - 熄屏

* 说明

  ```
  true: 打开
  false: 关闭
  ```

* 示例

  ```
  {
  	"switch_led" : true
  }
  ```

### switch - 总开关

* 说明

  ```
  true: 打开
  false: 关闭
  ```

* 示例

  ```
  {
  	"switch" : true
  }
  ```

### humidity_set - 设定湿度

* 说明

  ```
  min : 0
  max : 80
  step : 5 
  ```

* 示例

  ```
  {
  	"humidity_set " : 55
  }
  ```

### sleep - 睡眠模式

* 说明

  ```
  true: 打开
  false: 关闭
  ```

* 示例

  ```
  {
  	"sleep" : true
  }
  ```

### countdown_left - 倒计时剩余时间

* 说明

  ```
  min:0
  max:720
  unit:min
  ```

* 示例

  ```
  {
  	"countdown_left" : 720 // 720 分钟 = 12 小时
  }
  ```

### humidity_current - 当前湿度

* 说明

  ```
  min:0
  max:100
  step:1
  ```

* 示例

  ```
  {
  	"humidity_current" : 55 // 湿度 55
  }
  ```


### moodlighting - 氛围灯

* 说明

  ```
  "1":呼吸灯循环模式
  "2":呼吸灯选色模式
  "3":呼吸灯关闭
  "4":呼吸灯开启
  "5":呼吸灯定色模式
  ```

* 示例

  ```
  {
  	"moodlighting" : "1" // 呼吸灯循环模式
  }
  ```

### colour_data - 彩灯

* 说明

  ```
  min:0
  max:255
  ```

* 示例

  ```
  {
  	"colour_data" : 50
  }
  ```


##  **空气净化器**

| dpid |      code      |   名称   |             描述             | 模式 | 类型  |                           类型详情                           |
| :--- | :------------: | :------: | :--------------------------: | :--: | :---: | :----------------------------------------------------------: |
| 1    |     switch     |   开关   |                              |  rw  | bool  |                       {"type":"bool"}                        |
| 2    |      pm25      |  PM2.5   |                              |  ro  | value | {"unit":"ug/m³","min":0,"max":999,"scale":0,"step":1,"type":"value"} |
| 3    |      mode      |   模式   | 手动模式；自动模式；睡眠模式 |  rw  | enum  |      {"range":["manual","auto","sleep"],"type":"enum"}       |
| 4    | fan_speed_enum |   风速   |    低档，中档，高档，急速    |  rw  | enum  |  {"range":["low","middle","high","rapidly"],"type":"enum"}   |
| 5    |     filter     | 滤网寿命 |                              |  ro  | value | {"unit":"%","min":0,"max":100,"scale":0,"step":1,"type":"value"} |
| 7    |      lock      |   童锁   |                              |  rw  | bool  |                       {"type":"bool"}                        |
| 19   |   countdown    |   定时   |                              |  rw  | enum  | {"range":["cancel","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"],"type":"enum"} |
| 101  |     anion      |  负离子  |                              |  rw  | bool  |                       {"type":"bool"}                        |
| 102  |  air_quality   | 空气质量 |                              |  ro  | enum  |   {"range":["best","good","general","bad"],"type":"enum"}    |

### switch - 开关

* 说明

  ```
  true: 打开
  false: 关闭
  ```

* 示例

  ```
  {
  	"switch" : true
  }
  ```

### mode - 模式

* 说明

  ```
  "auto":自动模式
  "sleep":睡眠模式
  "manual":手动模式
  ```

* 示例

  ```
  {
  	"mode" : "sleep" // 睡眠模式
  }
  ```

### fan_speed_enum - 风速

* 说明

  ```
  "low":低档
  "middle":中档
  "high":高档
  "rapidly":急速
  ```

* 示例

  ```
  {
  	"fan_speed_enum" : "middle" // 中档
  }
  ```

### lock - 童锁

* 说明

  ```
  true: 打开
  false: 关闭
  ```

* 示例

  ```
  {
  	"lock" : true
  }
  ```

### countdown - 倒计时

* 说明

  ```
  "cancel":取消倒计时设置
  "1":1小时
  "2":2小时
  "3":3小时
  ...
  "24":24小时
  ```

* 示例

  ```
  {
  	"countdown" : 50
  }
  ```

### anion - 负离子

* 说明

  ```
  true: 打开
  false: 关闭
  ```

* 示例

  ```
  {
  	"anion" : true
  }
  ```

### air_quality - 空气质量

* 说明

  ```
  "great":优
  "mild":轻度污染
  "good":良
  "medium":重度污染
  ```

* 示例

  ```
  {
  	"air_quality" : "mild" //轻度污染
  }
  ```

## 风扇

| code      | 名称 | 描述                  | 模式 | 类型 | 类型详情                                                     |
| --------- | ---- | --------------------- | ---- | ---- | ------------------------------------------------------------ |
| switch    | 开关 |                       | rw   | bool | {"type":"bool"}                                              |
| fan_speed | 风速 |                       | rw   | enum | {"range":["1","2","3","4","5","6","7","8","9"],"type":"enum"} |
| mode      | 风类 | 睡眠风，强劲风,自然风 | rw   | enum | {"range":["sleep","heavy","fresh","close"],"type":"enum"}    |

### switch - 开关

* 说明

  ```
  true: 打开
  false: 关闭
  ```

* 示例

  ```
  {
  	"switch" : "true"
  }
  ```

### fan_speed - 风速

* 说明

  ```
  "1":1档
  "2":2档
  "3":3档
  ...
  "9":9档
  ```

* 示例

  ```
  {
  	"fan_speed" : "1"
  }
  ```



### mode - 风类

* 说明

  ```
  "sleep":"睡眠风"
  "fresh":"清新风"
  "heavy":"强劲风"
  ```

* 示例

  ```
  {
  	"mode" : "fresh" // 清新风
  }
  ```