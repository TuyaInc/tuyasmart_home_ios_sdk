## User management

Tuya Cloud supports various kinds of user systems such as mobile phone, email and UID. Mobile phone supports verification code login and password login. The registration and login of each user system will be separately described later. 

The `countryCode` parameter (country code) needs to be provided in the registration and login method for region selection of Tuya Cloud. Data of all available regions is independent. The Chinese Mainland account `(country code: 86)` cannot be used in the `USA (country code: 1)`. The Chinese Mainland account does not exist in the USA region.

For details about available region, please refer to the [Tuya Cloud-Available Region](https://docs.tuya.com/cn/cloudapi/api/cloudapi/)

All functions of user are realized by using the `TuyaSmartUser` Class (singleton).
