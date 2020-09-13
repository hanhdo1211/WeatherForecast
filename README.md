# WeatherForecast
A Development Challenge from NAB

## Checklist
1. [x] Programming language: Swift is required, Objective-C is optional.
2. [x] Design app's architecture (recommend VIPER or MVP, MVVM but not mandatory) (use VIPER)
3. [x] UI should be looks like in attachment.
4. [x] Write UnitTests
5. [] Acceptance Tests
6. [x] Exception handling
7. [x] Caching handling
8. [] Accessibility for Disability Supports:
    - [] VoiceOver: Use a screen reader.
    - [x] Scaling Text: Display size and font size: To change the size of items on your screen, adjust the display size or font size.
9. [] Entity relationship diagram for the database and solution diagrams for the components, infrastructure design if any
10. [x] Readme file includes:
      - [x] Brief explanation for the software development principles, patterns & practices being applied
      - [x] Brief explanation for the code folder structure and the key Java/Kotlin libraries and frameworks being used
      - [x] All the required steps in order to get the application run on local computer
      - [x] Checklist of items the candidate has done.

## Requirements
Xcode 11.5
Swift 5.2

## Software development principles, patterns & practices being applied
### Protocol-Oriented Programming
- WeatherSearchAPIServiceProtocol
- WeatherSearchCacheServiceProtocol
- WeatherSearchWireframeProtocol
- WeatherSearchViewProtocol
- WeatherSearchPresenterProtocol
- WeatherSearchInteractorProtocol
- WeatherSearchInteractorOutputProtocol

    Able to change service like Alamofire, AFNetwork for network, PINCache or another for caching
    Able to mock data for unittest

### VIPER
Apply VIPER for this challenge.

### Patterns applied
1. Builder Patterns for create params
```
let params = ParamsBuilder()
    .filterByCity(name)
    .addAppId()
    .addNumberOfDaysReturn()
    .addUnits()
    .build()
```

## Frameworks being used
1. Alamofire: For make request api
2. ObjectMapper: For convert JSON <-> Object
3. SnapKit: For setup Constraints
4. PINCache: For caching, it support memory and disk cache
