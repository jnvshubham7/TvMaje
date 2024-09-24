

# TvMaje

![Screenshots](https://github.com/jnvshubham7/TvMaje/raw/main/screenshot/flutter_01.png)

## Screenshots
<p float="left">
  <img src="https://github.com/jnvshubham7/TvMaje/raw/main/screenshot/flutter_01.png" width="200" />
  <img src="https://github.com/jnvshubham7/TvMaje/raw/main/screenshot/flutter_02.png" width="200" />
  <img src="https://github.com/jnvshubham7/TvMaje/raw/main/screenshot/flutter_03.png" width="200" />
  <img src="https://github.com/jnvshubham7/TvMaje/raw/main/screenshot/flutter_04.png" width="200" />
  <img src="https://github.com/jnvshubham7/TvMaje/raw/main/screenshot/flutter_05.png" width="200" />
</p>

## About TvMaje

TvMaje is a Flutter app that allows users to explore movies and TV shows by fetching data from the [TVMaze API](https://www.tvmaze.com/). Users can browse popular shows, search for specific content, and view detailed information for each show, all within a sleek, Netflix-inspired UI.

## Features

- **Splash Screen**: Displays a themed splash screen while the app loads.
- **Home Screen**: Lists all movies/shows from the TVMaze API with an image thumbnail, title, and summary.
- **Search Functionality**: Users can search for any movie or TV show using a search bar that fetches results from the API.
- **Details Screen**: Provides comprehensive details of a selected movie/show, including an image, summary, and title.
- **Bottom Navigation**: Easy navigation between the Home Screen and Search Screen.

## Screens

### Splash Screen
The splash screen displays an appropriate picture for the theme, welcoming users to the app.

### Home Screen
- Displays a list of all movies and shows using the following API endpoint:
  - `https://api.tvmaze.com/search/shows?q=all`
- Each entry includes:
  - Movie thumbnail
  - Title
  - Summary
- Clicking on any movie directs users to the **Details Screen**.
- A search bar is available at the top, leading to the **Search Screen**.

### Search Screen
- Contains a search bar where users can enter any movie/show title.
- The search queries the following API endpoint:
  - `https://api.tvmaze.com/search/shows?q={search_term}`
- Results are displayed similarly to the Home Screen, showing thumbnails, titles, and summaries.

### Details Screen
- Displays detailed information about a selected movie or show, including:
  - Full image
  - Title
  - Summary
  - Additional details, such as cast and genre (optional).

### Bottom Navigation
- Provides seamless navigation between the **Home Screen** and the **Search Screen**.

## UI Design
The app's design mimics Netflix's modern UI, ensuring a clean and user-friendly experience.

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/jnvshubham7/TvMaje.git
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## API
- All movie and TV show data is fetched from the [TVMaze API](https://www.tvmaze.com/api).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
