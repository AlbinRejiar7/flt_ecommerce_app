import 'package:equatable/equatable.dart';

class RatingModel extends Equatable {
  final double rate;
  final int count;

  const RatingModel({required this.rate, required this.count});

  static RatingModel? fromJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      return null;
    }

    final rate = (json['rate'] as num?)?.toDouble();
    final count = (json['count'] as num?)?.toInt();

    if (rate == null || count == null) {
      return null;
    }

    return RatingModel(rate: rate, count: count);
  }

  @override
  List<Object?> get props => [rate, count];
}
