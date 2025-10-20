import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // Login Screen
      'welcome_back': 'Welcome Back!',
      'email': 'Email',
      'password': 'Password',
      'sign_in': 'Sign In',
      'no_account': "Doesn't have an account? Click here to create one!",
      'login_successful': 'Login Successful',
      'welcome_user': 'Welcome, {0}!',
      'continue': 'Continue',
      'login_failed': 'Login Failed',
      'email_password_incorrect': 'Email or password incorrect',
      'try_again': 'Try Again',
      
      // Register Screen
      'create_account': 'Create Your Account',
      'name': 'Name',
      'sign_up': 'Sign Up',
      'have_account': 'Already have an account? Click here to login!',
      'register_successful': 'Register Successful',
      'can_login_now': 'You can now login with your credentials',
      'go_to_login': 'Go to Login',
      
      // Validation Errors (you'll need these in your providers)
      'field_required': 'This field is required',
      'invalid_email': 'Invalid email format',
      'password_too_short': 'Password must be at least 6 characters',
    },
    'pt': {
      // Login Screen
      'welcome_back': 'Bem-vindo de Volta!',
      'email': 'E-mail',
      'password': 'Senha',
      'sign_in': 'Entrar',
      'no_account': 'Não tem uma conta? Clique aqui para criar uma!',
      'login_successful': 'Login Realizado',
      'welcome_user': 'Bem-vindo, {0}!',
      'continue': 'Continuar',
      'login_failed': 'Falha no Login',
      'email_password_incorrect': 'E-mail ou senha incorretos',
      'try_again': 'Tentar Novamente',
      
      // Register Screen
      'create_account': 'Crie Sua Conta',
      'name': 'Nome',
      'sign_up': 'Cadastrar',
      'have_account': 'Já tem uma conta? Clique aqui para entrar!',
      'register_successful': 'Cadastro Realizado',
      'can_login_now': 'Agora você pode fazer login com suas credenciais',
      'go_to_login': 'Ir para Login',
      
      // Validation Errors
      'field_required': 'Este campo é obrigatório',
      'invalid_email': 'Formato de e-mail inválido',
      'password_too_short': 'A senha deve ter pelo menos 6 caracteres',
    },
    'es': {
      // Login Screen
      'welcome_back': '¡Bienvenido de Nuevo!',
      'email': 'Correo Electrónico',
      'password': 'Contraseña',
      'sign_in': 'Iniciar Sesión',
      'no_account': '¿No tienes una cuenta? ¡Haz clic aquí para crear una!',
      'login_successful': 'Inicio de Sesión Exitoso',
      'welcome_user': '¡Bienvenido, {0}!',
      'continue': 'Continuar',
      'login_failed': 'Error de Inicio de Sesión',
      'email_password_incorrect': 'Correo o contraseña incorrectos',
      'try_again': 'Intentar de Nuevo',
      
      // Register Screen
      'create_account': 'Crea Tu Cuenta',
      'name': 'Nombre',
      'sign_up': 'Registrarse',
      'have_account': '¿Ya tienes una cuenta? ¡Haz clic aquí para iniciar sesión!',
      'register_successful': 'Registro Exitoso',
      'can_login_now': 'Ahora puedes iniciar sesión con tus credenciales',
      'go_to_login': 'Ir al Inicio de Sesión',
      
      // Validation Errors
      'field_required': 'Este campo es obligatorio',
      'invalid_email': 'Formato de correo inválido',
      'password_too_short': 'La contraseña debe tener al menos 6 caracteres',
    },
  };

  String translate(String key, [List<String>? args]) {
    String translation = _localizedValues[locale.languageCode]?[key] ?? key;
    
    if (args != null) {
      for (int i = 0; i < args.length; i++) {
        translation = translation.replaceAll('{$i}', args[i]);
      }
    }
    
    return translation;
  }

  // Getters convenientes para as telas
  String get welcomeBack => translate('welcome_back');
  String get email => translate('email');
  String get password => translate('password');
  String get signIn => translate('sign_in');
  String get noAccount => translate('no_account');
  String get loginSuccessful => translate('login_successful');
  String welcomeUser(String name) => translate('welcome_user', [name]);
  String get continueText => translate('continue');
  String get loginFailed => translate('login_failed');
  String get emailPasswordIncorrect => translate('email_password_incorrect');
  String get tryAgain => translate('try_again');
  
  String get createAccount => translate('create_account');
  String get name => translate('name');
  String get signUp => translate('sign_up');
  String get haveAccount => translate('have_account');
  String get registerSuccessful => translate('register_successful');
  String get canLoginNow => translate('can_login_now');
  String get goToLogin => translate('go_to_login');
  
  String get fieldRequired => translate('field_required');
  String get invalidEmail => translate('invalid_email');
  String get passwordTooShort => translate('password_too_short');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pt', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}