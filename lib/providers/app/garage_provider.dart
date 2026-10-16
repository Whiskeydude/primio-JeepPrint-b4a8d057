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
  String? _exportMessage;
  bool _exportFailed = false;

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

  Future<void> downloadStl(JeepPart part) async {
    _downloadingId = part.id;
    _exportMessage = null;
    _exportFailed = false;
    notifyListeners();
    try {
      final result = await _service.exportStl(part);
      _exportMessage = switch (result) {
        ExportResult.delivered => 'STL ready – send it to your print shop.',
        ExportResult.dismissed => 'Download cancelled.',
        ExportResult.unavailable => 'Sharing is not available on this device.',
      };
      _exportFailed = result == ExportResult.unavailable;
    } catch (e) {
      _exportFailed = true;
      _exportMessage = 'Could not export the STL file: $e';
    } finally {
      _downloadingId = null;
      notifyListeners();
    }
  }
}
