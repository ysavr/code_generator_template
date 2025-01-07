import 'package:code_generator_template/code_snippet_generator.dart';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  print('\nWelcome to a code snippet generator:');
  print('Enter the output directory (e.g., lib/widgets, ./my_widgets):');
  String? outputDirectory = stdin.readLineSync();

  if (outputDirectory == null || outputDirectory.isEmpty) {
    print('Output directory cannot be empty. Using current directory.');
    outputDirectory = '.'; // Default to current directory
  }

  while (true) {
    print('\nWelcome to a code snippet generator:');
    print('1: Button');
    print('2: Login Screen');
    print('3: Exit');

    stdout.write('Select a snippet to generate: ',);
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter the button label: ',);
        String? label = stdin.readLineSync();
        if (label != null && label.isNotEmpty) {
          String output = CodeSnippetGenerator().generateButton(label, outputDirectory);
          await copyToClipboard(output);
        } else {
          print('Button label cannot be empty.');
        }
        await _waitForUserAcknowledgment();
        break;
      case '2':
        String output = CodeSnippetGenerator().generateLoginScreen(outputDirectory);
        await copyToClipboard(output);
        await _waitForUserAcknowledgment();
        break;
      case '3':
        print('Exiting.');
        return;
      default:
        print('Invalid choice. Please select 1, 2, or 3.');
    }
  }
}

Future<void> copyToClipboard(String text) async {
  if (Platform.isWindows) {
    final process = await Process.start('clip', []);
    process.stdin.writeln(text);
    await process.stdin.close();
    print('Text copied to clipboard!');
  } else if (Platform.isMacOS) {
    final process = await Process.start('pbcopy', []);
    process.stdin.writeln(text);
    await process.stdin.close();
    print('Text copied to clipboard!');
  } else if (Platform.isLinux) {
    final process = await Process.start('xclip', ['-selection', 'clipboard']);
    process.stdin.writeln(text);
    await process.stdin.close();
    print('Text copied to clipboard!');
  } else {
    print('Clipboard functionality is not supported on this platform.');
  }
}

Future<void> _waitForUserAcknowledgment() async {
  print('\nPress Enter to return to the menu...');
  stdin.readLineSync(); // Waits for user to press Enter
  exit(0);
}
