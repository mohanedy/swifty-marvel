<p align="center">
    <img src="https://i.imgur.com/xW2TD5K.png" alt="Logo" width=250 height=250>
</p>

  <h1 align="center">SwiftyMarvel 🦸‍♂️</h1>

<p align="center">
<a href="https://developer.apple.com/xcode/swiftui/">
  <img src="https://img.shields.io/badge/Platform-SwiftUI-orange?logo=swift"
    alt="Platform" />
</a>
<a href="https://github.com/Mohanedy98/swifty-marvel/blob/main/LICENSE">
<img src="https://img.shields.io/github/license/aagarwal1012/animated-text-kit?color=red"
alt="License: MIT" />
</a>
<a href="https://github.com/Mohanedy98/swifty-marvel">
<img src="https://img.shields.io/github/stars/mohanedy98/swifty-marvel.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on Github">
</a>
<a href="https://codecov.io/github/mohanedy/swifty-marvel">
<img src="https://codecov.io/github/mohanedy/swifty-marvel/graph/badge.svg?token=QVKW1V2G2A" alt="codecov">
</a>
<a href="https://github.com/Mohanedy98/swifty-marvel/actions/workflows/testing.yml">
<img src="https://github.com/Mohanedy98/swifty-marvel/actions/workflows/testing.yml/badge.svg" alt="Build Status">
</a>

<br>
SwiftyMarvel is a SwiftUI app that uses the Marvel API to display a list of Marvel characters and their details. You can browse through hundreds of heroes and villains from the Marvel universe, see their comics, and learn more about their powers and abilities.
 <br>
 <br>
This app is created as a personal project to showcase my skills and passion for iOS development. This app demonstrates how to implement Clean Architecture and some of best practices for iOS app development using SwiftUI, CoreData, Combine, MVVM, Dependency Injection, Unit Testing, Code Coverage, and more.
    <br>
    <a href="https://github.com/Mohanedy98/swifty-marvel/issues/new">Report bug</a>
    ·
    <a href="https://github.com/Mohanedy98/swifty-marvel/issues/new">Request feature</a>
<br>
</p>

<!-- TOC -->

- [Screenshots](#screenshots)
- [Quick start](#quick-start)
- [Project Structure](#project-structure)
  - [Folder Structure](#folder-structure)
- [Tools \& Frameworks Used](#tools--frameworks-used)
- [Development Environment](#development-environment)
- [CI Pipeline](#ci-pipeline)
- [License](#license)

<!-- TOC -->

## Screenshots

<img src="https://i.imgur.com/7zaNdE4.png" alt="Splash"  height=350> <img src="https://i.imgur.com/weyzrK3.png" alt="Home"  height=350> <img src="https://i.imgur.com/MNAP73r.png" alt="Search while typing"  height=350> <img src="https://i.imgur.com/385wJN3.png" alt="Favorites"  height=350> <img src="https://i.imgur.com/taEiix2.png" alt="Character Profile"  height=350>

## Quick start

As this project uses the Marvel API, you need to get your own API keys to run the project. You can
get them by following these steps:

1. Go to the [Marvel Developer Portal](https://developer.marvel.com/) and create an account.
1. Once you have an account, go to the [Get a Key](https://developer.marvel.com/account) page and
   get your public and private keys.
1. Create a file called `.env` in the root directory of the project and add the following lines to
   it:

    ```shell
    MarvelPublicKey=your_public_key
    MarvelPrivateKey=your_private_key
    ```

1. Install the [Arkana](https://github.com/rogerluan/arkana) gem by running the following command in your terminal:

    ```shell
    bundle install
    ```

    > You must have ruby and bundler installed on your machine to run the above command. If you don't have them, you can install them by following the instructions [here for Ruby](https://www.ruby-lang.org/en/documentation/installation/) and [here for Bundler](https://bundler.io/).

1. Run the following command to generate the [ArkanaKeys](https://github.com/rogerluan/arkana) local
   package that will be used to securely
   fetch your keys in runtime:

    ```shell
    bin/arkana
    ```

1. After generating the ArkanaKeys package, you will need to add it to the project. To do this:
    - open the `SwiftyMarvel.xcodeproj` file in Xcode, then go to `File > Add Package Dependencies > Add Local...` and select the `ArkanaKeys/ArkanaKeys` folder that was generated in the root directory of the project.
    - Make sure to add `SwiftyMarvel` to the target.

1. Now you can run the project in Xcode.

## Project Structure

This project uses Clean Architecture and is separated into four main layers:

- **Data**: Contains the repositories implementations responsible for abstracting
  the data source used. In this case, the data sources are a REST API and a Core Data database.
- **Domain**: Holds the business logic layer, which contains the use cases responsible for handling
  the business logic of the application and the abstract repositories. The use cases are the entry
  point to the domain layer.
- **Presentation**: Contains the UI responsible for presenting the data to the user and handling
  user interactions. It also contains the ViewModels, which are
  responsible for preparing the data to be presented and for handling the interactions between the
  view and the use cases.
- **Core**: Contains the common code between the other layers, like the extensions and the dependency
  injection code.

### Folder Structure

```markdown
📦SwiftyMarvel
┣ 📂Core
┃ ┣ 📂DI
┃ ┗ 📂Extensions
┣ 📂Data
┃ ┣ 📂Constants
┃ ┣ 📂DataSource
┃ ┣ 📂Model
┃ ┣ 📂Mappers
┃ ┣ 📂Networking
┃ ┗ 📂Repository
┣ 📂Domain
┃ ┣ 📂Entity
┃ ┣ 📂Errors
┃ ┣ 📂Repository
┃ ┗ 📂UseCase
┣ 📂Presentation
┃ ┣ 📂Core
┃ ┣ 📂ReusableViews
┃ ┣ 📂Screens
┃ ┃ ┣ 📂Home
┃ ┃ ┃ ┣ 📂ViewModels
┃ ┃ ┃ ┗ 📂Views
┗ 📜SwiftyMarvelApp.swift => The app entry point.
```

## Tools & Frameworks Used

| Tool                                                                                                  | Used for                                                             |
|-------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|
| [MVVM](https://www.hackingwithswift.com/books/ios-swiftui/introducing-mvvm-into-your-swiftui-project) | Architectural design pattern for separating the logic form the views |
| [Core Data](https://developer.apple.com/documentation/coredata/)                                      | Storing favorite characters                                          |
| [Swinject](https://github.com/Swinject/Swinject)                                                      | Dependency Injection                                                 |
| [Arkana](https://github.com/rogerluan/arkana)                                                         | Securely storing secrets and keys                                    |
| [Nuke](https://github.com/kean/Nuke)                                                                  | Image Loading & Caching                                              |
| [SwiftLint](https://github.com/realm/SwiftLint)                                                       | Code Linting                                                         |
| [Mockingbird](https://github.com/birdrides/mockingbird)                                               | Generating mock, stub, and verify objects in Swift unit tests        |
| [Swift Testing Framework](https://developer.apple.com/documentation/testing)   | Unit Testing Framework                                              |

## Development Environment

- Xcode 26.0
- Swift 6.2
- iOS Deployment Target 26.0

## CI Pipeline

This project uses [GitHub Actions](https://docs.github.com/en/actions)
and [Codecov](https://docs.codecov.com/docs/codecov-uploader) to automate the building, testing, and
code coverage analysis of the project. The CI pipeline runs whenever a new commit or pull request is
made to the main branch.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
