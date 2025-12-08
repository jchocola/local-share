// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Server`
  String get server {
    return Intl.message('Server', name: 'server', desc: '', args: []);
  }

  /// `Receive`
  String get receive {
    return Intl.message('Receive', name: 'receive', desc: '', args: []);
  }

  /// `Select File`
  String get selectFile {
    return Intl.message('Select File', name: 'selectFile', desc: '', args: []);
  }

  /// `From gallery`
  String get fromGallery {
    return Intl.message(
      'From gallery',
      name: 'fromGallery',
      desc: '',
      args: [],
    );
  }

  /// `From camera`
  String get fromCamera {
    return Intl.message('From camera', name: 'fromCamera', desc: '', args: []);
  }

  /// `Select Photo`
  String get selectPhoto {
    return Intl.message(
      'Select Photo',
      name: 'selectPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Select Multiple Files`
  String get selectMultipleFiles {
    return Intl.message(
      'Select Multiple Files',
      name: 'selectMultipleFiles',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Send Feedback`
  String get sendFeedback {
    return Intl.message(
      'Send Feedback',
      name: 'sendFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Reset Device ID`
  String get resetDeviceId {
    return Intl.message(
      'Reset Device ID',
      name: 'resetDeviceId',
      desc: '',
      args: [],
    );
  }

  /// `Searching for devices...`
  String get searchingForDevices {
    return Intl.message(
      'Searching for devices...',
      name: 'searchingForDevices',
      desc: '',
      args: [],
    );
  }

  /// `Please select files to send...`
  String get pleaseSelectFilesToSend {
    return Intl.message(
      'Please select files to send...',
      name: 'pleaseSelectFilesToSend',
      desc: '',
      args: [],
    );
  }

  /// `Transfer via Server`
  String get transferViaServer {
    return Intl.message(
      'Transfer via Server',
      name: 'transferViaServer',
      desc: '',
      args: [],
    );
  }

  /// `Make sure that you and the recipient are on the same network!`
  String get makeSureThatYouAndTheRecipientAreOnThe {
    return Intl.message(
      'Make sure that you and the recipient are on the same network!',
      name: 'makeSureThatYouAndTheRecipientAreOnThe',
      desc: '',
      args: [],
    );
  }

  /// `Using this method, you can exchange data with any devices running different OS.`
  String get usingThisMethodYouCanExchangeDataWithAnyDevices {
    return Intl.message(
      'Using this method, you can exchange data with any devices running different OS.',
      name: 'usingThisMethodYouCanExchangeDataWithAnyDevices',
      desc: '',
      args: [],
    );
  }

  /// `({files}) files ready to serve in server.`
  String filesFilesReadyToServeInServer(Object files) {
    return Intl.message(
      '($files) files ready to serve in server.',
      name: 'filesFilesReadyToServeInServer',
      desc: '',
      args: [files],
    );
  }

  /// `Open Server`
  String get openServer {
    return Intl.message('Open Server', name: 'openServer', desc: '', args: []);
  }

  /// `IP Address`
  String get ipAddress {
    return Intl.message('IP Address', name: 'ipAddress', desc: '', args: []);
  }

  /// `Port`
  String get port {
    return Intl.message('Port', name: 'port', desc: '', args: []);
  }

  /// `Received files ({receivedFilesCount})`
  String receivedFilesReceivedfilescount(Object receivedFilesCount) {
    return Intl.message(
      'Received files ($receivedFilesCount)',
      name: 'receivedFilesReceivedfilescount',
      desc: '',
      args: [receivedFilesCount],
    );
  }

  /// `Show`
  String get show {
    return Intl.message('Show', name: 'show', desc: '', args: []);
  }

  /// `You are invisible to other devices!`
  String get youAreInvisibleToOtherDevices {
    return Intl.message(
      'You are invisible to other devices!',
      name: 'youAreInvisibleToOtherDevices',
      desc: '',
      args: [],
    );
  }

  /// `Turn on visibility to allow other devices to discover and send files to you`
  String get turnOnVisibilityToAllowOtherDevicesToDiscoverAnd {
    return Intl.message(
      'Turn on visibility to allow other devices to discover and send files to you',
      name: 'turnOnVisibilityToAllowOtherDevicesToDiscoverAnd',
      desc: '',
      args: [],
    );
  }

  /// `Become Visible`
  String get becomeVisible {
    return Intl.message(
      'Become Visible',
      name: 'becomeVisible',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for incoming connections...`
  String get waitingForIncomingConnections {
    return Intl.message(
      'Waiting for incoming connections...',
      name: 'waitingForIncomingConnections',
      desc: '',
      args: [],
    );
  }

  /// `Your device is ready to receive files. Other devices can send files to you when you're visible on the network.`
  String get yourDeviceIsReadyToReceiveFilesOtherDevicesCan {
    return Intl.message(
      'Your device is ready to receive files. Other devices can send files to you when you\'re visible on the network.',
      name: 'yourDeviceIsReadyToReceiveFilesOtherDevicesCan',
      desc: '',
      args: [],
    );
  }

  /// `Listening for requests`
  String get listeningForRequests {
    return Intl.message(
      'Listening for requests',
      name: 'listeningForRequests',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get stop {
    return Intl.message('Stop', name: 'stop', desc: '', args: []);
  }

  /// `Transfer Settings`
  String get transferSettings {
    return Intl.message(
      'Transfer Settings',
      name: 'transferSettings',
      desc: '',
      args: [],
    );
  }

  /// `Download Location`
  String get downloadLocation {
    return Intl.message(
      'Download Location',
      name: 'downloadLocation',
      desc: '',
      args: [],
    );
  }

  /// `Where received files are saved.`
  String get whereReceivedFilesAreSaved {
    return Intl.message(
      'Where received files are saved.',
      name: 'whereReceivedFilesAreSaved',
      desc: '',
      args: [],
    );
  }

  /// `Overwrite Existing Files`
  String get overwriteExistingFiles {
    return Intl.message(
      'Overwrite Existing Files',
      name: 'overwriteExistingFiles',
      desc: '',
      args: [],
    );
  }

  /// `If disabled, duplicate files are renamed automatically.`
  String get ifDisabledDuplicateFilesAreRenamedAutomatically {
    return Intl.message(
      'If disabled, duplicate files are renamed automatically.',
      name: 'ifDisabledDuplicateFilesAreRenamedAutomatically',
      desc: '',
      args: [],
    );
  }

  /// `Auto Accept Small Files`
  String get autoAcceptSmallFiles {
    return Intl.message(
      'Auto Accept Small Files',
      name: 'autoAcceptSmallFiles',
      desc: '',
      args: [],
    );
  }

  /// `Automatically accept transfers under 10MB from known devices.`
  String get automaticallyAcceptTransfersUnder10mbFromKnownDevices {
    return Intl.message(
      'Automatically accept transfers under 10MB from known devices.',
      name: 'automaticallyAcceptTransfersUnder10mbFromKnownDevices',
      desc: '',
      args: [],
    );
  }

  /// `Chunk Size`
  String get chunkSize {
    return Intl.message('Chunk Size', name: 'chunkSize', desc: '', args: []);
  }

  /// `The size of a piece of data during transferring.`
  String get theSizeOfAPieceOfDataDuringTransferring {
    return Intl.message(
      'The size of a piece of data during transferring.',
      name: 'theSizeOfAPieceOfDataDuringTransferring',
      desc: '',
      args: [],
    );
  }

  /// `Appereance Settings`
  String get appereanceSettings {
    return Intl.message(
      'Appereance Settings',
      name: 'appereanceSettings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Application Theme`
  String get applicationTheme {
    return Intl.message(
      'Application Theme',
      name: 'applicationTheme',
      desc: '',
      args: [],
    );
  }

  /// `Choose between light, dark`
  String get chooseBetweenLightDark {
    return Intl.message(
      'Choose between light, dark',
      name: 'chooseBetweenLightDark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Transfer Notifications`
  String get transferNotifications {
    return Intl.message(
      'Transfer Notifications',
      name: 'transferNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Receive alerts for incoming requests and completions.`
  String get receiveAlertsForIncomingRequestsAndCompletions {
    return Intl.message(
      'Receive alerts for incoming requests and completions.',
      name: 'receiveAlertsForIncomingRequestsAndCompletions',
      desc: '',
      args: [],
    );
  }

  /// `Legal Information`
  String get legalInformation {
    return Intl.message(
      'Legal Information',
      name: 'legalInformation',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get aboutApp {
    return Intl.message('About App', name: 'aboutApp', desc: '', args: []);
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Not founds receiver? Try send via server`
  String get notFoundsReceiverTrySendViaServer {
    return Intl.message(
      'Not founds receiver? Try send via server',
      name: 'notFoundsReceiverTrySendViaServer',
      desc: '',
      args: [],
    );
  }

  /// `{files} Files`
  String filesFiles(Object files) {
    return Intl.message(
      '$files Files',
      name: 'filesFiles',
      desc: '',
      args: [files],
    );
  }

  /// `Confirm Transfer`
  String get confirmTransfer {
    return Intl.message(
      'Confirm Transfer',
      name: 'confirmTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Files will be transferred over local network`
  String get filesWillBeTransferredOverLocalNetwork {
    return Intl.message(
      'Files will be transferred over local network',
      name: 'filesWillBeTransferredOverLocalNetwork',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection required`
  String get noInternetConnectionRequired {
    return Intl.message(
      'No internet connection required',
      name: 'noInternetConnectionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Transfer speed depends on network quality and setted chunk size`
  String get transferSpeedDependsOnNetworkQualityAndSettedChunkSize {
    return Intl.message(
      'Transfer speed depends on network quality and setted chunk size',
      name: 'transferSpeedDependsOnNetworkQualityAndSettedChunkSize',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Info`
  String get transferInfo {
    return Intl.message(
      'Transfer Info',
      name: 'transferInfo',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Send Files`
  String get sendFiles {
    return Intl.message('Send Files', name: 'sendFiles', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
