import 'dart:async';
import 'dart:math';

class WeatherService {
  final Random _random = Random();

  /// Отримує поточну погоду для міста з затримкою
  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    // Обробка крайнього випадку
    if (city.trim().isEmpty) {
      throw ArgumentError('Місто не вказано');
    }

    // Імітація мережевого запиту (1.5 секунди)
    await Future.delayed(const Duration(milliseconds: 1500));

    final conditions = ['Сонячно', 'Хмаро', 'Дощ', 'Сніг'];
    final temp = 15 + _random.nextInt(15); // випадкова температура від 15 до 29
    final condition = conditions[_random.nextInt(conditions.length)];

    return {
      'city': city,
      'temp': temp,
      'condition': condition,
    };
  }

  /// Генерує потік періодичних оновлень температури
  Stream<int> temperatureUpdates({int times = 5}) async* {
    if (times <= 0) return;

    for (int i = 0; i < times; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield 15 + _random.nextInt(15);
    }
  }
}

Future<void> main() async {
  final service = WeatherService();

  print('--- 1. Тест успішного fetchCurrentWeather ---');
  try {
    final weather = await service.fetchCurrentWeather('Київ');
    print('Отримано дані: $weather');
  } catch (e) {
    print('Помилка: $e');
  }

  print('\n--- 2. Тест обробки помилки (порожній параметр) ---');
  try {
    await service.fetchCurrentWeather('');
  } catch (e) {
    print('Успішно спіймано виняток: $e');
  }

  print('\n--- 3. Тест temperatureUpdates (Stream) ---');
  print('Очікування оновлень...');
  await for (final temp in service.temperatureUpdates(times: 3)) {
    print('Температура: $temp°C');
  }
  print('Стрім завершено.');
}
