import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import '../utils/file_writer.dart';

/// Weather Application Example
///
/// This example has a structure similar to a real weather app.
/// It demonstrates real app patterns such as data loading, error handling, and refresh.
void main() {
  final weatherApp = MCPUIJsonGenerator.page(
    title: 'Weather App',
    content: MCPUIJsonGenerator.column(
      children: [
        MCPUIJsonGenerator.appBar(
          title: 'Weather',
          actions: [
            MCPUIJsonGenerator.button(
              label: '',
              style: 'text',
              icon: 'refresh',
              click: MCPUIJsonGenerator.toolAction('refreshWeather'),
            ),
          ],
        ),
        MCPUIJsonGenerator.expanded(
          child: MCPUIJsonGenerator.padding(
            padding: MCPUIJsonGenerator.edgeInsets(all: 16),
            child: MCPUIJsonGenerator.column(
              children: [
                // Current weather card
                MCPUIJsonGenerator.card(
                  elevation: 8,
                  child: MCPUIJsonGenerator.padding(
                    padding: MCPUIJsonGenerator.edgeInsets(all: 24),
                    child: MCPUIJsonGenerator.column(
                      children: [
                        MCPUIJsonGenerator.text(
                          '{{currentWeather.location}}',
                          style: MCPUIJsonGenerator.textStyle(
                            fontSize: 24,
                            fontWeight: 'bold',
                          ),
                        ),
                        MCPUIJsonGenerator.sizedBox(height: 8),
                        MCPUIJsonGenerator.text(
                          '{{currentWeather.date}}',
                          style: MCPUIJsonGenerator.textStyle(
                            fontSize: 16,
                            color: '#666666',
                          ),
                        ),
                        MCPUIJsonGenerator.sizedBox(height: 24),

                        MCPUIJsonGenerator.row(
                          mainAxisAlignment: 'center',
                          children: [
                            MCPUIJsonGenerator.icon(
                              icon: 'wb_sunny',
                              size: 64,
                              color: '#FF9800',
                            ),
                            MCPUIJsonGenerator.sizedBox(width: 24),
                            MCPUIJsonGenerator.column(
                              children: [
                                MCPUIJsonGenerator.text(
                                  '{{currentWeather.temperature}}°',
                                  style: MCPUIJsonGenerator.textStyle(
                                    fontSize: 48,
                                    fontWeight: 'bold',
                                  ),
                                ),
                                MCPUIJsonGenerator.text(
                                  '{{currentWeather.condition}}',
                                  style: MCPUIJsonGenerator.textStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        MCPUIJsonGenerator.sizedBox(height: 24),

                        // Detailed information
                        MCPUIJsonGenerator.row(
                          mainAxisAlignment: 'spaceAround',
                          children: [
                            MCPUIJsonGenerator.column(
                              children: [
                                MCPUIJsonGenerator.icon(
                                  icon: 'air',
                                  color: '#2196F3',
                                ),
                                MCPUIJsonGenerator.text('Wind'),
                                MCPUIJsonGenerator.text(
                                  '{{currentWeather.wind}} km/h',
                                  style: MCPUIJsonGenerator.textStyle(
                                    fontWeight: 'bold',
                                  ),
                                ),
                              ],
                            ),
                            MCPUIJsonGenerator.column(
                              children: [
                                MCPUIJsonGenerator.icon(
                                  icon: 'water_drop',
                                  color: '#4CAF50',
                                ),
                                MCPUIJsonGenerator.text('Humidity'),
                                MCPUIJsonGenerator.text(
                                  '{{currentWeather.humidity}}%',
                                  style: MCPUIJsonGenerator.textStyle(
                                    fontWeight: 'bold',
                                  ),
                                ),
                              ],
                            ),
                            MCPUIJsonGenerator.column(
                              children: [
                                MCPUIJsonGenerator.icon(
                                  icon: 'visibility',
                                  color: '#9C27B0',
                                ),
                                MCPUIJsonGenerator.text('Visibility'),
                                MCPUIJsonGenerator.text(
                                  '{{currentWeather.visibility}} km',
                                  style: MCPUIJsonGenerator.textStyle(
                                    fontWeight: 'bold',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                MCPUIJsonGenerator.sizedBox(height: 20),

                // Hourly forecast
                MCPUIJsonGenerator.text(
                  'Hourly Forecast',
                  style: MCPUIJsonGenerator.textStyle(
                    fontSize: 18,
                    fontWeight: 'bold',
                  ),
                ),
                MCPUIJsonGenerator.sizedBox(height: 12),

                MCPUIJsonGenerator.container(
                  height: 120,
                  child: MCPUIJsonGenerator.listView(
                    items: '{{hourlyForecast}}',
                    scrollDirection: 'horizontal',
                    itemSpacing: 12,
                    itemTemplate: MCPUIJsonGenerator.card(
                      child: MCPUIJsonGenerator.container(
                        width: 80,
                        padding: MCPUIJsonGenerator.edgeInsets(all: 12),
                        child: MCPUIJsonGenerator.column(
                          mainAxisAlignment: 'spaceAround',
                          children: [
                            MCPUIJsonGenerator.text(
                              '{{item.time}}',
                              style: MCPUIJsonGenerator.textStyle(fontSize: 12),
                            ),
                            MCPUIJsonGenerator.icon(
                              icon: '{{item.icon}}',
                              size: 24,
                              color: '#FF9800',
                            ),
                            MCPUIJsonGenerator.text(
                              '{{item.temp}}°',
                              style: MCPUIJsonGenerator.textStyle(
                                fontWeight: 'bold',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                MCPUIJsonGenerator.sizedBox(height: 20),

                // Weekly forecast
                MCPUIJsonGenerator.text(
                  '7-Day Forecast',
                  style: MCPUIJsonGenerator.textStyle(
                    fontSize: 18,
                    fontWeight: 'bold',
                  ),
                ),
                MCPUIJsonGenerator.sizedBox(height: 12),

                MCPUIJsonGenerator.expanded(
                  child: MCPUIJsonGenerator.listView(
                    items: '{{weeklyForecast}}',
                    itemSpacing: 4,
                    itemTemplate: MCPUIJsonGenerator.card(
                      child: MCPUIJsonGenerator.listTile(
                        leading: MCPUIJsonGenerator.icon(
                          icon: '{{item.icon}}',
                          size: 32,
                          color: '#FF9800',
                        ),
                        title: '{{item.day}}',
                        subtitle: '{{item.condition}}',
                        trailing: MCPUIJsonGenerator.row(
                          mainAxisSize: 'min',
                          children: [
                            MCPUIJsonGenerator.text(
                              '{{item.high}}°',
                              style: MCPUIJsonGenerator.textStyle(
                                fontWeight: 'bold',
                              ),
                            ),
                            MCPUIJsonGenerator.text('/'),
                            MCPUIJsonGenerator.text(
                              '{{item.low}}°',
                              style: MCPUIJsonGenerator.textStyle(
                                color: '#666666',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    state: {
      'initial': {
        'currentWeather': {
          'location': 'Seoul, South Korea',
          'date': 'Today, June 13',
          'temperature': 25,
          'condition': 'Sunny',
          'wind': 12,
          'humidity': 65,
          'visibility': 10,
        },
        'hourlyForecast': [
          {'time': '12PM', 'icon': 'wb_sunny', 'temp': 25},
          {'time': '1PM', 'icon': 'wb_sunny', 'temp': 26},
          {'time': '2PM', 'icon': 'partly_cloudy_day', 'temp': 27},
          {'time': '3PM', 'icon': 'partly_cloudy_day', 'temp': 28},
          {'time': '4PM', 'icon': 'cloud', 'temp': 26},
          {'time': '5PM', 'icon': 'cloud', 'temp': 24},
        ],
        'weeklyForecast': [
          {
            'day': 'Today',
            'condition': 'Sunny',
            'icon': 'wb_sunny',
            'high': 28,
            'low': 18
          },
          {
            'day': 'Tomorrow',
            'condition': 'Partly Cloudy',
            'icon': 'partly_cloudy_day',
            'high': 26,
            'low': 16
          },
          {
            'day': 'Saturday',
            'condition': 'Rainy',
            'icon': 'rainy',
            'high': 22,
            'low': 14
          },
          {
            'day': 'Sunday',
            'condition': 'Cloudy',
            'icon': 'cloud',
            'high': 24,
            'low': 15
          },
          {
            'day': 'Monday',
            'condition': 'Sunny',
            'icon': 'wb_sunny',
            'high': 27,
            'low': 17
          },
          {
            'day': 'Tuesday',
            'condition': 'Partly Cloudy',
            'icon': 'partly_cloudy_day',
            'high': 25,
            'low': 16
          },
          {
            'day': 'Wednesday',
            'condition': 'Thunderstorm',
            'icon': 'thunderstorm',
            'high': 21,
            'low': 13
          },
        ],
        'isLoading': false,
        'lastUpdated': '2024-06-13T12:00:00Z',
      },
    },
    lifecycle: {
      'onInit': [
        MCPUIJsonGenerator.toolAction('loadWeatherData'),
      ],
    },
  );

  ExampleFileWriter.writeJsonFile(weatherApp, 'weather_app.json');

  print('✓ Weather app example created: weather_app.json');
  print('\nKey features:');
  print('- Display current weather information');
  print('- Hourly forecast (horizontal scroll)');
  print('- Weekly forecast list');
  print('- Refresh functionality');
  print('- UI/UX patterns similar to real apps');
}
