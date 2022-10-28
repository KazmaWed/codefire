String multiplize(String code) {
  bool found = true;
  while (found) {
    final splited = code.split(' ');
    for (var idx = 0; idx < splited.length; idx++) {
      found = false;
      if (splited[idx] == '*') {
        splited[idx] = ',';
        splited.insert(idx + 2, ')');
        splited.insert(idx - 1, 'multi(');
        found = true;
        break;
      }
    }
    code = splited.join(' ');
    code = code.replaceAll('multi( ', 'multi(').replaceAll(' , ', ',').replaceAll(' )', ')');
  }
  return code;
}

String fix(String code) {
  return code
      .replaceAll('*', ' * ')
      .replaceAll('·', ' ')
      .replaceAll(';', ' ;')
      .replaceAll('    ', ' ')
      .replaceAll('   ', ' ')
      .replaceAll('  ', ' ');
}
