# Banquemisr.challenge05

 Features
 ==============
 
 1.	API-Powered: The app integrates with the TMDb API to fetch movie data.
 2.	Movie Details View: When users select a movie, they can view its detailed information.
 3.	Offline Caching: When there is no internet connection, the app retrieves data from cached memory, ensuring a smooth offline experience.



 ## Notable Points:
 
 - Light and Dark Mode Support: The UI adapts to both light and dark modes.
 - No External Libraries: You’ve built the app without using third-party libraries like Cocoapods, Carthage, or SPM.
 - Connection Check for Offline Caching: The app monitors the internet connection to determine whether to fetch data online or use cached data.
 
 Technical Implementation: 
 ==============
 
  1.	Network Layer: A simple request manager handles data fetching from the API.
  2.	Image Caching: Extensions are used to download and cache images efficiently, without relying on external frameworks.
  3.	UIKit: The app is built using UIKit rather than SwiftUI.
  4.	MVVM & Domain-Driven Design: You’ve structured the app to be maintainable and reusable by using the MVVM pattern combined with Domain-Driven Design principles.
  5.	Apple Libraries Only: No third-party dependencies—relying solely on Apple’s frameworks.
  6.	Unit Tests: Unit tests have been implemented to ensure code reliability.
  7.	Core Data: Used for offline caching to persist data when the app is offline.

 

