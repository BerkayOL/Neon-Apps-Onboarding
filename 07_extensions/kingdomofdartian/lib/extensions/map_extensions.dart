// Map için özel bir raporlama formatı
extension MapExtensions on Map<String, List<String>> {
  String toCensusReport() {
    String report = "--- DARTIA NÜFUS SAYIMI ---\n";
    this.forEach((key, value) {
      report += "$key: $value\n";
    });
    return report;
  }
}
