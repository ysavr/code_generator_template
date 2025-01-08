# Flutter Code Generator

## How to use
- run on terminal using this command
```
dart run bin/main.dart
```

- compile project to binary file
```
dart compile exe bin/main.dart -o {{file_name}}
```

- compile with destination path
```
dart compile exe bin/main.dart -o build/{{file_name}}
```

- compile with destination path and create `build` directory
```
mkdir -p build && dart compile exe bin/main.dart -o build/{{file_name}}
```

- make executable
```
chmod +x {{file_name}}
```

- run the file
```
./{{file_name}}
```