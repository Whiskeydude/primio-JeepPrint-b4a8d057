import 'dart:convert';
import 'dart:typed_data';

class _ZipEntry {
  final List<int> name;
  final int crc;
  final int size;
  final int offset;
  const _ZipEntry(this.name, this.crc, this.size, this.offset);
}

/// Minimal zip archive writer (uncompressed entries), enough for 3MF packages.
class ZipWriter {
  static const int _dosDate = 0x21; // 1980-01-01
  static const int _utf8Flag = 0x0800;

  final BytesBuilder _body = BytesBuilder();
  final List<_ZipEntry> _entries = [];

  static final List<int> _crcTable = List<int>.generate(256, (n) {
    var c = n;
    for (var k = 0; k < 8; k++) {
      c = (c & 1) != 0 ? (0xEDB88320 ^ (c >> 1)) : (c >> 1);
    }
    return c;
  });

  static int _crc32(Uint8List data) {
    var c = 0xFFFFFFFF;
    for (final b in data) {
      c = _crcTable[(c ^ b) & 0xFF] ^ (c >> 8);
    }
    return (c ^ 0xFFFFFFFF) & 0xFFFFFFFF;
  }

  void addString(String name, String content) =>
      add(name, Uint8List.fromList(utf8.encode(content)));

  void add(String name, Uint8List data) {
    final nameBytes = utf8.encode(name);
    final crc = _crc32(data);
    final offset = _body.length;
    final h = ByteData(30)
      ..setUint32(0, 0x04034b50, Endian.little)
      ..setUint16(4, 20, Endian.little)
      ..setUint16(6, _utf8Flag, Endian.little)
      ..setUint16(8, 0, Endian.little)
      ..setUint16(10, 0, Endian.little)
      ..setUint16(12, _dosDate, Endian.little)
      ..setUint32(14, crc, Endian.little)
      ..setUint32(18, data.length, Endian.little)
      ..setUint32(22, data.length, Endian.little)
      ..setUint16(26, nameBytes.length, Endian.little)
      ..setUint16(28, 0, Endian.little);
    _body
      ..add(h.buffer.asUint8List())
      ..add(nameBytes)
      ..add(data);
    _entries.add(_ZipEntry(nameBytes, crc, data.length, offset));
  }

  Uint8List finish() {
    final directoryStart = _body.length;
    for (final e in _entries) {
      final h = ByteData(46)
        ..setUint32(0, 0x02014b50, Endian.little)
        ..setUint16(4, 20, Endian.little)
        ..setUint16(6, 20, Endian.little)
        ..setUint16(8, _utf8Flag, Endian.little)
        ..setUint16(10, 0, Endian.little)
        ..setUint16(12, 0, Endian.little)
        ..setUint16(14, _dosDate, Endian.little)
        ..setUint32(16, e.crc, Endian.little)
        ..setUint32(20, e.size, Endian.little)
        ..setUint32(24, e.size, Endian.little)
        ..setUint16(28, e.name.length, Endian.little)
        ..setUint32(42, e.offset, Endian.little);
      _body
        ..add(h.buffer.asUint8List())
        ..add(e.name);
    }
    final directorySize = _body.length - directoryStart;
    final end = ByteData(22)
      ..setUint32(0, 0x06054b50, Endian.little)
      ..setUint16(8, _entries.length, Endian.little)
      ..setUint16(10, _entries.length, Endian.little)
      ..setUint32(12, directorySize, Endian.little)
      ..setUint32(16, directoryStart, Endian.little);
    _body.add(end.buffer.asUint8List());
    return _body.toBytes();
  }
}
