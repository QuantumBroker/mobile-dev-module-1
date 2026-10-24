import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBadge(rating: 4.7, label: 'Відмінно'),
              SizedBox(height: 20),
              RatingBadge(rating: 3.2, label: 'Добре'),
              SizedBox(height: 20),
              RatingBadge(rating: 1.5, label: 'Погано'),
            ],
          ),
        ),
      ),
    ),
  );
}

class RatingBadge extends StatelessWidget {
  final double rating;
  final String? label;

  const RatingBadge({
    super.key,
    required this.rating,
    this.label,
  });

  /// Геттер для визначення кольору зірки залежно від рейтингу
  Color _getRatingColor(BuildContext context) {
    if (rating >= 4.0) {
      return Colors.green;
    } else if (rating >= 2.5) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Обробка крайніх випадків
    final clampedRating = rating.clamp(0.0, 5.0);
    final ratingColor = _getRatingColor(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              color: ratingColor,
              size: 20.0,
            ),
            const SizedBox(width: 4.0),
            Text(
              clampedRating.toStringAsFixed(1),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        if (label != null && label!.trim().isNotEmpty) ...[
          const SizedBox(height: 2.0),
          Text(
            label!,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
        ],
      ],
    );
  }
}
