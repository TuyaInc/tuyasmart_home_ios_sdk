# Smart Scene

Smart divides into scene or automation actions. 

Scene is a condition that users add actions and it is triggered manually; Automation action is a action set by users, and the set action is automatically executed when the condition is triggered.

The Tuya Cloud allows users to set meteorological or device conditions based on actual scenes in life, and if conditions are met, one or multiple devices will carry out corresponding tasks.

| Class | Description |
| -------------- | ---------- |
| TuyaSmartScene   |   Provides 4 operations, namely, adding, editing, removing and operating, for single scene, and the scene id is required for initiation. The scene id refers to the `sceneId` of the `TuyaSmartSceneModel`, and it can be obtained from the scene list|
| TuyaSmartSceneManager | Provides all data related to conditions, tasks, devices and city for scenes, as well as the method of obtaining scene list data.|
|TuyaSmartScenePreConditionFactory| A tool class that provides a quick way to create automation effective period condition.|
|TuyaSmartSceneConditionFactory | A tool class that provides a quick way to create scene conditions. |
|TuyaSmartSceneActionFactory | A tool class that provides a quick way to create scene actions. |
|TuyaSmartSceneConditionExprBuilder| A tool class that provides a quick way to create scene condition's expressions. |

Before using interfaces related to the smart scene, you have to understand the scene conditions and scene tasks first.

**In the following documents, manual scene and automated scene are simply referred to as scene.**

## Scene Condition

All scenes conditions are defined in the `TuyaSmartSceneConditionModel` class, and Tuya supports three types of conditions:

- Meteorological conditions including temperature, humidity, weather, PM2.5, air quality and sunrise and sunset. User can select city when he/she selects the meteorological conditions.
- Device conditions: if you have preset a function status for a device, the task in the scene will be triggered when the device status is reached. To avoid conflicts in operation, the same device cannot be used for both conditions and task at the same time.
- Timing conditions: the device will carry out preset task at the required time.

## Scene Action

In this case, one or multiple devices will run some operations or enable/disable an automation action (with scene conditions) when the preset meteorological or device conditions are met. All relevant functions are realized in the `TuyaSmartSceneActionModel` class.

**There are some examples at the end of this document, whice can help you about creating an object of `TuyaSmartSceneActionModel` or `TuyaSmartSceneConditionModel`.**