// String multiplize(String code) {
//   bool found = true;
//   while (found) {
//     final splited = code.split(' ');
//     for (var idx = 0; idx < splited.length; idx++) {
//       found = false;
//       if (splited[idx] == '*') {
//         splited[idx] = ',';
//         splited.insert(idx + 2, ')');
//         splited.insert(idx - 1, 'multiply(');
//         found = true;
//         break;
//       }
//     }
//     code = splited.join(' ');
//     code = code.replaceAll('multiply( ', 'multiply(').replaceAll(' , ', ',').replaceAll(' )', ')');
//   }
//   return code;
// }

// 連続スペースFix
// String spaceFix(String code) {
//   code = code.replaceAll('·', ' ');
//   final regExp = RegExp(r'[ ]+');

//   return code.replaceAll(regExp, ' ');
// }

// 特殊文字の連続をFix
// String spacifyAll(String code) {
//   const especialChar = '/+-!?';
//   for (var idx = 0; idx < especialChar.length; idx++) {
//     final spChar = especialChar.substring(idx, idx + 1);
//     final patternA = r'([^$spChar ])' '\\$spChar' r'([^$spChar])';
//     final patternB = r'([^$spChar])' '\\$spChar' r'([^$spChar])';
//     final regExpA = RegExp(patternA);
//     final regExpB = RegExp(patternB);
//     code = code.replaceAllMapped(regExpA, (match) {
//       final matchStr = match.group(0).toString();
//       if (matchStr.substring(0, 2) != spChar + spChar &&
//           matchStr.substring(1, 3) != spChar + spChar) {
//         return match.group(0).toString().replaceAll(spChar, ' $spChar');
//       }
//       return matchStr;
//     });
//     code = code.replaceAllMapped(regExpB, (match) {
//       final matchStr = match.group(0).toString();
//       if (matchStr.substring(0, 2) != spChar + spChar &&
//           matchStr.substring(1, 3) != spChar + spChar) {
//         return match.group(0).toString().replaceAll(spChar, '$spChar ');
//       }
//       return matchStr;
//     });
//   }

//   code = code.replaceAll(RegExp(r'![ ]?='), '!=');
//   code = code.replaceAll(RegExp(r'\?[ ]?\?'), '??');
//   code = code.replaceAll(RegExp(r'\/[ ]?\/'), '//');

//   const allSpCharactor = '{}[]*;:\'"';
//   for (var idx = 0; idx < allSpCharactor.length; idx++) {
//     final spChar = allSpCharactor.substring(idx, idx + 1);
//     code = _spacify(code, spChar);
//   }
//   return code;
// }

// String _spacify(String code, String spChar) {
//   code = spaceFix(code.replaceAll(spChar, ' $spChar '));
//   return code;
// }
