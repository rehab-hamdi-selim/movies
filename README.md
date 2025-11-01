# 🎬 Flutter Movies App (Clean Architecture)

A modern Flutter application built using **Clean Architecture** that fetches popular movies from [The Movie Database API (TMDB)](https://developer.themoviedb.org/reference/movie-popular-list).  
The app supports **Light/Dark themes**, **Pagination**, **Caching**, and **Error Logging**.

## 🧱 Architecture Overview
```
lib/
├── core/
│   ├── constants/
│   │   └── app_colors.dart
│   ├── cubit/
│   │   ├── theme_cubit.dart
│   │   └── theme_state.dart
│   ├── di/
│   │   └── injection.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── app_colors.dart
│
├── features/
│   └── movies/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── movies_remote_data_source.dart
│       │   │   └── movies_local_data_source.dart
│       │   ├── models/
│       │   │   └── movie_model.dart
│       │   └── repositories/
│       │       └── movies_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── movie_entity.dart
│       ├── presentation/
│       │   ├── cubit/
│       │   │   ├── movies_cubit.dart
│       │   │   └── movies_state.dart
│       │   └── pages/
│       │       ├── movies_page.dart
│       │       └── details_screen.dart
│
└── main.dart
```

## 🧰 Tech Stack
| Layer | Technology |
|-------|-------------|
| Architecture | Clean Architecture |
| State Management | Bloc (Cubit) |
| Networking | Retrofit + Dio |
| Model Serialization | json_serializable |
| Dependency Injection | get_it |
| Local Caching | SharedPreferences |
| Image Caching | cached_network_image |
| Theming | ThemeCubit + SharedPreferences |
| UI | ScreenUtil + Google Fonts |
| Error Logging | Custom Error Logger |

## 🌐 API Used
**The Movie Database (TMDB) API**  
Base URL:  
```
https://api.themoviedb.org/3/movie/popular
```
**Parameters:**
- `api_key`: Your TMDB API Key  
- `language`: Default = `en-US`  
- `page`: For pagination  
**Example Request:**  
```
GET https://api.themoviedb.org/3/movie/popular?api_key=YOUR_API_KEY&page=1
```

## 💡 Features
- Fetch and display popular movies  
- Movie details screen  
- Pagination (“Load More” button)  
- Light & Dark theme (persisted with SharedPreferences)  
- Local & image caching  
- Error logging  
- Fully responsive UI using ScreenUtil  
- Organized Clean Architecture structure  

## 🎨 Theming
| Mode | Property | Color |
|------|-----------|--------|
| **Light Mode** | Scaffold | `#FFFFFF` |
|  | AppBar | `#0000FF` |
|  | Movie Card | `#f7f2fa` |
|  | Main Text | `#000000` |
|  | Side Text | `#808080` |
| **Dark Mode** | Scaffold | `#0B0B0B` |
|  | AppBar | `#232227` |
|  | Movie Card | `#231F23` |
|  | Main Text | `#FFFFFF` |
|  | Side Text | `#BFB7BF` |

Theme switching is managed by **ThemeCubit** and saved using **SharedPreferences**:
```dart
IconButton(
  icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
  onPressed: () => context.read<ThemeCubit>().toggleTheme(),
);
```

## 🗃️ Caching Strategy
- Movies Data: Cached in SharedPreferences (keyed by page number)  
- Images: Cached via cached_network_image  
- Theme Preference: Saved under key isDarkMode  
- Error Logs: Recorded via a lightweight ErrorLogger class  

## ⚙️ Dependency Injection
All dependencies are handled via get_it in core/di/injection.dart:
```dart
final sl = GetIt.instance;

Future<void> initDI(SharedPreferences prefs) async {
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(sl()));
  sl.registerFactory(() => MoviesCubit(getPopularMovies: sl()));
  sl.registerFactory(() => ThemeCubit(prefs: sl()));
}
```

## 🏗️ State Management
### ThemeCubit
Handles switching between light and dark mode:
```dart
class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences prefs;
  static const _kIsDark = 'isDarkMode';

  ThemeCubit({required this.prefs})
      : super(ThemeState(isDark: prefs.getBool(_kIsDark) ?? false));

  Future<void> toggleTheme() async {
    final newVal = !state.isDark;
    await prefs.setBool(_kIsDark, newVal);
    emit(ThemeState(isDark: newVal));
  }
}
```
### MoviesCubit
Handles fetching popular movies, pagination, caching, and error states.

## 🚀 Getting Started
1. Clone the repository
```bash
git clone https://github.com/yourusername/movies_app.git
cd movies_app
```
2. Install dependencies
```bash
flutter pub get
```
3. Generate model & retrofit files
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
4. Add your TMDB API Key
Get your API key from The Movie Database and add it to your data source:
```dart
@GET("movie/popular")
Future<MoviesResponse> getPopularMovies(
  @Query("api_key") String apiKey,
  @Query("page") int page,
);
```
5. Run the app
```bash
flutter run
```

## 🧠 Notes
- Clean Architecture ensures scalability and easy maintenance.  
- Caching and theming persist across app restarts.  
- Easily extendable (add search, filters, offline mode, etc.).  

## 🧩 Example Screenshots
Light Mode | Dark Mode  
(Add screenshots here)

## 🔮 Future Improvements
- Search & filtering  
- Offline mode using Hive  
- Unit & widget testing  
- Error analytics dashboard  
- Advanced caching strategy  

## 👩‍💻 Author
**Rehab Hamdy Selim**  
Flutter Developer | Passionate about Clean Architecture & UI Design  
📧 Email: rehab@example.com
