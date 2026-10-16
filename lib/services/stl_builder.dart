/// Builds an ASCII STL mounting-bracket blank sized to a part's measured envelope.
class StlBuilder {
  static String bracket({
    required String name,
    required double width,
    required double depth,
    required double height,
    required double wall,
  }) {
    final b = StringBuffer('solid $name\n');
    _box(b, 0, 0, 0, width, depth, wall);
    _box(b, 0, 0, wall, width, wall, height - wall);
    b.write('endsolid $name\n');
    return b.toString();
  }

  static void _box(StringBuffer b, double x, double y, double z, double w, double d, double h) {
    final x1 = x + w, y1 = y + d, z1 = z + h;
    final p = [
      [x, y, z], [x1, y, z], [x1, y1, z], [x, y1, z],
      [x, y, z1], [x1, y, z1], [x1, y1, z1], [x, y1, z1],
    ];
    void tri(int a, int c, int e, String normal) {
      b.write('  facet normal $normal\n    outer loop\n');
      for (final k in [a, c, e]) {
        b.write('      vertex ${p[k][0]} ${p[k][1]} ${p[k][2]}\n');
      }
      b.write('    endloop\n  endfacet\n');
    }

    tri(0, 2, 1, '0 0 -1');
    tri(0, 3, 2, '0 0 -1');
    tri(4, 5, 6, '0 0 1');
    tri(4, 6, 7, '0 0 1');
    tri(0, 1, 5, '0 -1 0');
    tri(0, 5, 4, '0 -1 0');
    tri(3, 7, 6, '0 1 0');
    tri(3, 6, 2, '0 1 0');
    tri(0, 4, 7, '-1 0 0');
    tri(0, 7, 3, '-1 0 0');
    tri(1, 2, 6, '1 0 0');
    tri(1, 6, 5, '1 0 0');
  }
}
