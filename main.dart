import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'weather_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  Future<Weather>? _weather;
  final TextEditingController _controller = TextEditingController();

  void _searchWeather() {
    setState(() {
      _weather = _weatherService.fetchWeather(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _searchWeather(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchWeather,
              child: Text('Get Weather'),
            ),
            SizedBox(height: 20),
            if (_weather != null)
              FutureBuilder<Weather>(
                future: _weather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final weather = snapshot.data!;
                    return Column(
                      children: [
                        Text(
                          weather.cityName,
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${weather.temperature}°C',
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          weather.description,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    );
                  } else {
                    return Text('No data available');
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
    
