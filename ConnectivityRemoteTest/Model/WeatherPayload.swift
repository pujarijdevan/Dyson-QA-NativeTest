//
//  Copyright © 2018 Dyson
//

struct WeatherPayload: Codable {
    
    let cityID: Int
    let city: String
    let coordinates: WeatherCoordinates
    let weather: [WeatherInfo]
    let metrics: WeatherMetrics
    
    private enum CodingKeys: String, CodingKey {
        case cityID = "id"
        case city = "name"
        case coordinates = "coord"
        case weather
        case metrics = "main"
    }
}

struct WeatherCoordinates: Codable {
    let longitude: Double
    let latitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

struct WeatherInfo: Codable {
    let description: String
    let icon: String
}

struct WeatherMetrics: Codable {
    let temperature: Double
    let humidity: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
    }
}
