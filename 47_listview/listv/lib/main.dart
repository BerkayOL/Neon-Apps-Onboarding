import 'package:flutter/material.dart';
import 'package:listv/article.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> articles = [
    Article(
      headline: 'Flutter 3.29 Performans Odaklı Güncellemeler',
      description:
          'Yeni release ile raster pipeline iyileştirmeleri ve daha stabil web deneyimi sunuluyor.',
      thumbnail: 'https://picsum.photos/id/1015/400/240',
    ),
    Article(
      headline: 'Dart 3.x ile Dil Özellikleri Genişliyor',
      description:
          'Pattern matching, records ve toolchain tarafındaki hız iyileştirmeleri üretime güç katıyor.',
      thumbnail: 'https://picsum.photos/id/1043/400/240',
    ),
    Article(
      headline: 'Mobil Tasarımda Sliver Tabanlı Akış Trendde',
      description:
          'Daha akıcı deneyim için Sliver kombinasyonları ve lazy-loading yapıları daha çok tercih ediliyor.',
      thumbnail: 'https://picsum.photos/id/1069/400/240',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF113A2F),
            expandedHeight: 210,
            floating: true,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsetsDirectional.only(
                start: 16,
                bottom: 16,
                end: 16,
              ),
              title: const Text(
                'Flutter Haber Akışı',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://picsum.photos/id/1003/1200/700',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const ColoredBox(color: Color(0xFF1B4B3E));
                    },
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x22000000), Color(0xCC000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EEE9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'Güncel teknoloji başlıkları',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF184437),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final article = articles[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 7,
                ),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  elevation: 2,
                  shadowColor: const Color(0x1A183028),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      debugPrint('${article.headline} tıklandı');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              width: 106,
                              height: 92,
                              child: Image.network(
                                article.thumbnail,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const ColoredBox(
                                        color: Color(0xFFF1F4F2),
                                        child: Center(
                                          child: SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                errorBuilder: (context, error, stackTrace) {
                                  return const ColoredBox(
                                    color: Color(0xFFEFF3F0),
                                    child: Center(
                                      child: Icon(
                                        Icons.image_not_supported_rounded,
                                        color: Color(0xFF6A7E76),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.headline,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF10251E),
                                    height: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  article.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFF4C5C56),
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }, childCount: articles.length),
          ),
        ],
      ),
    );
  }
}
