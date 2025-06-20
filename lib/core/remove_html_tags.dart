String removeHtmlTags(String htmlString) {
  final regex = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(regex, '').trim();
}
