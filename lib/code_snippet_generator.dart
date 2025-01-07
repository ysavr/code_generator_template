import 'dart:io';
import 'package:path/path.dart' as path;

class CodeSnippetGenerator {
  String generateButton(String label, String outputDirectory) {
    String buttonCode = '''
ElevatedButton(
  onPressed: () {
    // TODO: Implement button press logic here
  },
  child: Text('$label'),
)
''';
    _writeToFile(outputDirectory, 'button_snippet.dart', buttonCode);
    return buttonCode;
  }

  String generateLoginScreen(String outputDirectory) {
    String className = 'LoginScreen';
    String fileContent = '''
import 'package:flutter/material.dart';

class ${className} extends StatelessWidget {
  const ${className}({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... (rest of the login screen code)
    );
  }
}
''';
    _writeToFile(outputDirectory, 'login_screen.dart', fileContent);
    
    return fileContent;
  }

  static void _writeToFile(String outputDirectory, String fileName, String content) {
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
}
