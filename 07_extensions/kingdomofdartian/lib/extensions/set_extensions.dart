//Set ve Map extension'ları
extension SetExtensions<T> on Set<T> {
  void toggle(T item) {
    if (this.contains(item)) {
      this.remove(item);
    } else {
      this.add(item);
    }
  }
}
