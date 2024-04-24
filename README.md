# Sweater Weather
This is the final project for Turing's Mod 3 backend program.<br>
[Project Requirements](https://backend.turing.edu/module3/projects/sweater_weather/requirements)

## Endpoints
<details>
<summary><b>City's Weather</b></summary>

Request:
```http
GET /api/v0/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```

Response: 
`status: 200`

```json
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "last_updated": "2024-04-22 04:45",
        "temperature": 50.9,
        "feels_like": 48.9,
        "humidity": 37,
        "uvi": 1.0,
        "visibility": 9.0,
        "condition": "Partly cloudy",
        "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
      },
      "daily_weather": [
        {
          "date": "2024-04-22",
          "sunrise": "06:11 AM",
          "sunset": "07:46 PM",
          "max_temp": 76.1,
          "min_temp": 48.1,
          "condition": "Partly Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
        },
        {
          "date": "2024-04-23",
          "sunrise": "06:10 AM",
          "sunset": "07:47 PM",
          "max_temp": 63.8,
          "min_temp": 47.4,
          "condition": "Patchy rain nearby",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png"
        },
        {
          "date": "2024-04-24",
          "sunrise": "06:09 AM",
          "sunset": "07:48 PM",
          "max_temp": 75.1,
          "min_temp": 45.8,
          "condition": "Patchy rain nearby",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png"
        },
        {
          "date": "2024-04-25",
          "sunrise": "06:07 AM",
          "sunset": "07:49 PM",
          "max_temp": 74.5,
          "min_temp": 52.0,
          "condition": "Sunny",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "date": "2024-04-26",
          "sunrise": "06:06 AM",
          "sunset": "07:50 PM",
          "max_temp": 66.4,
          "min_temp": 53.6,
          "condition": "Partly Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
        }
      ],
      "hourly_weather": [
        {
          "time": "00:00",
          "temperature": 51.1,
          "conditions": "Partly Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
        },
        {
          "time": "01:00",
          "temperature": 50.5,
          "conditions": "Partly Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
        },
        {
          "time": "02:00",
          "temperature": 50.0,
          "conditions": "Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/119.png"
        },
        {
          "time": "03:00",
          "temperature": 49.6,
          "conditions": "Overcast ",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/122.png"
        },
        {
          "time": "04:00",
          "temperature": 50.9,
          "conditions": "Partly cloudy",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
        },
        {
          "time": "05:00",
          "temperature": 48.6,
          "conditions": "Overcast ",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/122.png"
        },
        {
          "time": "06:00",
          "temperature": 48.6,
          "conditions": "Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/119.png"
        },
        {
          "time": "07:00",
          "temperature": 50.7,
          "conditions": "Partly Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
        },
        {
          "time": "08:00",
          "temperature": 55.2,
          "conditions": "Sunny",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "09:00",
          "temperature": 60.7,
          "conditions": "Sunny",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "10:00",
          "temperature": 65.5,
          "conditions": "Sunny",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "11:00",
          "temperature": 69.0,
          "conditions": "Sunny",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "12:00",
          "temperature": 71.9,
          "conditions": "Partly Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
        },
        {
          "time": "13:00",
          "temperature": 74.0,
          "conditions": "Overcast ",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/122.png"
        },
        {
          "time": "14:00",
          "temperature": 74.7,
          "conditions": "Overcast ",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/122.png"
        },
        {
          "time": "15:00",
          "temperature": 74.3,
          "conditions": "Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/119.png"
        },
        {
          "time": "16:00",
          "temperature": 72.8,
          "conditions": "Partly Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
        },
        {
          "time": "17:00",
          "temperature": 71.6,
          "conditions": "Partly Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
        },
        {
          "time": "18:00",
          "temperature": 69.3,
          "conditions": "Partly Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
        },
        {
          "time": "19:00",
          "temperature": 66.9,
          "conditions": "Sunny",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        {
          "time": "20:00",
          "temperature": 64.3,
          "conditions": "Partly Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
        },
        {
          "time": "21:00",
          "temperature": 62.8,
          "conditions": "Clear ",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        {
          "time": "22:00",
          "temperature": 61.0,
          "conditions": "Partly Cloudy ",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
        },
        {
          "time": "23:00",
          "temperature": 59.5,
          "conditions": "Clear ",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
        }
      ]
    }
  }
}
```
</details>

<details>
<summary><b>User Registration</b></summary>

Request:
```http
POST /api/v0/users
Content-Type: application/json
Accept: application/json
```

Body:
```json
{
  "email": "unknown@email.com",
  "password": "the_most_secure_password",
  "password_confirmation": "the_most_secure_password"
}
```

Response: `status: 200`
```json
{
  "data": {
    "id": "1",
    "type": "users",
    "attributes": {
      "email": "unknown@email.com",
      "api_key": "ea2f6e7441fab8aa96f1611a0361c60d"
    }
  }
}
```
</details>

<details>
<summary><b>User Login</b></summary>

Request:
```http
POST /api/v0/sessions
Content-Type: application/json
Accept: application/json
```

Body:
```json
{
  "email": "unknown@email.com",
  "password": "the_most_secure_password"
}
```

Response: `status: 200`
```json
{
  "data": {
    "id": "1",
    "type": "users",
    "attributes": {
      "email": "unknown@email.com",
      "api_key": "ea2f6e7441fab8aa96f1611a0361c60d"
    }
  }
}
```
</details>

<details>
<summary><b>Road Trip Details</b></summary>

Request
```http
POST /api/v0/road_trip
Content-Type: application/json
Accept: application/json
```

Body:
```json
{
  "origin": "Cincinatti,OH",
  "destination": "Chicago,IL",
  "api_key": "ea2f6e7441fab8aa96f1611a0361c60d"
}
```

Response
```json
{
  "data": {
    "id": null,
    "type": "road_trip",
    "attributes": {
      "start_city": "Cincinatti,OH",
      "end_city": "Chicago,IL",
      "travel_time": "4 hrs 20 min",
      "weather_at_eta": {
        "datetime": "2024-04-24 15:00",
        "temperature": 41.8,
        "condition": "Sunny"
      }
    }
  }
}
```
</details>