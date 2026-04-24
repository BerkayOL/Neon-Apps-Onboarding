import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Screen Anim Studio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF005B96),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Segoe UI',
      ),
      home: const SpellStudioPage(),
    );
  }
}

class SpellStudioPage extends StatefulWidget {
  const SpellStudioPage({super.key});

  @override
  State<SpellStudioPage> createState() => _SpellStudioPageState();
}

class _SpellStudioPageState extends State<SpellStudioPage> {
  bool _isVisible = true;
  double _turns = 0.0;
  bool _isMoved = false;
  bool _isBig = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEAF6FF), Color(0xFFF5F9E9)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Animation Control Center',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Canlı önizleme ile efektleri tek dokunuşta yönet.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.72),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: colorScheme.primary.withOpacity(0.18),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x18000000),
                        blurRadius: 18,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AnimatedOpacity(
                        opacity: _isVisible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 450),
                        child: Icon(
                          Icons.shield_rounded,
                          size: 90,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 14),
                      AnimatedRotation(
                        turns: _turns,
                        duration: const Duration(milliseconds: 550),
                        child: Icon(
                          Icons.auto_awesome,
                          size: 76,
                          color: colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 14),
                      AnimatedPadding(
                        padding: EdgeInsets.only(top: _isMoved ? 42 : 0),
                        duration: const Duration(milliseconds: 520),
                        curve: Curves.easeOutBack,
                        child: Text(
                          'WARRIOR MODE',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF2C3E50),
                              ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutBack,
                        width: _isBig ? 230 : 122,
                        height: _isBig ? 92 : 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _isBig
                                ? const [Color(0xFFF57C00), Color(0xFFFFB74D)]
                                : const [Color(0xFF78909C), Color(0xFF90A4AE)],
                          ),
                          borderRadius: BorderRadius.circular(_isBig ? 22 : 12),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'DRAGON',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () => setState(() => _isVisible = !_isVisible),
                      icon: Icon(
                        _isVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                      label: const Text('Invisibility'),
                    ),
                    FilledButton.icon(
                      onPressed: () => setState(() => _turns += 0.25),
                      icon: const Icon(Icons.rotate_right),
                      label: const Text('Rotate'),
                    ),
                    FilledButton.icon(
                      onPressed: () => setState(() => _isMoved = !_isMoved),
                      icon: const Icon(Icons.arrow_downward_rounded),
                      label: const Text('Move'),
                    ),
                    FilledButton.icon(
                      onPressed: () => setState(() => _isBig = !_isBig),
                      icon: const Icon(Icons.open_in_full_rounded),
                      label: const Text('Resize'),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(
                      'status-${_isVisible}-${_isMoved}-${_isBig}-$_turns',
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      'Visible: ${_isVisible ? 'Acik' : 'Kapali'}  |  Move: ${_isMoved ? 'Aktif' : 'Pasif'}  |  Size: ${_isBig ? 'Buyuk' : 'Kucuk'}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF37474F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
