# UalaChallenge

## Architecture:
The architecture is MVVM+Navigator with a builder to handle the responsability of creation of each module. The Details Module contains only a view as no logics were needed. It's intanitiated is done also through a builder.

## Layout
All UI is done through SwiftUI views according to the challenge rules.

## Navigation
Navigation is done using UINavigationController and a CustomHostingController to synchronize SwiftUI views.
This is thought as per SwiftUI Navigation still has some issues and lack of certain behaviours. Also because in the end, the SwiftUI NavigationStack uses UINavigationController for handling the navigation.

## Reusable components
ErrorView and LoaderView were customizable components created and able to be reused all over the app.  

## Network request:
Async Await used for the network layer through a Provider.

## Third party libraries:
No third party libraries were used on the app. Therefore no package manager is used either.

## Caching:
NSCache was used for caching the responses on memory. This helps the app performance to avoid unnecesary requests and give the user a best experience avoiding delays.

## Persistance:
UserDefaults is used for persistance. As no heavyweight persistance is needed I considered as an overkill to use CoreData or SwiftData.

## Testing
Unit tests were added for the HomeModule and specifically for the viewModel which contains all the logics for the module. The provider was subbed with a mocked response.
