Cattle Management App written in Flutter. It uses NestJS as backend ([cattle_backend](../cattle_backend), upstream [cattle-back](https://github.com/arsarsars1/cattle-back)) and also a design implementation of [Best Cattle Management App](https://dribbble.com/shots/10497109-Best-Cattle-Management-App) and [Cow milk](https://dribbble.com/shots/13081526-Cow-milk) as app launcher.

## API / PinConfig

The Flutter client does **not** read `.env` for the API base URL. All HTTP calls and remote images use [`lib/utils/PinConfig.dart`](lib/utils/PinConfig.dart):

```dart
class PinConfig {
  static const int PORT = 3001;
  static const String IP = "127.0.0.1"; // iOS Simulator default
}
```

`ApiProvider` builds `http://$IP:$PORT/...` (see `lib/utils/api/ApiProvider.dart`). Requests time out after **5 seconds**; if the host is unreachable, splash shows a “No Internet connection” snackbar and opens the **login** shell. With a valid stored token and a successful `GET /v1/users/me`, splash opens **home** instead.

### Point at local `cattle_backend`

1. Start MongoDB and set `cattle_backend/.env` (`MONGO_*`, `jwtPrivateKey`, `PORT=3001`, …).
2. From `cattle_backend` (Node **20**): `npm install` then `npm run start:dev` → **http://127.0.0.1:3001** (Swagger `/api`).
3. Defaults in `PinConfig` already match local Nest (`127.0.0.1` / `3001`). Override only if needed:
   - **iOS Simulator:** `127.0.0.1`
   - **Android emulator:** `10.0.2.2`
   - **Physical device:** your Mac’s LAN IP (`ipconfig getifaddr en0`)
4. Keep `PinConfig.PORT` equal to `cattle_backend` `PORT` (default **3001**).
5. iOS already allows local HTTP via `NSAllowsLocalNetworking` in `ios/Runner/Info.plist`.
6. `flutter run` on the simulator/device.

Without a reachable API, the expected offline smoke path is still: **splash → login**.

### Local OTP (no SMS)

Phone auth expects an Iranian number (`@IsPhoneNumber('IR')`), e.g. `+989121234567`. The API stores the 6-digit code in Mongo and does **not** return it in the HTTP response; SMS needs a valid `ghasedak_api_key`.

Read the latest code after `POST /v1/auth/phone`:

```bash
mongo -u root -p password --authenticationDatabase admin pin --quiet --eval \
  'db.authcodes.find().sort({_id:-1}).limit(1).forEach(function(d){print(d.code)})'
```

Or with Homebrew Mongo 4.4 shell path if `mongo` is not on `PATH`. Enter that code on the OTP screen (or `POST /v1/auth/code` with `{"phone":"...","code":"..."}`). Backend contract smoke uses the same lookup: `npm run smoke:v1` in `cattle_backend`.

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
