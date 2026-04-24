import 'package:aqualis_archives/helper/objectbox_helper.dart';
import 'package:aqualis_archives/model/coral_fragment.dart';
import 'package:flutter/material.dart';

late ObjectboxHelper objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectboxHelper.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aqualis Archives',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0EA5A8),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4FBFB),
      ),
      home: const MyHomePage(title: 'Aqualis Arsivleri'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _searchQuery = _controller.text;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addNewFragment(int listLength) {
    final newFragment = CoralFragment(
      id: 0,
      species: 'Mavi Mercan',
      date: DateTime.now(),
      myth: 'Okyanusun derinliklerinden gelen fisilti...',
      title: 'Antik Kayit #${listLength + 1}',
    );
    objectbox.addFragment(newFragment);
  }

  void _removeFragment(CoralFragment fragment) {
    objectbox.removeFragment(fragment.id);
  }

  Future<void> _showEditDialog(CoralFragment fragment) async {
    final titleController = TextEditingController(text: fragment.title);
    final mythController = TextEditingController(text: fragment.myth);

    final shouldSave = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Kaydi Duzenle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Baslik'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: mythController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Mit'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Iptal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );

    if (shouldSave == true) {
      final updated = CoralFragment(
        id: fragment.id,
        species: fragment.species,
        date: fragment.date,
        title: titleController.text.trim().isEmpty
            ? fragment.title
            : titleController.text.trim(),
        myth: mythController.text.trim().isEmpty
            ? fragment.myth
            : mythController.text.trim(),
      );
      objectbox.updateFragment(updated);
    }

    titleController.dispose();
    mythController.dispose();
  }

  void _bulkInsertTest() {
    final now = DateTime.now();
    final fragments = List.generate(
      1000,
      (i) => CoralFragment(
        id: 0,
        species: 'Test Turu',
        date: now,
        myth: 'Hiz Testi Verisi',
        title: 'Test Kaydi $i',
      ),
    );
    objectbox.putManyFragments(fragments);
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day.$month.${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final hasQuery = _searchQuery.trim().isNotEmpty;
    final stream = hasQuery
        ? objectbox.watchSearchFragments(_searchQuery)
        : objectbox.watchAllFragments();

    return StreamBuilder<List<CoralFragment>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Veri akisinda hata olustu: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFB91C1C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }

        final items = snapshot.data ?? const <CoralFragment>[];

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE7FAFA),
                  Color(0xFFF9FEFF),
                  Color(0xFFECF7FF),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.82),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A0F172A),
                            blurRadius: 28,
                            offset: Offset(0, 12),
                          ),
                        ],
                        border: Border.all(color: const Color(0x3D0EA5A8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: const Color(0xFF0EA5A8),
                                ),
                                child: const Icon(
                                  Icons.water_drop_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  widget.title,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.2,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Tür veya başlık ara...',
                              filled: true,
                              fillColor: const Color(0xFFF6FBFC),
                              prefixIcon: const Icon(Icons.search_rounded),
                              suffixIcon: hasQuery
                                  ? IconButton(
                                      icon: const Icon(Icons.close_rounded),
                                      onPressed: () {
                                        _controller.clear();
                                      },
                                    )
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0x260EA5A8),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0x260EA5A8),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0EA5A8),
                                  width: 1.4,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _MetricCard(
                                title: 'Toplam',
                                value: '${items.length}',
                                color: const Color(0xFF0EA5A8),
                              ),
                              const SizedBox(width: 10),
                              _MetricCard(
                                title: 'Filtre',
                                value: hasQuery ? 'Aktif' : 'Yok',
                                color: const Color(0xFF0369A1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: items.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.hourglass_bottom_rounded,
                                    size: 40,
                                    color: Color(0xFF64748B),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'örüntülenecek kayıt bulunamadı',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF334155),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: const Color(0x260EA5A8),
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x120F172A),
                                        blurRadius: 16,
                                        offset: Offset(0, 7),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    onTap: () => _showEditDialog(item),
                                    onLongPress: () => _showEditDialog(item),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    title: Text(
                                      item.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.species,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF0EA5A8),
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            _formatDate(item.date),
                                            style: const TextStyle(
                                              color: Color(0xFF64748B),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline_rounded,
                                        color: Color(0xFFEF4444),
                                      ),
                                      onPressed: () => _removeFragment(item),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton.extended(
                heroTag: 'bulk_btn',
                backgroundColor: const Color(0xFF0369A1),
                foregroundColor: Colors.white,
                icon: const Icon(Icons.speed_rounded),
                label: const Text('Test: 1000 Ekle'),
                onPressed: _bulkInsertTest,
              ),
              const SizedBox(width: 10),
              FloatingActionButton.extended(
                heroTag: 'add_btn',
                backgroundColor: const Color(0xFF0EA5A8),
                foregroundColor: Colors.white,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Yeni Kayıt'),
                onPressed: () => _addNewFragment(items.length),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.09),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
