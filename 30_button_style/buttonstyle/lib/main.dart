import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const WildWestButtonsApp());
}

class WildWestButtonsApp extends StatelessWidget {
  const WildWestButtonsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vahşi Batı Buton Ustalığı',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7A3E1D),
          brightness: Brightness.light,
        ),
      ),
      home: const WildWestHomePage(),
    );
  }
}

class WildWestHomePage extends StatefulWidget {
  const WildWestHomePage({super.key});

  @override
  State<WildWestHomePage> createState() => _WildWestHomePageState();
}

class _WildWestHomePageState extends State<WildWestHomePage>
    with SingleTickerProviderStateMixin {
  bool _task3Highlighted = false;
  bool _blacksmithActionEnabled = false;
  bool _robberyHighlighted = false;
  String _statusText = 'Kasaba senden bir hamle bekliyor...';

  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _shakeAnimation = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: 0, end: -14), weight: 1),
        TweenSequenceItem(tween: Tween(begin: -14, end: 14), weight: 2),
        TweenSequenceItem(tween: Tween(begin: 14, end: -10), weight: 2),
        TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 2),
        TweenSequenceItem(tween: Tween(begin: 10, end: 0), weight: 1),
      ],
    ).animate(CurvedAnimation(parent: _shakeController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _notify(String message) {
    setState(() {
      _statusText = message;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  Future<void> _runRobberyAction() async {
    SystemSound.play(SystemSoundType.alert);
    await _shakeController.forward(from: 0);
    _notify('Kasa fena sallandı! Soygun devam ediyor.');
  }

  Future<void> _showDailySpecials() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bugünün Meyhane Menüsü'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Tütsülenmiş kaburga ve mısır ekmeği'),
            Text('• Buz gibi kaktüs limonatası'),
            Text('• Acılı kasaba güveci'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E5CF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4B2B1A),
        foregroundColor: Colors.white,
        title: const Text('Vahşi Batı Buton Ustalığı'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF4B2B1A), width: 1.2),
            ),
            child: Text(
              _statusText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 16),

          // Şerif menüsü
          _TaskSection(
            title: 'Şerifin Masası',
            description: 'Ne yapacağına buradan karar ver.',
            child: MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  onPressed: () => _notify('Takviye çağrıldı!'),
                  child: const Text('Takviye çağır'),
                ),
                MenuItemButton(
                  onPressed: () => _notify('Kasabaya duyuru geçildi.'),
                  child: const Text('Uyarı yayınla'),
                ),
                MenuItemButton(
                  onPressed: () => _notify('Devriye yola çıktı.'),
                  child: const Text('Devriyeyi başlat'),
                ),
              ],
              builder: (context, controller, child) {
                return ElevatedButton.icon(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: const Icon(Icons.shield),
                  label: const Text('Şerif menüsünü aç'),
                );
              },
            ),
          ),

          // Meyhane menüsü butonu
          _TaskSection(
            title: 'Meyhane Köşesi',
            description: 'Günün menüsünü tek dokunuşla gör.',
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: _showDailySpecials,
              child: Ink(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 2),
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.red.withValues(alpha: 0.5),
                      Colors.red,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1542393545-10f5cde2c810?auto=format&fit=crop&w=1200&q=80',
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.35,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Bugünün Menüsünü Aç',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Çete lideri vurgulu buton
          _TaskSection(
            title: 'Vigilante Çağrısı',
            description: 'Basılı tutunca parlar, bırakınca normale döner.',
            child: GestureDetector(
              onTapDown: (_) => setState(() => _task3Highlighted = true),
              onTapUp: (_) {
                setState(() => _task3Highlighted = false);
                _notify('Ekip hazır, işaret gönderildi.');
              },
              onTapCancel: () => setState(() => _task3Highlighted = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: _task3Highlighted
                      ? Colors.yellow
                      : const Color(0xFF285943),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bolt, color: Colors.purple, size: 28),
                    const SizedBox(width: 10),
                    Text(
                      'İşareti Gönder',
                      style: TextStyle(
                        color: _task3Highlighted ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Demirci kontrolü
          _TaskSection(
            title: 'Demirci Dükkanı',
            description: 'Dükkan açıksa ek işlem aktif olur.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _blacksmithActionEnabled = !_blacksmithActionEnabled;
                    });
                    _notify(
                      _blacksmithActionEnabled
                          ? 'Demirhane açık. Ek işlem hazır.'
                          : 'Demirhane kapalı. Ek işlem pasif.',
                    );
                  },
                  icon: const Icon(Icons.construction),
                  label: Text(
                    _blacksmithActionEnabled ? 'Dükkanı kapat' : 'Dükkanı aç',
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _blacksmithActionEnabled
                      ? () => _notify('Nal ve kılıç siparişi hazırlanıyor!')
                      : null,
                  child: const Text('Siparişi hazırla'),
                ),
              ],
            ),
          ),

          // Soygun butonu
          _TaskSection(
            title: 'Kasa Operasyonu',
            description: 'Dokununca kasa sarsılır, ses gelir ve ikon değişir.',
            child: GestureDetector(
              onTapDown: (_) => setState(() => _robberyHighlighted = true),
              onTapUp: (_) {
                setState(() => _robberyHighlighted = false);
                _runRobberyAction();
              },
              onTapCancel: () => setState(() => _robberyHighlighted = false),
              child: AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  final offsetX = _shakeController.isAnimating
                      ? _shakeAnimation.value
                      : 0.0;
                  return Transform.translate(
                    offset: Offset(offsetX, 0),
                    child: child,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: _robberyHighlighted
                        ? const Color(0xFFB71C1C)
                        : const Color(0xFF5D4037),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 140),
                        child: Icon(
                          _robberyHighlighted
                              ? Icons.hourglass_top_rounded
                              : Icons.account_balance_rounded,
                          key: ValueKey<bool>(_robberyHighlighted),
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _robberyHighlighted
                            ? 'Kasa kırılıyor...'
                            : 'Operasyonu başlat',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskSection extends StatelessWidget {
  const _TaskSection({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(description),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
