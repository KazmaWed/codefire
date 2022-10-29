String generateCommand(String code) {
  return hiddenFunc + header + code + footer;
}

String hiddenFunc = '''
int multiply(int a, int b) {
 return a * b;
}

String addString(String c, String d) {
  return c + d;
}

String multiString(String g, int h) {
  String result = '';
  for(var idxMultiStr = 0; idxMultiStr < h; idxMultiStr++) {
    result = addString(result, g);
  }
  return result;
}
''';

String header = '''
int main() {
String playerCommandListString = '';
''';

// String sampleCode = '''
// void main() {
//   int n = 1;
//   int m = 5;
//   int result = 1;
//   // moveUp(1);
//   for(var idx = n; idx <= m; idx++) {
//     result = 2 *result* idx+ 1;
//   }
//   // print(playerCommandListString);
//   print('isolate');
//   return result;
// }
// ''';
String sampleCode = '''
void main() {
  print("Hellooooooo from the other side!");
}
''';

String footer = '''
}
''';

String moveupify(String code) {
  const header = 'for(var idxMoveUp = 0; idxMoveUp < ';
  const footer = '''; idxMoveUp++) {\n
  playerCommandListString = addString(playerCommandListString, 'u');
}''';

  final regUp = RegExp(r'moveUp\(.*?\)');
  code = code.replaceAllMapped(regUp, (match) {
    String matchStr = match.group(0).toString();
    String count = matchStr.replaceAll('moveUp(', '').replaceAll(');', '');
    // String newCommand = '\'u\' * $count';
    // return 'playerCommandListString += $newCommand';
    return header + count + footer;
  });

  // code = code.replaceAllMapped(regUp, (match) {
  //   String matchStr = match.group(0).toString();
  //   return matchStr.replaceAll('moveUp(', header).replaceAll(')', footer);
  // });
  return code;
}
