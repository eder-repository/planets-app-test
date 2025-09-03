# Planets App test

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart --dart-define=baseUrl=https://us-central1-a-academia-espacial.cloudfunctions.net

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart --dart-define=baseUrl=https://us-central1-a-academia-espacial.cloudfunctions.net

# Production
$ flutter run --flavor production --target lib/main_production.dart --dart-define=baseUrl=https://us-central1-a-academia-espacial.cloudfunctions.net
```

_\*Planets App test works on iOS, Android, Web, and Windows._

---
## Features

- Home screen with entry to the planets list.
- Consumed from the API they sent
- Filter planets by all fields
- Mark planets as favorites.
- Navigation powered by **go_router**.
- Clean architecture by feature and layer.
- Multiple environment support (dev, stg, prod).
- Localization using **slang**.
- Responsive layout for mobile, tablet, and desktop.

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l18n`.

```
{
    "misc": {
       
    }
}
```

2. Then add a new key/value and description

```arb
{
    "misc": {
       
    }
}
```

3. Use the new string

```dart


@override
Widget build(BuildContext context) {
  final texts = context.texts;
  return Text(texts.home.title);
}
```
## Create your environment config


```bash
cp env/env.json.example env/dev.json
```

Example content:

```json
{
    "baseUrl": "your-http-url-here",
  
}



```
this
```
 https://us-central1-a-academia-espacial.cloudfunctions.net

```
---

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```


### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
dart run slang
```

## Makefile 

### Install dependencies
make planets_packages

### Generate code (Freezed/JSON)
make planets_build

### Regenerate translations (slang)
make planets_slang

### Regenerate asset classes(flutter_gen)
make planets_ui_gen



