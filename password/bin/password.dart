import 'package:args/args.dart';
import 'dart:math';

ArgResults? argResults;

class Password {
  String validatePassword(String password) {
    final hasUpper = password.contains(RegExp(r'[A-Z]'));
    final hasLower = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    final hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final length = password.length;

    if (length >= 12 && hasUpper && hasLower && hasDigit && hasSpecial) {
      return "Strong";
    } else if (length >= 8 &&
        ((hasUpper && hasLower) ||
            (hasUpper && hasDigit) ||
            (hasUpper && hasSpecial) ||
            (hasLower && hasDigit) ||
            (hasLower && hasSpecial) ||
            (hasDigit && hasSpecial))) {
      return "Medium";
    } else {
      return "Weak";
    }
  }

  String generatePassword(String level) {
    final Random random = Random();
    String _randomFrom(String chars, int len) =>
        List.generate(len, (_) => chars[random.nextInt(chars.length)]).join();

    switch (level.toLowerCase()) {
      case 'strong':
        const upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        const lower = 'abcdefghijklmnopqrstuvwxyz';
        const digits = '0123456789';
        const special = '!@#\$%^&*()_+[]{}|;:,.<>?';
        const all = upper + lower + digits + special;
        List<String> chars = [
          upper[random.nextInt(upper.length)],
          lower[random.nextInt(lower.length)],
          digits[random.nextInt(digits.length)],
          special[random.nextInt(special.length)],
        ];
        chars.addAll(_randomFrom(all, 12 - chars.length).split(''));
        chars.shuffle(random);
        return chars.join();
      case 'medium':
        const upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        const lower = 'abcdefghijklmnopqrstuvwxyz';
        const digits = '0123456789';
        const special = '!@#\$%^&*()_+[]{}|;:,.<>?';
        List<String> pools = [upper, lower, digits, special];
        pools.shuffle(random);
        String pool1 = pools[0];
        String pool2 = pools[1];
        List<String> chars = [
          pool1[random.nextInt(pool1.length)],
          pool2[random.nextInt(pool2.length)],
        ];
        const all = upper + lower + digits + special;
        chars.addAll(_randomFrom(all, 8 - chars.length).split(''));
        chars.shuffle(random);
        return chars.join();
      case 'weak':
        const letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        const digits = '0123456789';
        List<String> pools = [letters, digits];
        String pool = pools[random.nextInt(pools.length)];
        return _randomFrom(pool, 6);
      default:
        return "Invalid level";
    }
  }
}

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag('version', negatable: false, help: 'Print the tool version.')
    ..addOption(
      'check-password-strength',
      abbr: 'p',
      help: 'Check the strength of a password.',
    )
    ..addOption(
      'generate-password',
      abbr: 'g',
      help: 'Generate a password of the specified strength.',
      allowed: ['strong', 'medium', 'weak'],
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: dart password_checker.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) {
  final ArgParser argParser = buildParser();
  final Password passwordUtility = Password();
  try {
    final ArgResults results = argParser.parse(arguments);
    bool verbose = false;

    // Process the parsed arguments.
    if (results.flag('help')) {
      printUsage(argParser);
      return;
    }
    if (results.flag('version')) {
      print('password_checker version: $version');
      return;
    }
    if (results.flag('verbose')) {
      verbose = true;
    }
    if (results.options.contains('check-password-strength')) {
      final strength = passwordUtility.validatePassword(
        results['check-password-strength'],
      );
      print('Password strength: $strength');
    }
    if (results.options.contains('generate-password')) {
      final password = passwordUtility.generatePassword(
        results['generate-password'],
      );
      print('Generated password: $password');
    }

    // Act on the arguments provided.
    // print('Positional arguments: ${results.rest}');
    if (verbose) {
      print('[VERBOSE] All arguments: ${results.arguments}');
    }
  } on FormatException catch (e) {
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
