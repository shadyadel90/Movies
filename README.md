# Movies

UIKit technical challenge project that browses TMDb movie lists (Now Playing, Popular, Upcoming), shows movie details, and caches results for offline use.

## Highlights

- UIKit with MVVM and Domain-Driven Design layering
- TMDb networking via `URLSession`
- Core Data offline caching with connectivity checks
- Image download/caching without third-party libraries
- Light and dark mode support
- XCTest coverage for networking and view-model behavior

## Architecture

- **Presentation** — view controllers, view models, cells
- **Domain** — movie entities
- **Infrastructure** — networking, Core Data, constants, connectivity

## API key setup

This repository does not contain an API key.

1. Create a TMDb API key.
2. In Xcode: **Product → Scheme → Edit Scheme → Run → Arguments**.
3. Add environment variable `TMDB_API_KEY` with your local key.
4. Build and run.

Never commit API credentials.

## Tech stack

Swift, UIKit, MVVM, Domain-Driven Design, Core Data, URLSession, XCTest

## Run locally

1. Clone the repository.
2. Open `banquemisr.challenge05.Movies/banquemisr.challenge05.Movies.xcodeproj`.
3. Set `TMDB_API_KEY` in the scheme as above.
4. Build and run on an iOS Simulator.
