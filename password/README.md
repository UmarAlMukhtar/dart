## Usage

Run the password utility from the command line:

```sh
dart run bin/password.dart <flags> [arguments]
```

### Options

- `-h`, `--help` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Print usage information.
- `-v`, `--verbose` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Show additional command output.
- `--version` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Print the tool version.
- `-p`, `--check-password-strength <password>` &nbsp; Check the strength of a password.
- `-g`, `--generate-password <level>` &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Generate a password of the specified strength (`strong`, `medium`, or `weak`).

### Examples

Check password strength:

```sh
dart run bin/password.dart --check-password-strength MyPassword123!
```

Generate a strong password:

```sh
dart run bin/password.dart --generate-password strong
```
