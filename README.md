# news_app

## SDK and tools

- Flutter 3.27.1
- Java 17

## Running locally

```bash
flutter pub get

# Edit .local.env and set the API key
cp .env.example .local.env

flutter run --dart-define-from-file=.local.env
```

## Key design decisions:

- I've used `bloc` pattern to manage the state of the app. This app can be easily extended to include more features like authentication, user preferences, etc. by adding more blocs.
- I've used `hive` for local storage primarily because it is faster than `shared_preferences` and can store complex objects like custom classes.

## Known issues:

- News API:
  - The API sometimes returns items without a title. I've not handled this case in the code.
  - In some cases the image URL returned by the API is not a valid URL. I've not handled this case in the code (the image will not be displayed).

## Challenges faced:

- Faced some logical issues with the infinite scrolling handling and API handling. Multiple requests were being made to the API when the user scrolled to the bottom of the list. But I was able to fix this by adding a flag to check if the API was already being called.

## Potential areas of improvement:

- I've cached images in temporary directory. This is generally slower than caching in memory. I could use a library like `flutter_cache_manager` to cache images in memory and disk.
- App UX:
  - I could implement a gesture handler to refresh the news list.
  - I could use a drag handler to slide to left or right to navigate to the next or previous news topic.
