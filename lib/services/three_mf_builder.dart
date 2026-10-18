import 'dart:typed_data';

import 'zip_writer.dart';

/// Builds a 3MF package holding the same L-bracket blank as the STL export,
/// with the recommended material and print notes embedded as metadata.
class ThreeMfBuilder {
  static const String _contentTypes =
      '<?xml version="1.0" encoding="UTF-8"?>\n'
      '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
      '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>'
      '<Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/>'
      '</Types>';

  static const String _rels =
      '<?xml version="1.0" encoding="UTF-8"?>\n'
      '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
      '<Relationship Target="/3D/3dmodel.model" Id="rel0" '
      'Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/>'
      '</Relationships>';

  // Triangles of a box, corners numbered 0-3 (bottom) and 4-7 (top).
  static const List<List<int>> _boxTriangles = [
    [0, 2, 1], [0, 3, 2],
    [4, 5, 6], [4, 6, 7],
    [0, 1, 5], [0, 5, 4],
    [3, 7, 6], [3, 6, 2],
    [0, 4, 7], [0, 7, 3],
    [1, 2, 6], [1, 6, 5],
  ];

  static Uint8List bracket({
    required String title,
    required String material,
    required String notes,
    required double width,
    required double depth,
    required double height,
    required double wall,
  }) {
    final vertices = StringBuffer();
    final triangles = StringBuffer();
    var base = 0;

    void box(double x, double y, double z, double w, double d, double h) {
      final x1 = x + w, y1 = y + d, z1 = z + h;
      final corners = [
        [x, y, z], [x1, y, z], [x1, y1, z], [x, y1, z],
        [x, y, z1], [x1, y, z1], [x1, y1, z1], [x, y1, z1],
      ];
      for (final c in corners) {
        vertices.write('<vertex x="${c[0]}" y="${c[1]}" z="${c[2]}"/>');
      }
      for (final t in _boxTriangles) {
        triangles.write('<triangle v1="${base + t[0]}" v2="${base + t[1]}" v3="${base + t[2]}"/>');
      }
      base += 8;
    }

    box(0, 0, 0, width, depth, wall);
    box(0, 0, wall, width, wall, height - wall);

    final model = '<?xml version="1.0" encoding="UTF-8"?>\n'
        '<model unit="millimeter" xml:lang="en-US" '
        'xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02">'
        '<metadata name="Title">${_escape(title)}</metadata>'
        '<metadata name="Designer">JeepPrint</metadata>'
        '<metadata name="Description">${_escape('Material: $material. $notes')}</metadata>'
        '<resources><object id="1" type="model"><mesh>'
        '<vertices>$vertices</vertices>'
        '<triangles>$triangles</triangles>'
        '</mesh></object></resources>'
        '<build><item objectid="1"/></build>'
        '</model>';

    return (ZipWriter()
          ..addString('[Content_Types].xml', _contentTypes)
          ..addString('_rels/.rels', _rels)
          ..addString('3D/3dmodel.model', model))
        .finish();
  }

  static String _escape(String s) => s
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;');
}
