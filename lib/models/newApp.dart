
  int i;
  int n = 100;
  for (i = 0; i <= n; i++) {
    if (i % 3 == 0) {
      print('FIZZ');
    } else if (i % 5 == 0) {
      print('BUZZ');
    } else if (i % 3 == 0 && i % 5 == 0) {
      print('FIZZBUZZ');
    } else {
      print(i);
    }
  }

