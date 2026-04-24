import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pickers/profile_provider.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  DateTime? _selectedDate;

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yaş Güncelle')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Text(
                      'Doğum Tarihi Seç',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      _selectedDate == null
                          ? 'Henüz tarih seçilmedi'
                          : '${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate ?? DateTime(2000, 1, 1),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          }
                        },
                        icon: const Icon(Icons.calendar_month_rounded),
                        label: const Text('Takvimi Aç'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _selectedDate == null
                    ? null
                    : () {
                        final age = _calculateAge(_selectedDate!);
                        Provider.of<ProfileProvider>(
                          context,
                          listen: false,
                        ).updateAge(age);
                        Navigator.pop(context);
                      },
                child: const Text('Yaşı Kaydet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
