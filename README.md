<p align="center">
    <img src="https://i.imgur.com/xW2TD5K.png" alt="Logo" width=250 height=250>
</p>

  <h1 align="center">SwiftyMarvel 🦸‍♂️</h1>

<p align="center">
<a href="https://flutter.dev">
  <img src="https://img.shields.io/badge/Platform-SwiftUI-02569R?logo=swift"
    alt="Platform" />
</a>
<a href="https://github.com/Mohanedy98/swifty-marvel/blob/main/LICENSE">
<img src="https://img.shields.io/github/license/aagarwal1012/animated-text-kit?color=red"
alt="License: MIT" />
</a>
<a href="https://codecov.io/gh/Mohanedy98/swifty-marvel">
<img src="https://codecov.io/gh/Mohanedy98/swifty-marvel/branch/main/graph/badge.svg" alt="codecov">
</a>
<a href="https://github.com/Mohanedy98/swifty-marvel/actions/workflows/testing.yml">
<img src="https://github.com/Mohanedy98/swifty-marvel/actions/workflows/testing.yml/badge.svg" alt="Build Status">
</a>
<a href="https://github.com/Mohanedy98/swifty-marvel">
<img src="https://img.shields.io/github/stars/mohanedy98/swifty-marvel.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on Github">
</a>

<br>
SwiftyMarvel is a SwiftUI app that uses the Marvel API to display a list of Marvel characters and their details. You can browse through hundreds of heroes and villains from the Marvel universe, see their comics, and learn more about their powers and abilities.
 <br>
This app is created as a personal project to showcase my skills and passion for iOS development. This app demonstrates how to implement Clean Architecture and some of best practices for iOS app development using SwiftUI, Combine, MVVM, Dependency Injection, Unit Testing, Code Coverage, and more.
    <br>
    <a href="https://github.com/Mohanedy98/swifty-marvel/issues/new">Report bug</a>
    ·
    <a href="https://github.com/Mohanedy98/swifty-marvel/issues/new">Request feature</a>
<br>
</p>


<!-- TOC -->
  * [Screenshots](#screenshots)
  * [Quick start](#quick-start)
  * [Project Structure](#project-structure)
    * [Folder Structure](#folder-structure)
  * [Tools & Frameworks Used](#tools--frameworks-used)
  * [Development Environment](#development-environment)
  * [CI Pipeline](#ci-pipeline)
  * [License](#license)
<!-- TOC -->

## Screenshots

 <img src="https://i.imgur.com/7zaNdE4.png" alt="Splash"  height=350> &nbsp; <img src="https://i.imgur.com/reC3HbH.png" alt="Home"  height=350>
 <img src="https://i.imgur.com/aIA52mv.png" alt="Search while typing"  height=350> &nbsp; <img src="https://i.imgur.com/xp3t1cu.png" alt="Character Profile"  height=350>

## Quick start

As this project uses the Marvel API, you need to get your own API keys to run the project. You can
get them by following these steps:

1. Go to the [Marvel Developer Portal](https://developer.marvel.com/) and create an account.
2. Once you have an account, go to the [Get a Key](https://developer.marvel.com/account) page and
   get your public and private keys.
3. Create a file called `.env` in the root directory of the project and add the following lines to
   it:
    ```shell
    MarvelPublicKey=your_public_key
    MarvelPrivateKey=your_private_key
    ```
4. Run the following command to generate the [ArkanaKeys](https://github.com/rogerluan/arkana) local
   package that will be used to securely
   fetch your keys in runtime:
    ```shell
    bin/arkana
    ```

5. Now you can open the project in Xcode and run it.

## Project Structure

This project uses Clean Architecture and is separated into four main layers:

* **Data**: Holds the data access layer, which contains the repositories responsible for abstracting
  the data source used. In this case, the data source is a REST API, but it could be anything else,
  like a REST API, database, or cache.
* **Domain**: Holds the business logic layer, which contains the use cases responsible for handling
  the business logic of the application and the abstract repositories. The use cases are the entry
  point to the domain layer.
* **Presentation**: Holds the presentation layer, which contains the UI responsible for presenting
  the data to the user and handling user interactions. It also contains the ViewModels, which are
  responsible for preparing the data to be presented and for handling the interactions between the
  view and the use cases.
* **Core**: Holds the core layer, which contains the common code between the other layers, like
  extensions and the dependency injection.

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
| [Swinject](https://github.com/Swinject/Swinject)                                                      | Dependency Injection                                                 |
| [Arkana](https://github.com/rogerluan/arkana)                                                         | Securely storing secrets and keys                                    |
| [Kingfisher](https://github.com/onevcat/Kingfisher)                                                   | Image Caching                                                        |
| [Lint](https://github.com/realm/SwiftLint)                                                            | Project Linting                                                      |
| [Mockingbird](https://github.com/birdrides/mockingbird)                                               | Generating mock, stub, and verify objects in Swift unit tests        |

## Development Environment

* Xcode 14.3.1
* Swift 5.8.1
* iOS Deployment Target 16.2

## CI Pipeline

This project uses [GitHub Actions](https://docs.github.com/en/actions)
and [Codecov](https://docs.codecov.com/docs/codecov-uploader) to automate the building, testing, and
code coverage analysis of the project. The CI pipeline runs whenever a new commit or pull request is
made to the main branch.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

