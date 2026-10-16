import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

import '../models/export_result.dart';

class ExportRepository {
  Future<ExportResult> shareFile({
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
    required String subject,
  }) async {
    final result = await SharePlus.instance.share(
      ShareParams(
        files: [XFile.fromData(bytes, mimeType: mimeType, name: fileName)],
        fileNameOverrides: [fileName],
        subject: subject,
      ),
    );
    switch (result.status) {
      case ShareResultStatus.success:
        return ExportResult.delivered;
      case ShareResultStatus.dismissed:
        return ExportResult.dismissed;
      case ShareResultStatus.unavailable:
        return ExportResult.unavailable;
    }
  }
}
