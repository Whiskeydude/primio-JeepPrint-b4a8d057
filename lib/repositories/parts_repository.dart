import '../models/jeep_part.dart';

class PartsRepository {
  List<JeepModel> getModels() => _models;

  List<JeepPart> getParts() => _parts;

  JeepPart? findById(String id) {
    for (final p in _parts) {
      if (p.id == id) return p;
    }
    return null;
  }

  static const _models = [
    JeepModel(code: 'JL', name: 'Wrangler JL', firstYear: 2018, lastYear: 2026),
    JeepModel(code: 'JK', name: 'Wrangler JK', firstYear: 2007, lastYear: 2018),
    JeepModel(code: 'JT', name: 'Gladiator JT', firstYear: 2020, lastYear: 2026),
    JeepModel(code: 'WK2', name: 'Grand Cherokee WK2', firstYear: 2011, lastYear: 2021),
    JeepModel(code: 'XJ', name: 'Cherokee XJ', firstYear: 1984, lastYear: 2001),
  ];

  static const _parts = [
    JeepPart(
      id: 'blend-door-gear',
      name: 'HVAC Blend Door Actuator Gear',
      category: 'Climate',
      summary: 'Clicking behind the dash and stuck hot or cold air.',
      failureReason:
          'The factory gear is thin-wall ABS. Heat cycling makes the teeth brittle until they strip, and the actuator keeps hunting with a clicking sound.',
      printNotes: 'Print in carbon-fiber nylon at 100% infill, teeth facing up, 0.12 mm layers.',
      material: 'Nylon PA12-CF',
      severity: Severity.high,
      reportCount: 538,
      dealerPrice: 89.00,
      printPrice: 4.75,
      imageAsset: 'assets/images/part_blend_gear.jpg',
      fitments: [Fitment('JK', 2011, 2018), Fitment('WK2', 2011, 2021)],
      comments: [
        OwnerComment(author: 'TrailDadMike', vehicle: '2014 JK Unlimited', text: 'Constant clicking under the dash. Pulled the actuator and three teeth were gone from the gear.', helpful: 212),
        OwnerComment(author: 'Kara_WK2', vehicle: '2016 Grand Cherokee', text: 'Dealer quoted \$420 with labor. A printed nylon gear fixed it in 40 minutes.', helpful: 168),
        OwnerComment(author: 'rockcrawlr', vehicle: '2012 JK', text: 'Second time it failed. The OEM plastic just cannot handle Arizona heat.', helpful: 94),
      ],
      widthMm: 30, depthMm: 30, heightMm: 12, wallMm: 4,
    ),
    JeepPart(
      id: 'door-check-bracket',
      name: 'Door Check Strap Bracket',
      category: 'Doors',
      summary: 'Doors swing past the stop or slam into the fender.',
      failureReason:
          'The stamped bracket and its plastic pivot crack once doors come off and go back on a few times. A gust can then fold the door into the fender.',
      printNotes: 'ASA for UV stability, 6 walls, 40% gyroid infill, print flat on the base.',
      material: 'ASA (UV-stable)',
      severity: Severity.high,
      reportCount: 412,
      dealerPrice: 64.99,
      printPrice: 9.50,
      imageAsset: 'assets/images/part_door_check.jpg',
      fitments: [Fitment('JL', 2018, 2026), Fitment('JK', 2007, 2018), Fitment('JT', 2020, 2026)],
      comments: [
        OwnerComment(author: 'SaharaSam', vehicle: '2021 JL Sahara', text: 'Wind caught my door at the beach and the strap pivot snapped clean. Dented the fender.', helpful: 187),
        OwnerComment(author: 'GladGirl', vehicle: '2022 Gladiator', text: 'Doors-off season eats these. Printed ASA ones have held up two summers now.', helpful: 141),
      ],
      widthMm: 60, depthMm: 40, heightMm: 35, wallMm: 5,
    ),
    JeepPart(
      id: 'center-console-latch',
      name: 'Center Console Lid Latch',
      category: 'Interior',
      summary: 'Console lid will not stay closed and rattles on the trail.',
      failureReason:
          'A tiny plastic catch takes every open and close. Once it snaps the dealer only sells the latch with the entire lid assembly.',
      printNotes: 'PETG-CF, print on its side for layer strength along the hook.',
      material: 'PETG-CF',
      severity: Severity.moderate,
      reportCount: 365,
      dealerPrice: 118.00,
      printPrice: 5.40,
      imageAsset: 'assets/images/part_console_latch.jpg',
      fitments: [Fitment('XJ', 1997, 2001), Fitment('WK2', 2011, 2021), Fitment('JK', 2011, 2018)],
      comments: [
        OwnerComment(author: 'XJforever', vehicle: '1999 Cherokee Sport', text: 'Lid flops open every bump. Dealer wanted a whole new lid for a \$1 piece of plastic.', helpful: 133),
        OwnerComment(author: 'mudmama', vehicle: '2013 JK', text: 'Third latch in five years. Printed one feels way stiffer.', helpful: 77),
      ],
      widthMm: 42, depthMm: 18, heightMm: 22, wallMm: 3,
    ),
    JeepPart(
      id: 'freedom-panel-latch',
      name: 'Freedom Top Panel Latch Handle',
      category: 'Roof',
      summary: 'Panel handles crack and the hard top leaks or whistles.',
      failureReason:
          'The over-center latch handle is thin at the pivot. Cold mornings plus frequent removal crack it, letting the panel lift at speed.',
      printNotes: 'ASA, 100% infill around the pivot hole, ream the hole to 6 mm after printing.',
      material: 'ASA (UV-stable)',
      severity: Severity.moderate,
      reportCount: 297,
      dealerPrice: 42.50,
      printPrice: 6.20,
      imageAsset: 'assets/images/part_freedom_latch.jpg',
      fitments: [Fitment('JK', 2007, 2018), Fitment('JL', 2018, 2026), Fitment('JT', 2020, 2026)],
      comments: [
        OwnerComment(author: 'OverlandOllie', vehicle: '2019 JL Rubicon', text: 'Handle snapped in my hand at 20°F. Whistles like crazy on the highway now.', helpful: 119),
        OwnerComment(author: 'jt_tom', vehicle: '2020 Gladiator', text: 'Printed a set of four for less than one dealer handle.', helpful: 88),
      ],
      widthMm: 70, depthMm: 22, heightMm: 18, wallMm: 4,
    ),
    JeepPart(
      id: 'hood-latch-keeper',
      name: 'Hood Latch Keeper',
      category: 'Exterior',
      summary: 'Rubber hood catches tear and the hood flutters.',
      failureReason:
          'The OEM rubber keeper dry-rots and splits in the sun. A torn keeper lets the hood bounce on washboard roads.',
      printNotes: 'Nylon for flex and toughness; print upright, 5 walls.',
      material: 'Nylon PA6',
      severity: Severity.moderate,
      reportCount: 221,
      dealerPrice: 38.75,
      printPrice: 7.90,
      imageAsset: 'assets/images/part_hood_keeper.jpg',
      fitments: [Fitment('JK', 2007, 2018), Fitment('JL', 2018, 2026)],
      comments: [
        OwnerComment(author: 'WashboardWes', vehicle: '2016 JK', text: 'Both hood catches split after four summers. Hood bangs on gravel.', helpful: 96),
      ],
      widthMm: 50, depthMm: 30, heightMm: 40, wallMm: 5,
    ),
    JeepPart(
      id: 'visor-clip',
      name: 'Sun Visor Retaining Clip',
      category: 'Interior',
      summary: 'Visors droop into your line of sight.',
      failureReason:
          'The clip that holds the visor rod becomes brittle from cabin heat and breaks, so the visor drops while driving.',
      printNotes: 'PETG, 4 walls, print with the clip opening facing up.',
      material: 'PETG',
      severity: Severity.low,
      reportCount: 184,
      dealerPrice: 27.30,
      printPrice: 2.10,
      imageAsset: 'assets/images/part_visor_clip.jpg',
      fitments: [Fitment('XJ', 1984, 2001), Fitment('WK2', 2011, 2021), Fitment('JT', 2020, 2026), Fitment('JL', 2018, 2026)],
      comments: [
        OwnerComment(author: 'oldschoolXJ', vehicle: '1994 Cherokee', text: 'Every XJ I have owned had a broken visor clip. Printed ones are a perfect fit.', helpful: 64),
        OwnerComment(author: 'JLjess', vehicle: '2023 JL', text: 'Even new ones break. Visor keeps flopping down.', helpful: 41),
      ],
      widthMm: 28, depthMm: 16, heightMm: 20, wallMm: 3,
    ),
  ];
}
