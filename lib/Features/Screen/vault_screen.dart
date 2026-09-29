import 'package:flutter/material.dart';
import 'Widget/vault_item.dart';
import 'Widget/add_item_sheet.dart';
import 'Widget/condition_filter_bar.dart';
import 'Widget/vault_item_tile.dart';
import 'Widget/vault_summary_card.dart';

class VaultScreen extends StatefulWidget {
  const VaultScreen({super.key});

  @override
  State<VaultScreen> createState() => _VaultScreenState();
}

class _VaultScreenState extends State<VaultScreen> {
  final List<VaultItem> _items = [
    VaultItem(
      id: '1',
      name: 'Tanjiro Gundam',
      category: 'Figure',
      value: 850000,
      condition: Condition.mint,
      purchaseDate: DateTime(2025, 3, 12),
    ),
    VaultItem(
      id: '2',
      name: 'Adida',
      category: 'Sneaker',
      value: 3200000,
      condition: Condition.nearMint,
      purchaseDate: DateTime(2024, 11, 2),
    ),
    VaultItem(
      id: '3',
      name: 'Pokemon',
      category: 'TCG',
      value: 1500000,
      condition: Condition.good,
      purchaseDate: DateTime(2025, 6, 20),
    ),
  ];

  Condition? _filter;
  final double _goalValue = 10000000;

  List<VaultItem> get _visibleItems => _filter == null
      ? _items
      : _items.where((i) => i.condition == _filter).toList();

  double get _totalValue => _items.fold(0, (sum, i) => sum + i.value);

  void _addItem(VaultItem item) => setState(() => _items.add(item));

  void _removeItem(String id) =>
      setState(() => _items.removeWhere((i) => i.id == id));

  void _setFilter(Condition? c) => setState(() => _filter = c);

  void _openAddSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => AddItemSheet(onSubmit: _addItem),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _visibleItems;
    return Scaffold(
      appBar: AppBar(title: const Text('Collector Vault')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddSheet,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Item'),
      ),
      body: Column(
        children: [
          VaultSummaryCard(
            totalValue: _totalValue,
            goalValue: _goalValue,
            itemCount: _items.length,
          ),
          ConditionFilterBar(
            selected: _filter,
            onChanged: _setFilter,
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Belum ada item.'))
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, i) => VaultItemTile(
                      item: items[i],
                      onDelete: () => _removeItem(items[i].id),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}