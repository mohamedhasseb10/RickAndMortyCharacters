# RickAndMortyCharacters

## Overview

This iOS application demonstrates building a scalable, maintainable, and testable iOS app using **Swift**, **MVVM with Clean Architecture**, **Coordinators**, and **Swift Concurrency**.  
It consumes the [Rick and Morty public API](https://rickandmortyapi.com/documentation) to fetch and display character data with pagination and filtering.

---

## Features

### Characters (Main Feature)
The **Characters** feature provides:
- A paginated list of characters (20 per page).
- Filter by character status: **Alive**, **Dead**, **Unknown**.
- Detailed character information including:
  - Name
  - Image
  - Species
  - Status
  - Gender

This feature is structured into three layers as a single cohesive module:
- **Domain layer:** Business rules, entities, and use cases
- **Data layer:** DTOs, repository, and API integrations for characters.
- **Presentation layer:** ViewModels for the list and details screens, and UI built using UIKit and SwiftUI.

---

## Architecture & Design

### Key Patterns
- **MVVM (Clean Architecture):**  
  - **Domain Layer:** Use cases and entities.  
  - **Data Layer:** DTOs, repositories, and API clients.  
  - **Presentation Layer:** ViewModels and Views.  
- **Coordinator Pattern:** Handles navigation logic, keeping ViewControllers lightweight.
- **Swift Concurrency:** `async/await` for clean, structured asynchronous code.
- **SwiftUI + UIKit Hybrid:**  
  - UIKit for primary flows (lists, navigation).  
  - SwiftUI for reusable smaller components (e.g., cells, filter views).

### Code Organization
- **Core:** Networking, coordinators, shared utilities.
- **Journeys:** 
  - **Characters:** Contains its own `Domain`, `Data`, and `Presentation` layers for both the character list and character details screens.
- **Utils:** Extensions and helpers.

---

## Building & Running

### Prerequisites
- **Xcode:** 15+
- **Swift:** 5.9+
- **macOS:** Monterey or later

### Steps
1. Clone the repository.
2. Open `RickAndMortyCharacters.xcodeproj`.
3. Select the `RickAndMortyCharacters` scheme.
4. Run with `Cmd + R`.

---

## Testing

Unit tests cover core logic such as ViewModels and Use Cases.  

To run tests:
- Select `RickAndMortyCharactersTests` scheme.
- Use `Cmd + U`.

---

## Assumptions & Decisions
- Coordinators are used to decouple navigation from controllers.
- All UI is programmatic (no Storyboards/XIB).
- No third-party libraries, as required.
- Pagination and filtering are handled at the ViewModel/use-case level to keep views passive.
- The **Characters feature** contains all character-related functionality (list and details) in **Domain**, **Data**, and **Presentation** layers as a single module.

---

## Challenges & Solutions

- **Mixing UIKit & SwiftUI:**  
  - Integrated SwiftUI components inside UIKit-based flows for flexibility.
- **Concurrency:**  
  - Used `async/await` to handle API calls without blocking the main thread.
- **Actor Isolation (Swift 6):**  
  - ViewModels and test code annotated with `@MainActor` to ensure thread safety.
- **Clean Architecture Enforcement:**  
  - Maintained strict separation of concerns by ensuring that Views depend on ViewModels only.

---

For any issues or questions, please contact the repository maintainer.
