## Preparation for Integration

### Register Tuya Developer Account

Go to the [Tuya Smart Development Platform](https://iot.tuya.com) to register a developer account, create products and create function points, etc. Please refer to the [Contact workflow](https://docs.tuya.com/cn/overview/dev-process.html) for details. 

###  Create an SDK APP

1.Log in to [IoT Console](https://iot.tuya.com/).

   **Note**: if you do not have a Tuya account, register first.

2.On the menu bar at the top of the **IoT Console**, click **App Service**.

   ![Obtain App SDK](./images/ae56bc110c054295b33151f788851405.png)

3.Select **App SDK**, and click **Create**.

![Obtain App SDK](./images/d329b1ee4b7046dd80a665a5f2ba45c7.png)

4.Enter app related information, and then click **OK**.

- **App name**: enter the App name.
- **iOS Bundle ID**: enter the iOS app bundle ID. The recommended format is com.xxxxx.xxxxx.
- **Android Package Name**: enter the Android app package name. It is not necessary to be consistent with iOS bundle ID.
- **Channel ID**: it is not required. If it is not entered, the system will automatically generate one channel ID according to the package name.


![Obtain App SDK](./images/f1ecc4824e564cd899f29b080c33b3f4.png)

5.You can choose the option you need according to actual needs, support multiple selections, and then integrate the SDK according to Podfile and Gradle.

![Obtain App SDK](./images/4268ece5e4904bd3b151b2e12c6657fd.png)

6.Click **Obtain Key** to get SDK AppKey, AppSecret, security picture and other information.

![Obtain App SDK](./images/46c1ff12289f46a798066df51f3bb356.png)