import 'package:flutter/material.dart';

class VaultSummaryCard extends StatelessWidget {
  const VaultSummaryCard({
    super.key,
    required this.totalValue,
    required this.goalValue,
    required this.itemCount,
  });

  final double totalValue;
  final double goalValue;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final progress = (totalValue / goalValue).clamp(0.0, 1.0);
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Nilai Koleksi'),
            Text(
              'Rp ${totalValue.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 4),
            Text(
              '$itemCount item • Goal Rp ${goalValue.toStringAsFixed(0)} '
              '(${(progress * 100).toStringAsFixed(0)}%)',
            ),
          ],
        ),
      ),
    );
  }
}