class JeepModel {
  final String code;
  final String name;
  final int firstYear;
  final int lastYear;

  const JeepModel({
    required this.code,
    required this.name,
    required this.firstYear,
    required this.lastYear,
  });

  List<int> get years => [for (var y = lastYear; y >= firstYear; y--) y];
}

class OwnerComment {
  final String author;
  final String vehicle;
  final String text;
  final int helpful;

  const OwnerComment({
    required this.author,
    required this.vehicle,
    required this.text,
    required this.helpful,
  });
}

class Fitment {
  final String modelCode;
  final int fromYear;
  final int toYear;

  const Fitment(this.modelCode, this.fromYear, this.toYear);

  bool matches(String code, int year) =>
      code == modelCode && year >= fromYear && year <= toYear;

  String get label => '$modelCode $fromYear–$toYear';
}

enum Severity { low, moderate, high }

class JeepPart {
  final String id;
  final String name;
  final String category;
  final String summary;
  final String failureReason;
  final String printNotes;
  final String material;
  final Severity severity;
  final int reportCount;
  final double dealerPrice;
  final double printPrice;
  final String imageAsset;
  final List<Fitment> fitments;
  final List<OwnerComment> comments;
  final double widthMm;
  final double depthMm;
  final double heightMm;
  final double wallMm;

  const JeepPart({
    required this.id,
    required this.name,
    required this.category,
    required this.summary,
    required this.failureReason,
    required this.printNotes,
    required this.material,
    required this.severity,
    required this.reportCount,
    required this.dealerPrice,
    required this.printPrice,
    required this.imageAsset,
    required this.fitments,
    required this.comments,
    required this.widthMm,
    required this.depthMm,
    required this.heightMm,
    required this.wallMm,
  });

  bool fits(String code, int year) => fitments.any((f) => f.matches(code, year));

  double get savings => dealerPrice - printPrice;

  int get savingsPercent => ((savings / dealerPrice) * 100).round();
}
