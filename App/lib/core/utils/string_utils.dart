String addEllipsis(String input, int threshold) {
  if (input.length > threshold) {
    return input.substring(0, threshold) + '...';
  } else {
    return input;
  }
}

String extractId(String input) {
  RegExp regex = RegExp(r'id (\w{8})');
  RegExpMatch? match = regex.firstMatch(input);

  if (match != null) {
    return match.group(1)!; // Non-null assertion
  } else {
    return 'None';
  }
}
