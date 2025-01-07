import 'package:code_generator_template/code_snippet_generator.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

Future<void> main(List<String> arguments) async {
  print('\nWelcome to a code snippet generator 🚀');

  while (true) {
    print('1: Button');
    print('2: Login Screen');
    print('3: Exit');

    stdout.write('Select a snippet to generate: ',);
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        await chooseDirectoryAndGenerateSnippet('button');
        break;
      case '2':
        await chooseDirectoryAndGenerateSnippet('loginScreen');
        break;
      case '3':
        print('Exiting.');
        return;
      default:
        print('Invalid choice. Please select 1, 2, or 3.');
    }
  }
}

Future<void> chooseDirectoryAndGenerateSnippet(String snippetType) async {
  print('Enter the output directory (e.g., lib/widgets, ./my_widgets):');
  String? outputDirectory = stdin.readLineSync();
        
  if (outputDirectory == null || outputDirectory.isEmpty) {
    print('Output directory cannot be empty. Using current directory.');
    outputDirectory = '.'; // Default to current directory
  }

  switch(snippetType) {
    case 'button':
      stdout.write('Enter the button label: ',);
      String? label = stdin.readLineSync();
      if (label != null && label.isNotEmpty) {
        String output = CodeSnippetGenerator().generateButton(label, outputDirectory);
        writeToFile(outputDirectory, 'button_snippet.dart', output);
        await copyToClipboard(output);
      } else {
        print('Button label cannot be empty.');
      }
      await waitForUserAcknowledgment();
    break;
    case 'loginScreen':
      String output = CodeSnippetGenerator().generateLoginScreen(outputDirectory);
      writeToFile(outputDirectory, 'login_screen.dart', output);
      await copyToClipboard(output);
      await waitForUserAcknowledgment();
    break;
  }
}

void writeToFile(String outputDirectory, String fileName, String content) {
  final filePath = path.join(outputDirectory, fileName);
  final file = File(filePath);

  // Create the directory if it doesn't exist
  final directory = Directory(outputDirectory);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true); // recursive: true creates parent directories if needed
  }

  file.writeAsStringSync(content);
  print('$fileName file generated successfully at: $filePath');

  // Print the file content to the console
  print('Generated file content:');
  print('--------------------------------');
  print(content);
  print('--------------------------------');
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

Future<void> waitForUserAcknowledgment() async {
  print('\nPress Enter to return to the menu...');
  stdin.readLineSync(); // Waits for user to press Enter
  exit(0);
}
