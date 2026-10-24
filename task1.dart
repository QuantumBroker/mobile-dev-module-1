import 'dart:math';

/// Абстрактний клас бібліотечного елемента
abstract class LibraryItem {
  final String title;
  final int year;

  const LibraryItem({
    required this.title,
    required this.year,
  });

  String describe();
}

/// Клас книги
class Book extends LibraryItem {
  final String author;

  const Book({
    required String title,
    required int year,
    required this.author,
  }) : super(title: title, year: year);

  @override
  String describe() {
    return '$title ($year) $author';
  }
}

/// Клас журналу
class Magazine extends LibraryItem {
  final int issueNumber;

  const Magazine({
    required String title,
    required int year,
    required this.issueNumber,
  }) : super(title: title, year: year);

  @override
  String describe() {
    return '$title ($year), випуск $issueNumber';
  }
}

/// Клас управління бібліотекою
class Library {
  final List<LibraryItem> _items = [];

  /// Додає елемент до бібліотеки
  void addItem(LibraryItem item) {
    _items.add(item);
  }

  /// Знаходить елементи за вказаним роком видання
  List<LibraryItem> findByYear(int year) {
    return _items.where((item) => item.year == year).toList();
  }

  /// Повертає список опису всіх елементів
  List<String> get allDescriptions {
    return _items.map((item) => item.describe()).toList();
  }

  /// Знаходить найстаріший елемент у бібліотеці
  LibraryItem? findOldest() {
    if (_items.isEmpty) return null;
    return _items.reduce((curr, next) => curr.year <= next.year ? curr : next);
  }
}

void main() {
  final library = Library();

  library.addItem(const Book(title: 'Dart у дії', year: 2022, author: 'І. Петренко'));
  library.addItem(const Magazine(title: 'Mobile Dev', year: 2023, issueNumber: 5));
  library.addItem(const Book(title: 'Чистий код', year: 2008, author: 'Р. Мартін'));

  print('--- Пошук за роком (2022) ---');
  final from2022 = library.findByYear(2022);
  for (var item in from2022) {
    print(item.describe());
  }

  print('\n--- Усі описи ---');
  print(library.allDescriptions);

  print('\n--- Найстаріший елемент ---');
  final oldest = library.findOldest();
  print(oldest?.describe());
}
