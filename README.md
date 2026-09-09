# Product Store

A small Flutter shopping app that displays products from the Fake Store API, with search, product details, favorites, and a cart.

## Features

- Product grid with images, titles, prices, ratings, and favorite icons.
- Search by title and filter by category.
- Product detail screen with the full description.
- Add to cart, update quantities, remove items, and view the total.
- Favorites saved locally using SharedPreferences.
- Pull-to-refresh to fetch fresh products.
- Automatic local pagination as you scroll.
- Loading, error with retry, and empty states.

## Run the app

Use Flutter with Dart 3.13.2 or a compatible newer 3.x version. The current lockfile requires Flutter 3.44.0 or newer.

From the project folder, run:

```sh
flutter pub get
flutter run
```

Connect a device or start an emulator first. Internet access is required to load products and images. No API key is needed.

## API

Products come from `https://fakestoreapi.com/products`.

The app fetches the catalog using Dio. Search and category filtering happen locally. Pagination displays eight products at a time from the fetched list; it does not make a new API request for each page. Pull-to-refresh fetches the catalog again.

## Structure and choices

The app uses a **feature-first architecture with data and presentation layers**, using Cubit for state management. It is a lightweight layered structure without a separate domain layer.

```text
lib/
├── main.dart
├── app/                      # App setup and navigation
├── core/                     # Shared code
│   ├── constants/
│   ├── error/
│   ├── network/
│   └── widgets/
└── feature/
    ├── products/
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   └── repositories/
    │   └── presentation/
    │       ├── cubit/
    │       ├── filter_data/
    │       ├── pages/
    │       └── widgets/
    ├── cart/
    │   ├── data/models/
    │   └── presentation/
    │       ├── cubit/
    │       ├── pages/
    │       └── widgets/
    └── favorites/
        └── presentation/
            ├── cubit/
            └── pages/
```

- **Data:** API access, models, and repositories.
- **Presentation:** screens, reusable feature widgets, and Cubit state management.
- **Core:** styling, networking, errors, and widgets shared across features.
- **App:** application configuration and routing.

Each feature includes only the layers it currently needs. Favorites persistence currently lives in `FavoriteCubit`.

Dio handles API requests, GoRouter handles navigation, and SharedPreferences stores favorite product IDs.

## State management — Bloc/Cubit

The app uses **Cubit from the `flutter_bloc` package**. Widgets call Cubit methods, which update state, and `BlocBuilder` rebuilds the UI to reflect those changes. `MultiBlocProvider` in `main.dart` makes the Cubits available across screens.

- **ProductCubit:** loads products and manages search, category filters, refresh, and pagination. Its states are initial, loading, loaded, and error; an empty loaded list shows the empty view.
- **CartCubit:** handles adding/removing products and changing quantities. Cart state exposes the items, total quantity, and total price.
- **FavoriteCubit:** toggles favorite product IDs and saves/restores them using SharedPreferences.

Cubit keeps application logic separate from widgets and is easy to test. Its direct method calls suit this small app without needing separate Bloc event classes.

## Assumptions and limitations

- The greeting, offers, and category icons are static. Offers do not change prices.
- Some category tabs may have no matching products in the API.
- I adapted the reference design to suit tablet screens, placing offers and categories side by side on wider layouts and allowing the product grid to adjust its column count to the available width.
- Cart data lasts for the current app session; favorites persist between launches.
- Checkout, Orders, Wallet, and Profile are placeholders and outside the core assignment scope.
- The product card's “sold” badge currently uses the API rating count.

With more time, I would refine the layout against the reference and add more tests for cart, favorites, and error handling.

## Tests

Run the pagination tests with:

```sh
flutter test test/product_pagination_test.dart
```

These cover page boundaries, filtering, and refresh. The original counter test in `test/widget_test.dart` is outdated and still needs replacement.
