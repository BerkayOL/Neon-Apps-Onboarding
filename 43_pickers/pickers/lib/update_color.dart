import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pickers/profile_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class UpdateColorPage extends StatefulWidget {
  @override
  State<UpdateColorPage> createState() => _UpdateColorPageState();
}

class _UpdateColorPageState extends State<UpdateColorPage> {
  Color? _selectedColor;

  @override
  Widget build(BuildContext context) {
    final currentColor = context.read<ProfileProvider>().backgroundColor;
    final previewColor = _selectedColor ?? currentColor;

    return Scaffold(
      appBar: AppBar(title: const Text('Renk Seçimi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: previewColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Önizleme',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: SingleChildScrollView(
                child: BlockPicker(
                  pickerColor: previewColor,
                  onColorChanged: (Color color) {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  context.read<ProfileProvider>().updateBackgroundColor(
                    previewColor,
                  );
                  Navigator.pop(context);
                },
                child: const Text('Rengi Kaydet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
