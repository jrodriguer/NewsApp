# NewsApp

NewsApp is a SwiftUI-based news reader application that fetches top headlines and news articles from various categories using the [NewsAPI](https://newsapi.org/). The application follows the MVVM pattern and adheres to clean architecture principles to maintain organized and modular code.

## Features

- **Top Headlines:** View the latest top headlines.
- **Categories:** Browse news articles by different categories.
- **Favorites:** Add articles to your favorites for quick access.
- **Search:** Search for specific news articles.
- **Smooth UI:** Modern and smooth user interface built with SwiftUI.
- **MVVM Architecture:** Separation of concerns with a clear MVVM structure.
- **Clean Architecture:** Organized codebase with business logic and UI separated.

## Project Structure

The project is divided into different modules to ensure a clean and maintainable codebase:

- **Business Logic:**
  - **ViewModels:** Manages the data and business logic for the views.
  - **Models:** Represents the data structures used in the app.
  - **Services:** Handles the network requests and data fetching from NewsAPI.

- **UI:**
  - **Views:** SwiftUI views that make up the user interface.
  - **Components:** Reusable UI components.

## MVVM Architecture

The application follows the Model-View-ViewModel (MVVM) pattern:

- **Model:** Represents the data structures (e.g., `Article`, `Category`).
- **View:** SwiftUI views that display the data (e.g., `HomeView`, `ArticleView`).
- **ViewModel:** Handles the business logic and data transformation (e.g., `ArticlesViewModel`, `FavoritesViewModel`).

## Getting Started

### Prerequisites

- **Xcode 12 or later**
- **Swift 5.3 or later**
- **CocoaPods (for dependency management)**

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/NewsApp.git
   cd NewsApp
   ```
2. **Install dependencies:**
   Following Swift Package Manager.

3. **Open the project:**
   Open the NewsApp.xcworkspace file in Xcode.

5. **Set up API Key:**
  Obtain an API key from NewsAPI and add it to your project. Create a file named ApiKeys.swift in your project and add the following:
  ```swift
  struct ApiKeys {
    static let newsApiKey = "YOUR_NEWSAPI_KEY"
  }
  ```
5. **Build and Run:**
   Select your target device or simulator and press Cmd + R to build and run the project.


   
