import 'package:flutter/material.dart';

import '../../models/jeep_part.dart';
import '../../theme/theme.dart';

class VehicleSelector extends StatelessWidget {
  final List<JeepModel> models;
  final JeepModel selectedModel;
  final int selectedYear;
  final ValueChanged<JeepModel> onModelChanged;
  final ValueChanged<int> onYearChanged;

  const VehicleSelector({
    super.key,
    required this.models,
    required this.selectedModel,
    required this.selectedYear,
    required this.onModelChanged,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.directions_car_filled_rounded, color: colors.primary, size: AppTheme.iconMd),
                const SizedBox(width: AppTheme.spacingSm),
                Expanded(child: Text('Your Jeep', style: theme.textTheme.titleLarge)),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Text('Model', style: theme.textTheme.labelMedium),
            const SizedBox(height: AppTheme.spacingSm),
            Wrap(
              spacing: AppTheme.spacingSm,
              runSpacing: AppTheme.spacingSm,
              children: [
                for (final m in models)
                  ChoiceChip(
                    label: Text(m.name),
                    selected: m.code == selectedModel.code,
                    onSelected: (_) => onModelChanged(m),
                  ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMd),
            DropdownButtonFormField<int>(
              key: ValueKey('${selectedModel.code}-$selectedYear'),
              initialValue: selectedYear,
              decoration: const InputDecoration(labelText: 'Model year'),
              dropdownColor: colors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              items: [
                for (final y in selectedModel.years) DropdownMenuItem(value: y, child: Text('$y')),
              ],
              onChanged: (y) {
                if (y != null) onYearChanged(y);
              },
            ),
          ],
        ),
      ),
    );
  }
}
