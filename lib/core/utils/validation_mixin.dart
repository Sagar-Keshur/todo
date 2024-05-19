mixin ValidationMixin {
  String? emailValidator(String? email) {
    if (email?.isNotEmpty ?? false) {
      if (_isEmailValid(email)) {
        return null;
      } else {
        return 'Please enter a valid email address';
      }
    } else {
      return 'Please enter your email address';
    }
  }

  String? signInPasswordValidator(String? password) {
    if (password!.isEmpty) {
      return 'Please enter your password';
    } else {
      return null;
    }
  }

  String? passwordValidator(String? password) {
    if (password!.isEmpty) {
      return 'Please enter your password';
    } else {
      if (password.length < 6) {
        return 'Password should be a minimum 6 characters';
      } else {
        return null;
      }
    }
  }

  String? newPasswordValidator(String? password) {
    if (password!.isEmpty) {
      return 'Please enter new password';
    } else {
      if (password.length < 6) {
        return 'Password should be a minimum 6 characters';
      } else {
        return null;
      }
    }
  }

  String? nameValidator(String? name) {
    // final whiteSpace = RegExp(r'^\s*$');
    final validCharacters = RegExp(r'^[a-zA-Z\s]+$');

    if (name != null) {
      if (name.isEmpty) {
        return 'Please enter a name in the field.';
      } else if (name.startsWith(' ')) {
        return 'No leading white spaces allowed.';
      } else if (name.contains('  ')) {
        return 'Only one space allowed after the name.';
      } else if (!validCharacters.hasMatch(name)) {
        return 'Name should only be in alphabets';
      } else {
        return null;
      }
    } else {
      return 'Please enter your name';
    }
  }

  String? confirmPasswordValidator(
    String? value,
    String? password,
  ) {
    if (value?.isNotEmpty ?? false) {
      if (password == value) {
        return null;
      }
      return 'Password and ReType Password doesn\'t match';
    } else {
      return 'Please enter ReType password';
    }
  }

  bool _isEmailValid(String? email) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return email != null ? regex.hasMatch(email) : false;
  }
}
