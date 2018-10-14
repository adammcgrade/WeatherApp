# WeatherApp
A weather app for iOS that displays forecast information from the Dark Sky API.
The user of this app can view the current, 24 hour and weekly forecasts for 20 locations around the world. The user also has the ability to favourite a forecast. This forecast will conveniently display everytime the app is loaded. 

![](WeatherApp-Demo.gif)

## Technical Info

In order to get this to work on your device or iOS simulator, you will need to create a struct called Secrets with a static constant called ApiKey and assign your Dark Sky api key to this. 

```
struct Secret {
static let apiKey = "YOUR DARK SKY API KEY HERE"
}
```
