import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app/garage_provider.dart';
import 'providers/app/premium_provider.dart';
import 'repositories/export_repository.dart';
import 'repositories/parts_repository.dart';
import 'repositories/purchases_repository.dart';
import 'router/app_router.dart';
import 'services/parts_service.dart';
import 'services/purchase_service.dart';
import 'theme/theme.dart';

void main() => runApp(const JeepPrintApp());

class JeepPrintApp extends StatelessWidget {
  const JeepPrintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => PartsRepository()),
        Provider(create: (_) => ExportRepository()),
        Provider(
          create: (ctx) => PartsService(
            partsRepository: ctx.read<PartsRepository>(),
            exportRepository: ctx.read<ExportRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => GarageProvider(service: ctx.read<PartsService>())..search(),
        ),
        Provider(
          create: (_) => PurchasesRepository(),
          dispose: (_, repository) => repository.dispose(),
        ),
        Provider(create: (ctx) => PurchaseService(repository: ctx.read<PurchasesRepository>())),
        ChangeNotifierProvider(
          create: (ctx) => PremiumProvider(service: ctx.read<PurchaseService>())..init(),
        ),
      ],
      child: MaterialApp.router(
        title: 'JeepPrint',
        theme: AppTheme.theme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
