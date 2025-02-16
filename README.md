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
- I've added theme selection to make the app more user-friendly.

## Known issues:

- News API:
  - The API sometimes returns items without a title. I've not handled this case in the code.
  - In some cases, the image URL returned by the API is not a valid URL. These scenario can't be handled because this is a 3rd party API & handling it may lead to non-standard documents.
- News caching logic:
  - Search results are being cached for an indefinite period. I could add a cache expiry time to clear the cache after a certain period.

## Challenges faced:

- Faced some logical issues with the infinite scrolling handling and API handling. Multiple requests were being made to the API when the user scrolled to the bottom of the list. But I was able to fix this by adding a flag to check if the API was already being called.

## Potential areas of improvement:

- Images are currently being cached in the application's temporary directory, which is slower than caching in memory. A library like `flutter_cache_manager` can be used to cache images in memory and disk efficiently.
- App UX:
  - Implementing a gesture handler to refresh the news list (and cache already fetched news) by pulling down the list.
  - Implementing a drag handler to slide to left or right to navigate to the next or previous news topic.
  - Provide ability to clear initially searched keywords.
- Error handling could be more robust. Currently, for any API error, the app shows a generic error message. We could show more specific error messages based on the error code.
