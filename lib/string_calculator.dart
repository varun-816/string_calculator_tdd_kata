class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) return 0;

    String working = numbers;
    String delimiterPattern = ',|\n';

    if (working.startsWith('//')) {
      final newlineIdx = working.indexOf('\n');
      if (newlineIdx == -1) {
        throw FormatException('Invalid input: missing newline after delimiter declaration');
      }

      var rawDelim = working.substring(2, newlineIdx);
      if (rawDelim.startsWith('[') && rawDelim.endsWith(']')) {
        rawDelim = rawDelim.substring(1, rawDelim.length - 1);
      }

      final escaped = RegExp.escape(rawDelim);
      delimiterPattern = '$escaped|,|\\n';
      working = working.substring(newlineIdx + 1);
    }

    final parts = working
        .split(RegExp(delimiterPattern))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final negatives = <int>[];
    var sum = 0;

    for (final token in parts) {
      final value = int.tryParse(token);
      if (value == null) {
        throw FormatException('Invalid number token: "$token"');
      }
      if (value < 0) negatives.add(value);
      sum += value;
    }

    if (negatives.isNotEmpty) {
      throw ArgumentError('negative numbers not allowed ${negatives.join(',')}');
    }

    return sum;
  }
}
