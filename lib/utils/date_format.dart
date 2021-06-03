class DateFormat {
  static String mesNome(int mes) {
    switch (mes) {
      case DateTime.january:
        return 'JAN';
        break;
      case DateTime.february:
        return 'FEV';
        break;
      case DateTime.march:
        return 'MAR';
        break;
      case DateTime.april:
        return 'ABR';
        break;
      case DateTime.may:
        return 'MAI';
        break;
      case DateTime.june:
        return 'JUN';
        break;
      case DateTime.july:
        return 'JUL';
        break;
      case DateTime.august:
        return 'AGO';
        break;
      case DateTime.september:
        return 'SET';
        break;
      case DateTime.october:
        return 'OUT';
        break;
      case DateTime.november:
        return 'NOV';
        break;
      case DateTime.december:
        return 'DEZ';
        break;
    }
  }
}
