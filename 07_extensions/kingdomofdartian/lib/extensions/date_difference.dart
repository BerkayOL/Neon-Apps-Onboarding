//Tarih Farkı hesaplama
extension DateDifference on DateTime {
  int differenceInDays(DateTime other) {
    return this.difference(other).inDays.abs();
  }
}
