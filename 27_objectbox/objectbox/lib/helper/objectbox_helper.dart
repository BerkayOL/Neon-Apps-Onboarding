import '../objectbox.g.dart';
import 'package:aqualis_archives/model/coral_fragment.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ObjectboxHelper {
  late final Store store;
  late final Box<CoralFragment> _coralFragmentBox;

  ObjectboxHelper._create(this.store) {
    _coralFragmentBox = Box<CoralFragment>(store);
  }

  static Future<ObjectboxHelper> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: p.join(docsDir.path, 'aqualis-db'),
    );
    return ObjectboxHelper._create(store);
  }

  void addFragment(CoralFragment fragment) {
    _coralFragmentBox.put(fragment);
  }

  void updateFragment(CoralFragment fragment) {
    _coralFragmentBox.put(fragment);
  }

  void putManyFragments(List<CoralFragment> fragments) {
    _coralFragmentBox.putMany(fragments);
  }

  bool removeFragment(int id) {
    return _coralFragmentBox.remove(id);
  }

  List<CoralFragment> getAllFragments() {
    final query = _coralFragmentBox
        .query()
        .order(CoralFragment_.date, flags: Order.descending)
        .build();
    final results = query.find();
    query.close();
    return results;
  }

  List<CoralFragment> searchFragments(String query) {
    final normalized = query.trim();
    if (normalized.isEmpty) {
      return getAllFragments();
    }

    final qBuilder = _coralFragmentBox
        .query(
          CoralFragment_.title
              .contains(normalized, caseSensitive: false)
              .or(
                CoralFragment_.species.contains(
                  normalized,
                  caseSensitive: false,
                ),
              ),
        )
        .order(CoralFragment_.date, flags: Order.descending)
        .build();

    final results = qBuilder.find();
    qBuilder.close();
    return results;
  }

  Stream<List<CoralFragment>> watchAllFragments() {
    final builder = _coralFragmentBox.query().order(
      CoralFragment_.date,
      flags: Order.descending,
    );
    return builder.watch(triggerImmediately: true).map((query) {
      return query.find();
    });
  }

  Stream<List<CoralFragment>> watchSearchFragments(String query) {
    final normalized = query.trim();
    if (normalized.isEmpty) {
      return watchAllFragments();
    }

    final builder = _coralFragmentBox
        .query(
          CoralFragment_.title
              .contains(normalized, caseSensitive: false)
              .or(
                CoralFragment_.species.contains(
                  normalized,
                  caseSensitive: false,
                ),
              ),
        )
        .order(CoralFragment_.date, flags: Order.descending);

    return builder.watch(triggerImmediately: true).map((query) {
      return query.find();
    });
  }
}
