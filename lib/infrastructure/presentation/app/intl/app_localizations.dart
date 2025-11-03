import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    final localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
    
    if (localizations == null) {
      return AppLocalizations(const Locale('en', 'US'));
    }
    
    return localizations;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // Login Screen
      'welcome_back': 'Welcome Back!',
      'sign_in_subtitle': 'Sign in to continue your journey',
      'email': 'Email',
      'password': 'Password',
      'sign_in': 'Sign In',
      'no_account': "Doesn't have an account? Click here to create one!",
      'no_account_question': "Don't have an account? ",
      'sign_up_link': 'Sign Up',
      'or': 'or',
      'login_successful': 'Login Successful',
      'welcome_user': 'Welcome, {0}!',
      'continue': 'Continue',
      'login_failed': 'Login Failed',
      'email_password_incorrect': 'Email or password incorrect',
      'try_again': 'Try Again',
      
      // Register Screen
      'create_account': 'Create Your Account',
      'sign_up_subtitle': 'Join us and start planning your trips',
      'name': 'Name',
      'sign_up': 'Sign Up',
      'have_account': 'Already have an account? Click here to login!',
      'have_account_question': 'Already have an account? ',
      'sign_in_link': 'Sign In',
      'register_successful': 'Register Successful',
      'can_login_now': 'You can now login with your credentials',
      'go_to_login': 'Go to Login',
      
      // Validation Errors
      'field_required': 'This field is required',
      'name_required': 'Name cannot be blank',
      'email_required': 'Email cannot be blank',
      'password_required': 'Password cannot be blank',
      'invalid_email': 'Invalid email format',
      'password_too_short': 'Password must be at least 8 characters',
      'email_already_registered': "There's already a register with this email",
      'register_error': 'Error during registration',
      'delete_user_error': 'Error deleting user',
      
      // Home Screen
      'plan_your_next_adventure': 'Plan your next adventure',
      'searching': 'Searching...',
      'search_results': 'Search Results',
      'found': '{0} found',
      'location_selected': 'Location Selected',
      'select_trip': 'Select Trip?',
      'use_trip_template': 'Would you like to use this trip as a template?',
      'cancel': 'Cancel',
      'select': 'Select',
      'try_different_words': 'Try searching with different words',
      'recommended_trips': 'Recommended Trips',
      'welcome': 'Welcome, {0}',
      'search_destinations': 'Search destinations...',
      'no_results_found': 'No results found',
      'selected': 'Selected: {0}',
      'days': '{0} days',
      'brazilian_northeast': 'Brazilian Northeast',
      'southern_brazil': 'Southern Brazil',
      
      // Trip Register Screen
      'new_trip': 'New Trip',
      'trip_data': 'Trip Data',
      'trip_title': 'Trip Title',
      'transport': 'Transport',
      'car': 'Car',
      'motorcycle': 'Motorcycle',
      'bus': 'Bus',
      'airplane': 'Airplane',
      'ship': 'Ship',
      'group_data': 'Group Data',
      'age': 'Age',
      'add_person': 'Add Person',
      'group_members': 'Group Members ({0})',
      'map': 'Map',
      'fullscreen_map': 'Fullscreen Map',
      'register_trip': 'Register Trip',
      'success': 'Success!',
      'trip_created_successfully': 'Trip created successfully!',
      'error': 'Error',
      'ok': 'Ok',
      
      // Trip Validations
      'trip_title_required': 'Trip title is required.',
      'group_empty': 'Please add at least one person to the group.',
      'stops_empty': 'Please add at least one stop to the trip.',
      'age_required': 'Age is required.',
      'age_invalid': 'Age must be a valid number.',
      'start_date_required': 'Start date is required.',
      'end_date_required': 'End date is required.',
      'end_date': 'End date cannot be before start date.',
      
      // List Trips
      'yourTrips': 'Your Trips',
      'activeTrips': 'Active Trips',
      'concludedTrips': 'Concluded Trips',
      'noActiveTrips': 'No active trips',
      'startPlanning': 'Start planning your next adventure!',
      'noConcludedTrips': 'No concluded trips',
      'completeTrips': 'Complete your trips to see them here',
      'ended': 'Ended',
      'markAsConcluded': 'Mark as Concluded',
      'concludeTrip': 'Conclude Trip',
      'tripEndedOn': 'The trip "{title}" has ended on {date}.',
      'confirmConclude': 'Would you like to mark it as concluded?',
      'notNow': 'Not Now',
      'tripConcludedSuccess': 'Trip marked as concluded!',
      'tripConcludedError': 'Error concluding trip',
      'fieldRequired': 'Field required.',
      
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
      'delete': 'Delete',
      'log_out': 'Log Out',
      'log_out_confirm': 'Log Out?',
    },
    'pt': {
      // Login Screen
      'welcome_back': 'Bem-vindo de Volta!',
      'sign_in_subtitle': 'Entre para continuar sua jornada',
      'email': 'E-mail',
      'password': 'Senha',
      'sign_in': 'Entrar',
      'no_account': 'Não tem uma conta? Clique aqui para criar uma!',
      'no_account_question': 'Não tem uma conta? ',
      'sign_up_link': 'Cadastre-se',
      'or': 'ou',
      'login_successful': 'Login Realizado',
      'welcome_user': 'Bem-vindo, {0}!',
      'continue': 'Continuar',
      'login_failed': 'Falha no Login',
      'email_password_incorrect': 'E-mail ou senha incorretos',
      'try_again': 'Tentar Novamente',
      
      // Register Screen
      'create_account': 'Crie Sua Conta',
      'sign_up_subtitle': 'Junte-se a nós e comece a planejar suas viagens',
      'name': 'Nome',
      'sign_up': 'Cadastrar',
      'have_account': 'Já tem uma conta? Clique aqui para entrar!',
      'have_account_question': 'Já tem uma conta? ',
      'sign_in_link': 'Entre',
      'register_successful': 'Cadastro Realizado',
      'can_login_now': 'Agora você pode fazer login com suas credenciais',
      'go_to_login': 'Ir para Login',
      
      // Validation Errors
      'field_required': 'Este campo é obrigatório',
      'name_required': 'Nome não pode estar em branco',
      'email_required': 'E-mail não pode estar em branco',
      'password_required': 'Senha não pode estar em branco',
      'invalid_email': 'Formato de e-mail inválido',
      'password_too_short': 'A senha deve ter pelo menos 8 caracteres',
      'email_already_registered': 'Já existe um cadastro com este e-mail',
      'register_error': 'Erro ao realizar cadastro',
      'delete_user_error': 'Erro ao deletar usuário',
      
      // Home Screen
      'plan_your_next_adventure': 'Planeje sua próxima aventura',
      'searching': 'Buscando...',
      'search_results': 'Resultados da Busca',
      'found': '{0} encontrados',
      'location_selected': 'Local Selecionado',
      'select_trip': 'Selecionar Viagem?',
      'use_trip_template': 'Deseja usar esta viagem como modelo?',
      'cancel': 'Cancelar',
      'select': 'Selecionar',
      'try_different_words': 'Tente buscar com outras palavras',
      'recommended_trips': 'Viagens Recomendadas',
      'welcome': 'Bem-vindo, {0}',
      'search_destinations': 'Buscar destinos...',
      'no_results_found': 'Nenhum resultado encontrado',
      'selected': 'Selecionado: {0}',
      'days': '{0} dias',
      'brazilian_northeast': 'Nordeste Brasileiro',
      'southern_brazil': 'Sul do Brasil',
      
      'new_trip': 'Nova Viagem',
      'trip_data': 'Dados da Viagem',
      'trip_title': 'Título da Viagem',
      'transport': 'Transporte',
      'car': 'Carro',
      'motorcycle': 'Moto',
      'bus': 'Ônibus',
      'airplane': 'Avião',
      'ship': 'Navio',
      'group_data': 'Dados do Grupo',
      'age': 'Idade',
      'add_person': 'Adicionar Pessoa',
      'group_members': 'Integrantes do Grupo ({0})',
      'map': 'Mapa',
      'fullscreen_map': 'Mapa em Tela Cheia',
      'register_trip': 'Cadastrar Viagem',
      'success': 'Sucesso!',
      'trip_created_successfully': 'Viagem criada com sucesso!',
      'error': 'Erro',
      'ok': 'Ok',
      
      // Trip Validations
      'trip_title_required': 'O título da viagem é obrigatório.',
      'group_empty': 'Adicione pelo menos uma pessoa ao grupo.',
      'stops_empty': 'Adicione pelo menos uma parada à viagem.',
      'age_required': 'A idade é obrigatória.',
      'age_invalid': 'A idade deve ser um número válido.',
      'start_date_required': 'A data de início é obrigatória.',
      'end_date_required': 'A data de término é obrigatória.',
      'end_date': 'A data de término não pode ser anterior à data de início.',
      
      // List Trips
      'yourTrips': 'Suas Viagens',
      'activeTrips': 'Viagens Ativas',
      'concludedTrips': 'Viagens Concluídas',
      'noActiveTrips': 'Nenhuma viagem ativa',
      'startPlanning': 'Comece a planejar sua próxima aventura!',
      'noConcludedTrips': 'Nenhuma viagem concluída',
      'completeTrips': 'Conclua suas viagens para vê-las aqui',
      'ended': 'Encerrada',
      'markAsConcluded': 'Marcar como Concluída',
      'concludeTrip': 'Concluir Viagem',
      'tripEndedOn': 'A viagem "{title}" terminou em {date}.',
      'confirmConclude': 'Deseja marcá-la como concluída?',
      'notNow': 'Agora não',
      'tripConcludedSuccess': 'Viagem marcada como concluída!',
      'tripConcludedError': 'Erro ao concluir viagem',
      'fieldRequired': 'Campo obrigatório.',
      
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
      'delete': 'Deletar',
      'log_out': 'Sair',
      'log_out_confirm': 'Sair?',
    },
    'es': {
      // Login Screen
      'welcome_back': '¡Bienvenido de Nuevo!',
      'sign_in_subtitle': 'Inicia sesión para continuar tu viaje',
      'email': 'Correo Electrónico',
      'password': 'Contraseña',
      'sign_in': 'Iniciar Sesión',
      'no_account': '¿No tienes una cuenta? ¡Haz clic aquí para crear una!',
      'no_account_question': '¿No tienes una cuenta? ',
      'sign_up_link': 'Regístrate',
      'or': 'o',
      'login_successful': 'Inicio de Sesión Exitoso',
      'welcome_user': '¡Bienvenido, {0}!',
      'continue': 'Continuar',
      'login_failed': 'Error de Inicio de Sesión',
      'email_password_incorrect': 'Correo o contraseña incorrectos',
      'try_again': 'Intentar de Nuevo',
      
      // Register Screen
      'create_account': 'Crea Tu Cuenta',
      'sign_up_subtitle': 'Únete a nosotros y comienza a planificar tus viajes',
      'name': 'Nombre',
      'sign_up': 'Registrarse',
      'have_account': '¿Ya tienes una cuenta? ¡Haz clic aquí para iniciar sesión!',
      'have_account_question': '¿Ya tienes una cuenta? ',
      'sign_in_link': 'Inicia Sesión',
      'register_successful': 'Registro Exitoso',
      'can_login_now': 'Ahora puedes iniciar sesión con tus credenciales',
      'go_to_login': 'Ir al Inicio de Sesión',
      
      // Validation Errors
      'field_required': 'Este campo es obligatorio',
      'name_required': 'El nombre no puede estar en blanco',
      'email_required': 'El correo no puede estar en blanco',
      'password_required': 'La contraseña no puede estar en blanco',
      'invalid_email': 'Formato de correo inválido',
      'password_too_short': 'La contraseña debe tener al menos 8 caracteres',
      'email_already_registered': 'Ya existe un registro con este correo',
      'register_error': 'Error al realizar el registro',
      'delete_user_error': 'Error al eliminar usuario',
      
      // Home Screen
      'plan_your_next_adventure': 'Planifica tu próxima aventura',
      'searching': 'Buscando...',
      'search_results': 'Resultados de la Búsqueda',
      'found': '{0} encontrados',
      'location_selected': 'Ubicación Seleccionada',
      'select_trip': '¿Seleccionar Viaje?',
      'use_trip_template': '¿Quieres usar este viaje como plantilla?',
      'cancel': 'Cancelar',
      'select': 'Seleccionar',
      'try_different_words': 'Intenta buscar con otras palabras',
      'recommended_trips': 'Viajes Recomendados',
      'welcome': 'Bienvenido, {0}',
      'search_destinations': 'Buscar destinos...',
      'no_results_found': 'No se encontraron resultados',
      'selected': 'Seleccionado: {0}',
      'days': '{0} días',
      'brazilian_northeast': 'Nordeste Brasileño',
      'southern_brazil': 'Sur de Brasil',
      
      // Trip Register Screen
      'new_trip': 'Nuevo Viaje',
      'trip_data': 'Datos del Viaje',
      'trip_title': 'Título del Viaje',
      'transport': 'Transporte',
      'car': 'Coche',
      'motorcycle': 'Motocicleta',
      'bus': 'Autobús',
      'airplane': 'Avión',
      'ship': 'Barco',
      'group_data': 'Datos del Grupo',
      'age': 'Edad',
      'add_person': 'Agregar Persona',
      'group_members': 'Miembros del Grupo ({0})',
      'map': 'Mapa',
      'fullscreen_map': 'Mapa en Pantalla Completa',
      'register_trip': 'Registrar Viaje',
      'success': '¡Éxito!',
      'trip_created_successfully': '¡Viaje creado con éxito!',
      'error': 'Error',
      'ok': 'Ok',
      
      // Trip Validations
      'trip_title_required': 'El título del viaje es obligatorio.',
      'group_empty': 'Agrega al menos una persona al grupo.',
      'stops_empty': 'Agrega al menos una parada al viaje.',
      'age_required': 'La edad es obligatoria.',
      'age_invalid': 'La edad debe ser un número válido.',
      'start_date_required': 'La fecha de inicio es obligatoria.',
      'end_date_required': 'La fecha de finalización es obligatoria.',
      'end_date': 'La fecha de finalización no puede ser anterior a la fecha de inicio.',
      
      // List Trips
      'yourTrips': 'Tus Viajes',
      'activeTrips': 'Viajes Activos',
      'concludedTrips': 'Viajes Concluidos',
      'noActiveTrips': 'No hay viajes activos',
      'startPlanning': '¡Comienza a planear tu próxima aventura!',
      'noConcludedTrips': 'No hay viajes concluidos',
      'completeTrips': 'Completa tus viajes para verlos aquí',
      'ended': 'Finalizado',
      'markAsConcluded': 'Marcar como Concluido',
      'concludeTrip': 'Concluir Viaje',
      'tripEndedOn': 'El viaje "{title}" terminó el {date}.',
      'confirmConclude': '¿Deseas marcarlo como concluido?',
      'notNow': 'Ahora no',
      'tripConcludedSuccess': '¡Viaje marcado como concluido!',
      'tripConcludedError': 'Error al concluir el viaje',
      'fieldRequired': 'Campo obligatorio.',
      
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

  // Getters for Login Screen
  String get welcomeBack => translate('welcome_back');
  String get signInSubtitle => translate('sign_in_subtitle');
  String get email => translate('email');
  String get password => translate('password');
  String get signIn => translate('sign_in');
  String get noAccount => translate('no_account');
  String get noAccountQuestion => translate('no_account_question');
  String get signUpLink => translate('sign_up_link');
  String get or => translate('or');
  String get loginSuccessful => translate('login_successful');
  String welcomeUser(String name) => translate('welcome_user', [name]);
  String get continueText => translate('continue');
  String get loginFailed => translate('login_failed');
  String get emailPasswordIncorrect => translate('email_password_incorrect');
  String get tryAgain => translate('try_again');
  
  // Getters for Register Screen
  String get createAccount => translate('create_account');
  String get signUpSubtitle => translate('sign_up_subtitle');
  String get name => translate('name');
  String get signUp => translate('sign_up');
  String get haveAccount => translate('have_account');
  String get haveAccountQuestion => translate('have_account_question');
  String get signInLink => translate('sign_in_link');
  String get registerSuccessful => translate('register_successful');
  String get canLoginNow => translate('can_login_now');
  String get goToLogin => translate('go_to_login');
  
  // Getters for Validation Errors
  String get fieldRequired => translate('field_required');
  String get nameRequired => translate('name_required');
  String get emailRequired => translate('email_required');
  String get passwordRequired => translate('password_required');
  String get invalidEmail => translate('invalid_email');
  String get passwordTooShort => translate('password_too_short');
  String get emailAlreadyRegistered => translate('email_already_registered');
  String get registerError => translate('register_error');
  String get deleteUserError => translate('delete_user_error');
  
  // Home Screen
  String welcome(String name) => translate('welcome', [name]);
  String get planYourNextAdventure => translate('plan_your_next_adventure');
  String get searchDestinations => translate('search_destinations');
  String get searching => translate('searching');
  String get searchResults => translate('search_results');
  String found(String count) => translate('found', [count]);
  String get locationSelected => translate('location_selected');
  String get selectTrip => translate('select_trip');
  String get useTripTemplate => translate('use_trip_template');
  String get cancel => translate('cancel');
  String get select => translate('select');
  String get noResultsFound => translate('no_results_found');
  String get tryDifferentWords => translate('try_different_words');
  String get recommendedTrips => translate('recommended_trips');
  String selected(String name) => translate('selected', [name]);
  String days(String count) => translate('days', [count]);
  String get brazilianNortheast => translate('brazilian_northeast');
  String get southernBrazil => translate('southern_brazil');
  
  // Getters for Trip Register Screen
  String get newTrip => translate('new_trip');
  String get tripData => translate('trip_data');
  String get tripTitle => translate('trip_title');
  String get transport => translate('transport');
  String get car => translate('car');
  String get motorcycle => translate('motorcycle');
  String get bus => translate('bus');
  String get airplane => translate('airplane');
  String get ship => translate('ship');
  String get groupData => translate('group_data');
  String get age => translate('age');
  String get addPerson => translate('add_person');
  String groupMembers(String count) => translate('group_members', [count]);
  String get map => translate('map');
  String get fullscreenMap => translate('fullscreen_map');
  String get registerTrip => translate('register_trip');
  String get success => translate('success');
  String get tripCreatedSuccessfully => translate('trip_created_successfully');
  String get error => translate('error');
  String get ok => translate('ok');
  
  String get tripTitleRequired => translate('trip_title_required');
  String get groupEmpty => translate('group_empty');
  String get stopsEmpty => translate('stops_empty');
  String get ageRequired => translate('age_required');
  String get ageInvalid => translate('age_invalid');
  String get startDateRequired => translate('start_date_required');
  String get endDateRequired => translate('end_date_required');
  String get endDate => translate('end_date');
  String get unexpectedError => translate('unexpected_error');
  
  // Getters for List Trips Screen
  // Getters usados na tela de viagens
  String get yourTrips => translate('yourTrips');
  String get activeTrips => translate('activeTrips');
  String get concludedTrips => translate('concludedTrips');
  String get noActiveTrips => translate('noActiveTrips');
  String get startPlanning => translate('startPlanning');
  String get noConcludedTrips => translate('noConcludedTrips');
  String get completeTrips => translate('completeTrips');
  String get ended => translate('ended');
  String get markAsConcluded => translate('markAsConcluded');
  String get concludeTrip => translate('concludeTrip');
  String tripEndedOn(String title, String date) =>
      translate('tripEndedOn').replaceAll('{title}', title).replaceAll('{date}', date);
  String get confirmConclude => translate('confirmConclude');
  String get notNow => translate('notNow');
  String get tripConcludedSuccess => translate('tripConcludedSuccess');
  String get tripConcludedError => translate('tripConcludedError');
  
  // Getters for Config Screen
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