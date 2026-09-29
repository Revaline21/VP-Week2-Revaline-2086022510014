import 'package:flutter/material.dart';
import '../Widget/vault_item.dart';

class AddItemSheet extends StatefulWidget {
  const AddItemSheet({super.key, required this.onSubmit});

  final ValueChanged<VaultItem> onSubmit;

  @override
  State<AddItemSheet> createState() => _AddItemSheetState();
}
class _AddItemSheetState extends State<AddItemSheet> {
  final _name = TextEditingController();
  final _value = TextEditingController();
  String _category = 'Figure';
  Condition _condition = Condition.mint;
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _name.dispose();
    _value.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _submit() {
    final value = double.tryParse(_value.text);
    if (_name.text.trim().isEmpty || value == null) return;
    widget.onSubmit(VaultItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: _name.text.trim(),
      category: _category,
      value: value,
      condition: _condition,
      purchaseDate: _date,
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Nama item'),
          ),
          TextField(
            controller: _value,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Nilai (Rp)'),
          ),
          DropdownButton<String>(
            value: _category,
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: 'Figure', child: Text('Figure')),
              DropdownMenuItem(value: 'Sneaker', child: Text('Sneaker')),
              DropdownMenuItem(value: 'TCG', child: Text('TCG')),
            ],
            onChanged: (v) => setState(() => _category = v!),
          ),
          DropdownButton<Condition>(
            value: _condition,
            isExpanded: true,
            items: [
              for (final c in Condition.values)
                DropdownMenuItem(value: c, child: Text(c.label)),
            ],
            onChanged: (v) => setState(() => _condition = v!),
          ),
          TextButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_today),
            label: Text('${_date.day}/${_date.month}/${_date.year}'),
          ),
          const SizedBox(height: 8),
          FilledButton(onPressed: _submit, child: const Text('Simpan')),
        ],
      ),
    );
  }
}