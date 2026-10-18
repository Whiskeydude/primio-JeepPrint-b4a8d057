import 'package:flutter/foundation.dart';

import '../../models/export_result.dart';
import '../../models/jeep_part.dart';
import '../../services/parts_service.dart';

class GarageProvider extends ChangeNotifier {
  GarageProvider({required PartsService service}) : _service = service {
    _model = _service.models.first;
    _year = _model.lastYear;
  }

  final PartsService _service;
  late JeepModel _model;
  late int _year;
  List<JeepPart> _results = const [];
  String? _downloadingId;
  PrintFormat? _downloadingFormat;
  String? _exportMessage;
  bool _exportFailed = false;

  PrintFormat? get downloadingFormat => _downloadingFormat;
  List<JeepModel> get models => _service.models;
  JeepModel get model => _model;
  int get year => _year;
  List<JeepPart> get results => _results;
  String? get downloadingId => _downloadingId;
  String? get exportMessage => _exportMessage;
  bool get exportFailed => _exportFailed;
  int get totalReports => _results.fold(0, (sum, p) => sum + p.reportCount);

  void selectModel(JeepModel model) {
    _model = model;
    if (!model.years.contains(_year)) _year = model.lastYear;
    search();
  }

  void selectYear(int year) {
    _year = year;
    search();
  }

  void search() {
    _results = _service.findBreakingParts(_model.code, _year);
    notifyListeners();
  }

  JeepPart? partById(String id) => _service.partById(id);

  Future<void> download(JeepPart part, PrintFormat format) async {
    _downloadingId = part.id;
    _downloadingFormat = format;
    _exportMessage = null;
    _exportFailed = false;
    notifyListeners();
    try {
      final result = switch (format) {
        PrintFormat.stl => await _service.exportStl(part),
        PrintFormat.threeMf => await _service.exportThreeMf(part),
      };
      _exportMessage = switch (result) {
        ExportResult.delivered => '${format.label} ready – send it to your print shop.',
        ExportResult.dismissed => 'Download cancelled.',
        ExportResult.unavailable => 'Sharing is not available on this device.',
      };
      _exportFailed = result == ExportResult.unavailable;
    } catch (e) {
      _exportFailed = true;
      _exportMessage = 'Could not export the ${format.label} file: $e';
    } finally {
      _downloadingId = null;
      _downloadingFormat = null;
      notifyListeners();
    }
  }
}
