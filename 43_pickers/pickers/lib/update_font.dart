import 'package:flutter/material.dart';
import 'package:pickers/profile_provider.dart';
import 'package:provider/provider.dart';

class UpdateFontPage extends StatelessWidget {
  final List<Map<String, String>> _fontOptions = const [
    {'label': 'Roboto', 'family': 'Roboto'},
    {'label': 'Open Sans', 'family': 'OpenSans'},
    {'label': 'Lato', 'family': 'Lato'},
    {'label': 'Montserrat', 'family': 'Montserrat'},
  ];

  @override
  Widget build(BuildContext context) {
    final selectedFont = context.watch<ProfileProvider>().fontStyle;

    return Scaffold(
      appBar: AppBar(title: const Text('Font Seçimi')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _fontOptions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final option = _fontOptions[index];
          final family = option['family']!;
          final isSelected = selectedFont == family;

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            child: ListTile(
              title: Text(
                option['label']!,
                style: TextStyle(fontFamily: family, fontSize: 20),
              ),
              subtitle: Text(
                'Ad: ${context.read<ProfileProvider>().name}',
                style: TextStyle(fontFamily: family),
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : const Icon(Icons.circle_outlined),
              onTap: () {
                context.read<ProfileProvider>().updateFontStyle(family);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
