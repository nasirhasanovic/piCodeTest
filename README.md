# Posts Viewer - iOS App

A clean, modern iOS application built with SwiftUI that fetches and displays posts from the JSONPlaceholder API.

## Features

- ✅ Fetch posts from REST API (`https://jsonplaceholder.typicode.com/posts`)
- ✅ Display posts with ID < 50 (business logic requirement)
- ✅ Search functionality (searches in both title and body)
- ✅ Multiple sorting options:
  - Title (A-Z)
  - Title (Z-A)
  - ID (Low to High)
  - ID (High to Low)
- ✅ Dark/Light mode toggle
- ✅ Pull-to-refresh
- ✅ Clean, modern UI with card-based design
- ✅ Reusable UI components
- ✅ Error handling with retry functionality
- ✅ Empty state handling
- ✅ Loading states

## Architecture

The app follows **MVVM (Model-View-ViewModel)** architecture with clear separation of concerns for maximum scalability and maintainability.

### Project Structure

```
piCodeTest/
├── Models/
│   ├── Post.swift              # Data model for posts
│   └── SortOption.swift        # Enum for sorting options
├── Network/
│   ├── APIClient.swift         # Generic API client protocol
│   ├── NetworkError.swift      # Network error types
│   ├── PostsService.swift      # Posts-specific service
│   └── FetchRequestState.swift # Loading state management
├── ViewModels/
│   └── PostsViewModel.swift    # Business logic & state management
├── Views/
│   ├── ContentView.swift       # Main view
│   └── PostRowView.swift       # Post list item view
└── UI Components/
    ├── SearchBar.swift         # Reusable search component
    ├── EmptyStateView.swift    # Reusable empty state
    └── ErrorView.swift         # Reusable error display
```

### Architecture Layers

#### 1. Models Layer
Clean data structures with no dependencies on other layers:
- `Post`: Codable model matching API response
- `SortOption`: Enum defining available sorting methods

#### 2. Network Layer
Isolated networking logic with protocol-based design:
- **APIClient Protocol**: Defines contract for network requests
- **URLSessionAPIClient**: Concrete implementation using URLSession
- **PostsService**: Domain-specific service for fetching posts
- **NetworkError**: Typed error handling
- **FetchRepoState**: State machine for async operations

**Key Benefits**:
- Easy to test (can inject mock APIClient)
- Easy to swap implementations
- Clear error propagation
- Reusable across different endpoints

#### 3. ViewModel Layer
Business logic and state management using Combine:
- Manages data fetching and state
- Handles search and sort logic
- Uses `@Published` for reactive updates
- Debounced search (300ms) for performance
- Protocol-based service injection for testability

#### 4. View Layer
SwiftUI views with single responsibility:
- **ContentView**: Main container, coordinates subviews
- **PostRowView**: Individual post display
- **UI Components**: Reusable, parameterized views

### Scalability Features

#### 1. Protocol-Oriented Design
```swift
protocol APIClient {
    func send<T: Decodable>(_ request: URLRequest) async throws -> T
}
```
- Easy to add new endpoints
- Testable with mock implementations
- Decoupled from concrete implementations

#### 2. Dependency Injection
```swift
init(postsService: PostsServiceProtocol = PostsService())
```
- ViewModels don't create their dependencies
- Easy to swap implementations
- Enables unit testing

#### 3. Reusable UI Components
All UI components are parameterized and reusable:
```swift
SearchBar(text: $searchText, placeholder: "Search...")
EmptyStateView(title: "...", message: "...")
ErrorView(title: "...", message: "...") { /* retry */ }
```

#### 4. State Management
Clear state enum prevents invalid states:
```swift
enum FetchRepoState {
    case idle
    case loading
    case success
    case failure(NetworkError)
}
```

#### 5. Reactive Programming
Combine publishers automatically update UI:
```swift
Publishers.CombineLatest($searchText, $sortOption)
    .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
    .sink { /* update */ }
```

### How to Extend

#### Adding a New Endpoint
1. Create model in `Models/`
2. Add service protocol and implementation in `Network/`
3. Create ViewModel using the service
4. Build SwiftUI view

#### Adding a New UI Component
1. Create new file in `UI Components/`
2. Make it generic with parameters
3. Use in any view

#### Adding Tests
1. Mock `APIClient` protocol
2. Inject mock into ViewModel
3. Test business logic independently

## Requirements Met

- ✅ Fetch JSON data via REST API
- ✅ Display list of fetched items
- ✅ Built with SwiftUI
- ✅ Scalable architecture (MVVM + Protocol-oriented)
- ✅ Only displays posts with id < 50

## Code Quality

- **Clear Structure**: Organized folders by responsibility
- **MARK Comments**: Sections clearly marked
- **Naming Conventions**: Descriptive, Swift-style names
- **Single Responsibility**: Each file has one purpose
- **DRY Principle**: Reusable components
- **SOLID Principles**: Protocol-oriented, dependency injection

## Building & Running

1. Open `piCodeTest.xcodeproj` in Xcode
2. Select an iOS Simulator (iOS 18.5+)
3. Press `Cmd + R` to build and run

## Technologies Used

- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming for state management
- **async/await**: Modern concurrency for network calls
- **Protocol-Oriented Programming**: For testability and flexibility

## Future Enhancements

If given more time, I would add:
- Unit tests for ViewModel and Network layer
- UI tests for key user flows
- Offline caching with Core Data
- Pagination for large datasets
- Post detail view with navigation
- Accessibility improvements (VoiceOver, Dynamic Type)
- SwiftUI Previews for all components

## API Reference

- **Base URL**: `https://jsonplaceholder.typicode.com`
- **Endpoint**: `/posts`
- **Documentation**: https://jsonplaceholder.typicode.com/guide/

---

**Developer**: Nasir Hasanovic
**Email**: hasanovicnasir@gmail.com
**Date**: October 2025
