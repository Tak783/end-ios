# END Listings iOS

Important things to know
* Unit/integration tests were mostly written services and view models, - please see inside the package test folders -
* Where you see for example `RemoteENDProductModel` and `ENDProductModel` this is done to:
  * to adhere to Single Responsibility in SOLID - the model should do only one thing
  * stop large objects that are hard to maintain from being created i.e. mixing CoreData and Codable)
  * maximise flexibility and maintainability, all of these adhere to a protocol
* Used swift packages I built in previous projects for Networking, Testing and common extensions i.e. to Foundation, for speed
* Test doubles are used i.e Stub, Spy and Mock to provide a way to isolate the code in the test from its dependencies or production code - pure unit tests
* Unit and Integration tests were written using TDD. More could be written especially for the UI layer. Wrote only fundamental tests.
* Closure-based binding was used for bindings with the MVVM architecture, other options not used were Combine, KVO and property observers
* Imperative commit style was written for commits with detail where appropriate, other ways are valid too.
* Please read below to understand the architecture logic and reasoning behind this approach
* This is one approach, other approaches are possible too depending on the project and team
* This approach applied here focused on practicality, pragmaticism and maintainability. It has been applied successfully in previous roles.
* Below are explanations for the approach and an architectural diagram

## Overview 

### Architecture 
* The App is built on top of five Platform-Agnostic Layers with Swift Packages
* Platform-agnostic layer packages can be used by either UIKit, SwiftUI WatchOS etc
* Each layer can import *only* from the layers below (Vertical Dependency usage)
* Lowest-level layer has Foundational components (i.e. extensions to Foundation)
* The highest level hosts the Presentation Layer which contains the iOS app.
* Please read "#Architectural decisions" and "#Platform agnostic components" sections for reasoning

<img width="1280" alt="Architecture" src="https://github.com/user-attachments/assets/624520a7-19dc-4764-8368-947b3c82c1d7">

### Platform agnostic components
The app is built with platform-agnostic components for the following reasons.
* Easily use in Mac, iOS, iPadOS, WatchOS apps using either UIKit, WatchKit or SwiftUI
* Highly *reusable* components that can easily be used to support other feature layer components and Presentation Layer Application targets
* Faster *build times* for tests, testing suites and projects locally and on pipelines. 
* Easier *collaboration* between teams (everything does not happen in one place)
* Easily use new technologies i.e. SwiftUI or Combine
* Built with Consideration for *open source* capability and *demo apps* as layer components are independent and rely on abstractions rather than concrete implementation.

### Design and Development 
* Applied SOLID principles and with relatively extensive unit and integration testing suite in core areas. The rest of the UITests can come.
* App Built-in a TDD way, to ensure the functionality works as expected, protecting from regressions 
* Development *Focus* was on functionality, Architecture, Testing and engineering of highly reusable platform-agnostic components used in the presentation app target rather than the UI or UX. 

## Architectural decisions 

### Layers (overview)
* As seen in the overview, the app has Four layers: Core, LiteBank, Feature and Application Target layer
* Vertical dependencies: each layer contains modules used as dependencies by higher-level modules. Modules can be imported only from the layers below. 
* Each module lives in its own independent project with as few dependencies as possible and contains its own tests, this way each feature can be
   *  Built-in isolation without building the entire Presentation Layer Target 
   *  Be highly reusable, open sourceable and able to be used in demo apps
   *  Be platform agnostic usable in any presentation application target platform

### Core Layer (explained)
Contains foundational shared frameworks to be shared across multiple presentation layer app targets i.e. business and retail 
* CoreFoundational: contains extensions to the `Foundation` framework. These are used across Feature frameworks and the app.
* CoreTesting: contains extensions and helpers for XCTest to support the testing suites in higher-level layers

### Core Shared Components Layer (explained)
* CoreNetworking: contains the networking layer
* MockNetworking: has supporting components used for mocking the networking layer during Unit and Integration tests

### Core END Layer (explained)
Contains END-specific components (share across apps)
* CoreENDSharedModels: Core models/interfaces to be used for END

### Core Feature Layer Presentation Layer Helpers (explained)
Contains platform-agnostic components and extensions used by higher layers to support their uses in the presentation layer
* CoreFeatureLayerPresentationHelpers: Does the above

### Feature Business Logic Layer (explained)
Contains Feature level Businesss logic for framework modules containing features. Frameworks have API, Service and Presentation Layers.
* Account Feature: Accounts Feed, Create New Savings Goal, Add To Savings Goal
* Savings Goal Feature: Savings Goal Feed, Create New Savings Goal, Add To Savings Goal

### Core Presentation (explained)
* CoreUIKit: contains extensions to the `UIKit` framework.
* CorePresentation: Contains Navigational components i.e. the coordinators and alerts, components core to the presentation layer. These can be used for UIKIt and SwiftUI etc.
  
### App Presentation Layer (explained)
Application Layer: Where apps Mac, iOS, iPadOS, Watch OS projects and exist and present feature-level components. The apps are supported by lower level components.
* RoundUp app: App for saving based on round-up of weekly transactions

## Improvements 

### Must Have Changes
* Integration tests for view controllers and UIViews
* Core Networking package to use Async Await
    * This would make the networking layer more up-to-date with current iOS trends
    * The one in place is fully unit tested hence its use over other packages I have for Async Await
* Architecture update to use more inversion of control as part of the Single Responsibility Principle (SRP)
    * Composers would be the bridges between packages that interact together instead of the View Controllers
    * The above would lead to better application of the SRP as the VC would only consume the objects leaving creation and injection to the composer
* Project Updates
    * Add Swift Lint to enforce a style
    * Make all testing suites run tests in parallel to make sure tests run successfully without order dependencies 
* Add Feature specific string files for each feature so that each feature comes ready out of the box to have a presentation layer added
* Add rest of UITesting Suite UITests
* Polish of iOS app including localisation and accessibility considerations

### Should
* Feature UI Layer
  * Move feature UI code away from the iOS app to their own independent packages so they can be more independent which would lead to
    * Faster test times and development times, ability to create and use Demo Apps
    * Better application of SRP, Open Closed, and Dependency Inversion
    * More modularity as we can more easily remove them from the app or switch the internals of the package i.e. from UIKit to SwiftUI
*  Add a new Mock data `CoreTesting` to a new  `XFeatureTesting` framework or a shared mock data package
