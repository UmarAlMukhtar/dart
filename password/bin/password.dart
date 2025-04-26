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
        (hasUpper || hasLower) &&
        (hasDigit || hasSpecial)) {
      return "Medium";
    } else {
      return "Weak";
    }
  }

  String generatePassword(String level) {
    int? length;
    switch (level.toLowerCase()) {
      case 'strong':
        length = 16;
        break;
      case 'medium':
        length = 12;
        break;
      case 'weak':
        length = 8;
        break;
      default:
        break;
    }
    if (length == null) {
      return "Invalid level";
    }
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+[]{}|;:,.<>?';
    final Random random = Random();
    return List.generate(
      length,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
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
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
