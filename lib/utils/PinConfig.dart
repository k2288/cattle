/// HTTP host/port for the Nest API (`cattle_backend`) and image URLs.
///
/// Edit [IP] / [PORT] before `flutter run`. Values are compile-time consts.
///
/// | Where the app runs | Suggested [IP] |
/// |--------------------|----------------|
/// | iOS Simulator (API on same Mac) | `127.0.0.1` |
/// | Android emulator (API on host) | `10.0.2.2` |
/// | Physical device on LAN | Mac LAN IP (`ipconfig getifaddr en0`) |
///
/// Nest listens on **`PORT` from `cattle_backend/.env`** (local default **3001**).
/// Mongo env lives in `cattle_backend/.env`. Full steps: see README → **API / PinConfig**.
class PinConfig {
  static const int PORT = 3001;

  /// iOS Simulator + API on same Mac. Use `10.0.2.2` (Android emulator) or LAN IP (device).
  static const String IP = "127.0.0.1";
}
