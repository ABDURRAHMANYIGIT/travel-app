import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

extension Validatons on String {
  bool isValidEmail() =>
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}').hasMatch(this);

  bool isValidPassword() => RegExp(r'^[a-zA-Z0-9.]{6,}').hasMatch(this);

  bool isValidUsername() => RegExp(r'^[a-zA-Z0-9._%+-]{3,}').hasMatch(this);
}

extension TimeStamp on DateTime {
  String? getLastMessageTimeStamp() {
    final DateTime now = DateTime.now();
    if (now.difference(this).inMinutes < 1440) {
      return DateFormat('HH:mm').format(this);
    } else {
      return DateFormat('dd/MM/yyyy').format(this);
    }
  }
}

mixin InputMasks {
  static final MaskTextInputFormatter birthdateFormatter =
      MaskTextInputFormatter(
    mask: '##/##/####',
    filter: <String, RegExp>{'#': RegExp(r'[0-9]')},
  );

  static final MaskTextInputFormatter phoneNumberFormatter =
      MaskTextInputFormatter(mask: ' ### ### ## ##');
}

extension DurationFormatExtension on Duration {
  String printDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    return '${twoDigits(inHours)}:$twoDigitMinutes';
  }
}
