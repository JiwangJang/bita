import 'dart:math';

String getRandomId() {
  List<String> randomCharactor = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'w',
    'y',
    'z'
  ];

  return "${randomCharactor[Random().nextInt(24)]}${randomCharactor[Random().nextInt(24)]}${randomCharactor[Random().nextInt(24)]}${randomCharactor[Random().nextInt(24)]}${randomCharactor[Random().nextInt(24)]}${randomCharactor[Random().nextInt(24)]}${randomCharactor[Random().nextInt(24)]}-${randomCharactor[Random().nextInt(24)]}${randomCharactor[Random().nextInt(24)]}${randomCharactor[Random().nextInt(24)]}${randomCharactor[Random().nextInt(24)]}${randomCharactor[Random().nextInt(24)]}${randomCharactor[Random().nextInt(24)]}${randomCharactor[Random().nextInt(24)]}";
}
