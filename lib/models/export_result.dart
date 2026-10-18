enum ExportResult { delivered, dismissed, unavailable }

enum PrintFormat {
  stl('STL'),
  threeMf('3MF');

  final String label;
  const PrintFormat(this.label);
}
