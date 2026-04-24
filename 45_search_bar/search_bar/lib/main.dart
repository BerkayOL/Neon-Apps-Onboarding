import 'package:flutter/material.dart';
import 'package:search_bar/person.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini & Mickey Search',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B7285)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF3F7FA),
      ),
      home: MyHomePage(title: 'Mini & Mickey Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person> people = [
    Person(name: 'Berkay', surname: 'AY'),
    Person(name: 'Halim', surname: 'Parlak'),
    Person(name: 'Fırat', surname: 'Gezgin'),
    Person(name: 'Yiğit', surname: 'Kiraz'),
    Person(name: 'Mickey', surname: 'Mouse'),
    Person(name: 'Mini', surname: 'Mouse'),
  ];
  List<Person> filteredPeople = [];
  String _searchQuery = '';
  int _searchType = 0;

  @override
  void initState() {
    super.initState();
    filteredPeople = List.from(people);
    people.sort((a, b) => a.name.compareTo(b.name));
  }

  void _runFilter() {
    setState(() {
      if (_searchType == 0) {
        filteredPeople = people
            .where(
              (person) => person.name.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
            )
            .toList();
      } else {
        filteredPeople = people
            .where(
              (person) => person.surname.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Search People',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(value: 0, label: Text('Name')),
                          ButtonSegment(value: 1, label: Text('Surname')),
                        ],
                        selected: {_searchType},
                        showSelectedIcon: false,
                        onSelectionChanged: (Set<int> newSelection) {
                          _searchType = newSelection.first;
                          _runFilter();
                        },
                      ),
                      const SizedBox(height: 14),
                      SearchBar(
                        hintText: 'Type to search...',
                        leading: const Icon(Icons.search),
                        elevation: const WidgetStatePropertyAll(0),
                        backgroundColor: const WidgetStatePropertyAll(
                          Color(0xFFF0F4F8),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onChanged: (query) {
                          setState(() {
                            _searchQuery = query;
                            _runFilter();
                            if (_searchType == 0) {
                              filteredPeople = people
                                  .where(
                                    (person) => person.name
                                        .toLowerCase()
                                        .contains(_searchQuery.toLowerCase()),
                                  )
                                  .toList();
                            } else {
                              filteredPeople = people
                                  .where(
                                    (person) => person.surname
                                        .toLowerCase()
                                        .contains(_searchQuery.toLowerCase()),
                                  )
                                  .toList();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: const WidgetStatePropertyAll(
                        Color(0xFFEAF1F7),
                      ),
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Surname')),
                      ],
                      rows: filteredPeople
                          .map(
                            (person) => DataRow(
                              cells: [
                                DataCell(Text(person.name)),
                                DataCell(Text(person.surname)),
                              ],
                            ),
                          )
                          .toList(),
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
