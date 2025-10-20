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
      
      // Validation Errors
      'field_required': 'This field is required',
      'invalid_email': 'Invalid email format',
      'password_too_short': 'Password must be at least 8 characters',
      'email_already_registered': "There's already a register with this email",
      'register_error': 'Error during registration',
      'delete_user_error': 'Error deleting user',
      
      // Home Screen
      'welcome': 'Welcome, {0}',
      'search_destinations': 'Search destinations...',
      'no_results_found': 'No results found',
      'selected': 'Selected: {0}',
      'days': '{0} days',
      'brazilian_northeast': 'Brazilian Northeast',
      'southern_brazil': 'Southern Brazil',
      
      // Trip Register Screen
      'new_trip': 'New Trip',
      'trip_data': '1. Trip Data',
      'trip_title': 'Trip Title',
      'transport': 'Transport',
      'car': 'Car',
      'motorcycle': 'Motorcycle',
      'bus': 'Bus',
      'airplane': 'Airplane',
      'ship': 'Ship',
      'start_date': 'Start Date',
      'end_date': 'End Date',
      'group_data': '2. Group Data',
      'age': 'Age',
      'add_person': 'Add Person',
      'map': '3. Map',
      'register_trip': 'Register The Trip',
      'success': 'Success!',
      'trip_created': 'Trip created successfully',
      'ok': 'OK',
      'error': 'Error',
      
      // Trip Validation Errors
      'trip_title_required': 'Trip Title cannot be blank',
      'start_date_required': 'Start Date cannot be blank',
      'end_date_required': 'End Date cannot be blank',
      'start_after_end': 'Start Date cannot be after End Date',
      'group_empty': 'Group cannot be empty',
      'stops_empty': 'Stops cannot be empty',
      'name_required': 'Name cannot be blank',
      'age_required': 'Age cannot be blank',
      'age_invalid': 'Age must be a valid number',
      'trip_create_failed': 'Failed to create trip',
      'trip_create_error': 'Error creating trip',
      'unexpected_error': 'Unexpected error',
      
      // List Trips Screen
      'your_trips': 'Your Trips',
      'active_trips': '- Active Trips',
      'concluded_trips': '- Concluded Trips',
      
      // Config Screen
      'preferences': 'Preferences',
      'dark_mode': 'Dark Mode',
      'language': 'Language',
      'english': 'English',
      'portuguese': 'Portuguese',
      'spanish': 'Spanish',
      'account': 'Account',
      'your_information': 'Your Information',
      'update_info': 'Update Info',
      'delete_account': 'Delete Account',
      'delete_account_confirm': 'Delete Account?',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'log_out': 'Log Out',
      'log_out_confirm': 'Log Out?',
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
      'password_too_short': 'A senha deve ter pelo menos 8 caracteres',
      'email_already_registered': 'Já existe um cadastro com este e-mail',
      'register_error': 'Erro ao realizar cadastro',
      'delete_user_error': 'Erro ao deletar usuário',
      
      // Home Screen
      'welcome': 'Bem-vindo, {0}',
      'search_destinations': 'Buscar destinos...',
      'no_results_found': 'Nenhum resultado encontrado',
      'selected': 'Selecionado: {0}',
      'days': '{0} dias',
      'brazilian_northeast': 'Nordeste Brasileiro',
      'southern_brazil': 'Sul do Brasil',
      
      // Trip Register Screen
      'new_trip': 'Nova Viagem',
      'trip_data': '1. Dados da Viagem',
      'trip_title': 'Título da Viagem',
      'transport': 'Transporte',
      'car': 'Carro',
      'motorcycle': 'Motocicleta',
      'bus': 'Ônibus',
      'airplane': 'Avião',
      'ship': 'Navio',
      'start_date': 'Data de Início',
      'end_date': 'Data de Término',
      'group_data': '2. Dados do Grupo',
      'age': 'Idade',
      'add_person': 'Adicionar Pessoa',
      'map': '3. Mapa',
      'register_trip': 'Registrar a Viagem',
      'success': 'Sucesso!',
      'trip_created': 'Viagem criada com sucesso',
      'ok': 'OK',
      'error': 'Erro',
      
      // Trip Validation Errors
      'trip_title_required': 'Título da viagem não pode estar em branco',
      'start_date_required': 'Data de início não pode estar em branco',
      'end_date_required': 'Data de término não pode estar em branco',
      'start_after_end': 'Data de início não pode ser após a data de término',
      'group_empty': 'Grupo não pode estar vazio',
      'stops_empty': 'Paradas não podem estar vazias',
      'name_required': 'Nome não pode estar em branco',
      'age_required': 'Idade não pode estar em branco',
      'age_invalid': 'Idade deve ser um número válido',
      'trip_create_failed': 'Falha ao criar viagem',
      'trip_create_error': 'Erro ao criar viagem',
      'unexpected_error': 'Erro inesperado',
      
      // List Trips Screen
      'your_trips': 'Suas Viagens',
      'active_trips': '- Viagens Ativas',
      'concluded_trips': '- Viagens Concluídas',
      
      // Config Screen
      'preferences': 'Preferências',
      'dark_mode': 'Modo Escuro',
      'language': 'Idioma',
      'english': 'Inglês',
      'portuguese': 'Português',
      'spanish': 'Espanhol',
      'account': 'Conta',
      'your_information': 'Suas Informações',
      'update_info': 'Atualizar Info',
      'delete_account': 'Deletar Conta',
      'delete_account_confirm': 'Deletar Conta?',
      'cancel': 'Cancelar',
      'delete': 'Deletar',
      'log_out': 'Sair',
      'log_out_confirm': 'Sair?',
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
      'password_too_short': 'La contraseña debe tener al menos 8 caracteres',
      'email_already_registered': 'Ya existe un registro con este correo',
      'register_error': 'Error al realizar el registro',
      'delete_user_error': 'Error al eliminar usuario',
      
      // Home Screen
      'welcome': 'Bienvenido, {0}',
      'search_destinations': 'Buscar destinos...',
      'no_results_found': 'No se encontraron resultados',
      'selected': 'Seleccionado: {0}',
      'days': '{0} días',
      'brazilian_northeast': 'Nordeste Brasileño',
      'southern_brazil': 'Sur de Brasil',
      
      // Trip Register Screen
      'new_trip': 'Nuevo Viaje',
      'trip_data': '1. Datos del Viaje',
      'trip_title': 'Título del Viaje',
      'transport': 'Transporte',
      'car': 'Coche',
      'motorcycle': 'Motocicleta',
      'bus': 'Autobús',
      'airplane': 'Avión',
      'ship': 'Barco',
      'start_date': 'Fecha de Inicio',
      'end_date': 'Fecha de Fin',
      'group_data': '2. Datos del Grupo',
      'age': 'Edad',
      'add_person': 'Añadir Persona',
      'map': '3. Mapa',
      'register_trip': 'Registrar el Viaje',
      'success': '¡Éxito!',
      'trip_created': 'Viaje creado exitosamente',
      'ok': 'OK',
      'error': 'Error',
      
      // Trip Validation Errors
      'trip_title_required': 'El título del viaje no puede estar en blanco',
      'start_date_required': 'La fecha de inicio no puede estar en blanco',
      'end_date_required': 'La fecha de fin no puede estar en blanco',
      'start_after_end': 'La fecha de inicio no puede ser posterior a la fecha de fin',
      'group_empty': 'El grupo no puede estar vacío',
      'stops_empty': 'Las paradas no pueden estar vacías',
      'name_required': 'El nombre no puede estar en blanco',
      'age_required': 'La edad no puede estar en blanco',
      'age_invalid': 'La edad debe ser un número válido',
      'trip_create_failed': 'Error al crear el viaje',
      'trip_create_error': 'Error al crear el viaje',
      'unexpected_error': 'Error inesperado',
      
      // List Trips Screen
      'your_trips': 'Tus Viajes',
      'active_trips': '- Viajes Activos',
      'concluded_trips': '- Viajes Concluidos',
      
      // Config Screen
      'preferences': 'Preferencias',
      'dark_mode': 'Modo Oscuro',
      'language': 'Idioma',
      'english': 'Inglés',
      'portuguese': 'Portugués',
      'spanish': 'Español',
      'account': 'Cuenta',
      'your_information': 'Tu Información',
      'update_info': 'Actualizar Info',
      'delete_account': 'Eliminar Cuenta',
      'delete_account_confirm': '¿Eliminar Cuenta?',
      'cancel': 'Cancelar',
      'delete': 'Eliminar',
      'log_out': 'Cerrar Sesión',
      'log_out_confirm': '¿Cerrar Sesión?',
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
  
  // Home Screen getters
  String get searchDestinations => translate('search_destinations');
  String get noResultsFound => translate('no_results_found');
  String selected(String location) => translate('selected', [location]);
  String days(int count) => translate('days', [count.toString()]);
  String get brazilianNortheast => translate('brazilian_northeast');
  String get southernBrazil => translate('southern_brazil');
  
  // Trip Register Screen getters
  String get newTrip => translate('new_trip');
  String get tripData => translate('trip_data');
  String get tripTitle => translate('trip_title');
  String get transport => translate('transport');
  String get car => translate('car');
  String get motorcycle => translate('motorcycle');
  String get bus => translate('bus');
  String get airplane => translate('airplane');
  String get ship => translate('ship');
  String get startDate => translate('start_date');
  String get endDate => translate('end_date');
  String get groupData => translate('group_data');
  String get age => translate('age');
  String get addPerson => translate('add_person');
  String get map => translate('map');
  String get registerTrip => translate('register_trip');
  String get success => translate('success');
  String get tripCreated => translate('trip_created');
  String get ok => translate('ok');
  String get error => translate('error');
  
  // Trip validation getters
  String get tripTitleRequired => translate('trip_title_required');
  String get startDateRequired => translate('start_date_required');
  String get endDateRequired => translate('end_date_required');
  String get startAfterEnd => translate('start_after_end');
  String get groupEmpty => translate('group_empty');
  String get stopsEmpty => translate('stops_empty');
  String get nameRequired => translate('name_required');
  String get ageRequired => translate('age_required');
  String get ageInvalid => translate('age_invalid');
  String get tripCreateFailed => translate('trip_create_failed');
  String get tripCreateError => translate('trip_create_error');
  String get unexpectedError => translate('unexpected_error');
  
  // List Trips getters
  String get yourTrips => translate('your_trips');
  String get activeTrips => translate('active_trips');
  String get concludedTrips => translate('concluded_trips');
  
  // Config Screen getters
  String get preferences => translate('preferences');
  String get darkMode => translate('dark_mode');
  String get language => translate('language');
  String get english => translate('english');
  String get portuguese => translate('portuguese');
  String get spanish => translate('spanish');
  String get account => translate('account');
  String get yourInformation => translate('your_information');
  String get updateInfo => translate('update_info');
  String get deleteAccount => translate('delete_account');
  String get deleteAccountConfirm => translate('delete_account_confirm');
  String get cancel => translate('cancel');
  String get deleteText => translate('delete');
  String get logOut => translate('log_out');
  String get logOutConfirm => translate('log_out_confirm');
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