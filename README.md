Cattle Management App written in Flutter.It uses [Nestjs](https://github.com/nestjs/nest) as backend that you can find it [here]()(it will uploaded soon) and also a design implementation of [Best Cattle Management App](https://dribbble.com/shots/10497109-Best-Cattle-Management-App) and [Cow milk](https://dribbble.com/shots/13081526-Cow-milk) as app launcher.


## Android Screenshots

  HomePage                 |   Animals List        |  Filter list
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/k2288/cattle/blob/master/ss/flutter_01.png?raw=true)|![](https://github.com/k2288/cattle/blob/master/ss/flutter_02.png?raw=true)|![](https://github.com/k2288/cattle/blob/master/ss/flutter_05.png?raw=true)

  Animal Detail                 |   Create        |  Add State
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/k2288/cattle/blob/master/ss/flutter_03.png?raw=true)|![](https://github.com/k2288/cattle/blob/master/ss/flutter_06.png?raw=true)|![](https://github.com/k2288/cattle/blob/master/ss/flutter_07.png?raw=true)

  Settings               |             
:-------------------------:|
![](https://github.com/k2288/cattle/blob/master/ss/flutter_04.png?raw=true)|

## iOS Screenshots
Coming soon
## Directory Structure
```
lib
├── components
│   ├── dashboard
│   │   ├── dashboard.dart
│   │   ├── main_dashboard_card.dart
│   │   └── summary_card.dart
│   ├── detail
│   │   ├── detail_card_actions.dart
│   │   ├── detail.dart
│   │   ├── milk_chart.dart
│   │   └── state_dialog.dart
│   ├── list
│   │   ├── filter.dart
│   │   └── list.dart
│   ├── login
│   │   ├── login_page.dart
│   │   └── otp_page.dart
│   ├── newAnimal
│   │   ├── drop_down.dart
│   │   ├── input.dart
│   │   └── new-animal.dart
│   ├── settings
│   │   ├── language.dart
│   │   └── settings.dart
│   └── splash
│       └── splash_page.dart
├── home.dart
├── l10n
│   ├── app_en.arb
│   └── app_fa.arb
├── main.dart
├── models
│   ├── Dashboard.dart
│   ├── livestock.dart
│   ├── LivestockState.dart
│   ├── LocaleModel.dart
│   ├── LoginResponse.dart
│   └── User.dart
├── repositories
│   ├── AuthRepository.dart
│   ├── DashboardRespository.dart
│   ├── LivstockRespository.dart
│   ├── SettingRespository.dart
│   └── UserRepository.dart
├── utils
│   ├── api
│   │   ├── ApiProvider.dart
│   │   ├── CustomException.dart
│   │   └── Response.dart
│   ├── DateUtil.dart
│   ├── PinConfig.dart
│   ├── SettingsProvider.dart
│   └── theme.dart
└── widgets
    ├── confirm_dialog.dart
    ├── fab_bottom_navigation
    │   ├── fab_bottom_app_bar.dart
    │   └── pin_image.dart
    └── PinSnackBar.dart

```

## To Do
- [ ] Add chat and medical section
- [ ] Add notification
- [ ] Complete settings
- [ ] Add Scanning Animal Barcode Functionality

## Pull Requests

I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request.