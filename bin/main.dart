import 'package:code_generator_template/code_snippet_generator.dart';
import 'package:code_generator_template/enum.dart';
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
        await buttonMenu();
        break;
      case '2':
        await chooseDirectoryAndGenerateSnippet('login screen');
        break;
      case '3':
        print('Exiting.');
        return;
      default:
        print('Invalid choice. Please select 1, 2, or 3.');
    }
  }
}

Future<void> buttonMenu() async {
  while (true) {
    print('\nButton Sub-Menu:');
    print('1: Basic Button');
    print('2: Button with Outline Border');
    print('3: Back to Main Menu');

    stdout.write('Select a button type to generate: ');
    String? subChoice = stdin.readLineSync();

    switch (subChoice) {
      case '1':
        await chooseDirectoryAndGenerateSnippet('basic button');
        break;
      case '2':
        await chooseDirectoryAndGenerateSnippet('outline button');
        break;
      case '3':
        return; // Go back to main menu
      default:
        print('Invalid choice. Please select 1, 2, or 3.');
    }
  }
}

Future<void> chooseDirectoryAndGenerateSnippet(String snippetType) async {
  String output;
  switch(snippetType) {
    case 'basic button':
      stdout.write('Enter the button label: ',);
      String? label = stdin.readLineSync();
      if (label != null && label.isNotEmpty) {
        output = CodeSnippetGenerator().elevatedButton(label);
        askSaveContent(output, "button_snippet.dart", WidgetPath.widgets);
        await copyToClipboard(output);
      } else {
        print('Button label cannot be empty.');
      }
      await waitForUserAcknowledgment();
    break;
    
    case 'outline button':
      output = CodeSnippetGenerator().outlineButton();
      askSaveContent(output, "outline_button_snippet.dart", WidgetPath.widgets);
      await copyToClipboard(output);
    break;

    case 'login screen':
      output = CodeSnippetGenerator().loginScreen();
      askSaveContent(output, "login_screen.dart", WidgetPath.screens);
      await copyToClipboard(output);
      await waitForUserAcknowledgment();
    break;
    default:
      print('invalid choice.');
    return;
  }

}

Future<void> askSaveContent(String output, String fileName, WidgetPath widgetPath) async {
  await copyToClipboard(output);

  // Ask if the user wants to save the content
  stdout.write('Do you want to save this content to a file? (y/n): ');
  String? saveChoice = stdin.readLineSync()?.toLowerCase();

  if (saveChoice == 'y') {
    stdout.write('Enter the output directory (e.g., lib/widgets): ');
    String? outputDirectory = stdin.readLineSync();
    if (outputDirectory == null || outputDirectory.isEmpty) {
      outputDirectory = './gen/${widgetPath.name}';
    }
    // Save content to file
    writeToFile(outputDirectory, fileName, output);
  } else {
    print('Skipping save. Content has been copied to clipboard.');
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
  print('\nGenerated file content:');
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
  stdout.write('\nPress Enter to return to the main menu or type "q" to exit the program: ');
  String? input = stdin.readLineSync();

  if (input != null && input.toLowerCase() == 'q') {
    print('Exiting.');
    exit(0); // Quit the program
  } else {
    print('Returning to the main menu...');
  }
}
