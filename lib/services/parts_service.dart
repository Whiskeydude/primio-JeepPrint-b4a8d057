import 'dart:convert';
import 'dart:typed_data';

import '../models/export_result.dart';
import '../models/jeep_part.dart';
import '../repositories/export_repository.dart';
import '../repositories/parts_repository.dart';
import 'stl_builder.dart';

class PartsService {
  PartsService({
    required PartsRepository partsRepository,
    required ExportRepository exportRepository,
  })  : _parts = partsRepository,
        _export = exportRepository;

  final PartsRepository _parts;
  final ExportRepository _export;

  List<JeepModel> get models => _parts.getModels();

  /// Parts that fit the vehicle, most-reported failures first.
  List<JeepPart> findBreakingParts(String modelCode, int year) {
    final matches = _parts.getParts().where((p) => p.fits(modelCode, year)).toList()
      ..sort((a, b) => b.reportCount.compareTo(a.reportCount));
    return matches;
  }

  JeepPart? partById(String id) => _parts.findById(id);

  Future<ExportResult> exportStl(JeepPart part) {
    final solidName = part.id.replaceAll('-', '_');
    final stl = StlBuilder.bracket(
      name: solidName,
      width: part.widthMm,
      depth: part.depthMm,
      height: part.heightMm,
      wall: part.wallMm,
    );
    return _export.shareFile(
      bytes: Uint8List.fromList(utf8.encode(stl)),
      fileName: 'jeepprint_$solidName.stl',
      mimeType: 'model/stl',
      subject: 'JeepPrint – ${part.name} (${part.material})',
    );
  }
}
