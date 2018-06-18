# KitchenWares
Dishwashers served in a VIPER stack.

### Prerequisites

* Built with Xcode 9.4.1/iOS 11.4
* Cocoapods

### Installing

* clone the project
* cd into the top level directory
* punch this in `pod install`
* open  KitchenWares.xcworkspace in Xcode
* build, test, and aun 


## Assumptions
  - Code completeness was preffered over feature completeness.
  - Custom implementations were preffered over third party libraries
  - VIPER was chosen as the architecture to showcase
  
## Decisions
* TDD was used throughout. Red tests were commited before implementations.
* Git flow was used to work in a separate branch until it was ready to merge in.
* Routers, Presenters, Interactors, and Services deserve tests, Views and ViewControllers do not.
* Although trivial in this example, the model types and display types were kept distinct. `ProductId` and `ShopItem` were converted to  `identifier:String`  and `ShopItemDisplayable` for the view.
* The division between code paths for ipad and iphone was kept to a minimum.

* Pods:

   - In the end, the only Pod that survived the cut was SwiftLint, which I find speeds up development as it is easier to write syntactically clean code first time round, and catch occasional errors such unused variables, or using `var` when `let` will do.

   - The Result pod would have led to cleaner interfaces, however for this small, (nearly) podless demo, Tuples of `(<T?>, <Error?>)` were returned throughout. 
  
   - The simplest possible JSON parser was used: direct manipulation of the Dictionary. Codable or SwiftyJson would definitely have been good choices here too.
  
  -  Swinject would have been a nice choice for Dependency injection. Instead of using full on dependency injection, an injected factory was used to keep constructor sizes reasonable.
  
## Some Notes About The Code
   - Occasionally, expectations were used to test synchronous code. When the value associated type of an enum needs testing, the ` if case let else ` paradigm doesn't lend itself to readable test code quite like `expection.fulfill()`
   -  ItemFetcher has a very basic image cache so that reappearing cells don't ask the backend multiple times for the same image
   - The safe area was used to keep the dishwasher content away from the iphone X notch.
   - URLSession gets reclaimed in FoundationExtensions.swift so that it can be mocked and injected into the `ItemFetcher`
   
   
## Improvements
 
 - The details screen `(ProductDetails)` was not built for this demo due to time constraints.
 - There is room to make the ShopAisleViewController do even less, by delegating all lookups to the `[ShopItemDisplayable]` to the presenter.
 - There could be a placeholder image and a loading indicator on the dishwasher images as they load
 - An alert system could be built to show human readable errors.
 - There are a few silent failures in the form of  `guard let else return`  which could be handled given a chosen Alert / Logging system. 
 - Reachability would work nicely to show an appropriate message to the user while offline, and to react to a regained connection
 - JohnLewisURLConstructor could take arguments to construct URLs rather than return hardcoded values
 - UITests would work nicely as either a high level test of the entire app or - as it is so often (mis)used - as an integration test with the server.
 - A pretty launch screen and logo would be nice!
