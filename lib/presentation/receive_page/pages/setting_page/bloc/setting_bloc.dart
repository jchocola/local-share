import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';

import 'package:local_share/data/repo/shared_prefs_repository_impl.dart';
import 'package:local_share/main.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// EVENT
///
abstract class SettingBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingBlocEvent_load extends SettingBlocEvent {}

class SettingBlocEvent_toogleOverwriteExistingFile extends SettingBlocEvent {}

class SettingBlocEvent_toogleAutoAcceptSmallFile extends SettingBlocEvent {}

class SettingBlocEvent_toogleTransferNotification extends SettingBlocEvent {}

class SettingBlocEvent_toogleTheme extends SettingBlocEvent {}

class SettingBlocEvent_termsOfServiceTapped extends SettingBlocEvent {}

class SettingBlocEvent_privacyPolicyTapped extends SettingBlocEvent {}

class SettingBlocEvent_changeChunkSize extends SettingBlocEvent {
  final int chunkSize;
  SettingBlocEvent_changeChunkSize({required this.chunkSize});

  @override
  List<Object?> get props => [chunkSize];
}

class SettingBlocEvent_changeLangCode extends SettingBlocEvent {
  final String langCode;
  SettingBlocEvent_changeLangCode({required this.langCode});

  @override
  List<Object?> get props => [langCode];
}

///
/// STATE
///
abstract class SettingBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingBlocState_init extends SettingBlocState {}

class SettingBlocState_loaded extends SettingBlocState {
  final bool overwriteExistingFile;
  final bool autoAcceptSmallFile;
  final bool transferNotification;
  final String downloadLocation;
  final int chunkSize;
  final String langCode;
  SettingBlocState_loaded({
    required this.overwriteExistingFile,
    required this.autoAcceptSmallFile,
    required this.transferNotification,
    required this.downloadLocation,
    required this.chunkSize,
    required this.langCode,
  });

  @override
  List<Object?> get props => [
    overwriteExistingFile,
    autoAcceptSmallFile,
    transferNotification,
    downloadLocation,
    chunkSize,
    langCode,
  ];
}

///
/// BLOC
///
class SettingBloc extends Bloc<SettingBlocEvent, SettingBlocState> {
  final SharedPrefsRepositoryImpl sharedRepo;

  SettingBloc({required this.sharedRepo}) : super(SettingBlocState_init()) {
    ///
    /// ON LOAD
    ///
    on<SettingBlocEvent_load>((event, emit) async {
      final overwrite = sharedRepo.getOverwriteExistingFile();
      final autoAccept = sharedRepo.getAutoAcceptSmallFile();
      final transferNot = sharedRepo.getTransferNotification();
      final downloadLocation = await sharedRepo.getDownloadLocation();
      final chunkSize = sharedRepo.getChunkSize();
      final langCode = sharedRepo.getLangCode();

      logger.i(
        'Setting bloc loaded : overwrite $overwrite, autoAccept $autoAccept , transferNot $transferNot , dowloadLocation $downloadLocation, chunkSize $chunkSize',
      );

      emit(
        SettingBlocState_loaded(
          overwriteExistingFile: overwrite,
          autoAcceptSmallFile: autoAccept,
          transferNotification: transferNot,
          downloadLocation: downloadLocation,
          chunkSize: chunkSize,
          langCode: langCode
        ),
      );
    });

    ///
    /// toogle exsiting file
    ///
    on<SettingBlocEvent_toogleOverwriteExistingFile>((event, emit) async {
      await sharedRepo.toogleOverwriteExistingFile();
      add(SettingBlocEvent_load());
    });

    ///
    /// toogle auto accept
    ///
    on<SettingBlocEvent_toogleAutoAcceptSmallFile>((event, emit) async {
      await sharedRepo.toogleAutoAcceptSmallFile();
      add(SettingBlocEvent_load());
    });

    ///
    /// toogle transfer notificaotion
    ///
    on<SettingBlocEvent_toogleTransferNotification>((event, emit) async {
      await sharedRepo.toogleTransferNotification();
      add(SettingBlocEvent_load());
    });

    ///
    /// Terms of service
    ///
    on<SettingBlocEvent_termsOfServiceTapped>((event, emit) async {
      await launchUrl(Uri.parse(AppConstant.termOfServiceUrl));
    });

    ///
    ///  Privacy Policy
    ///
    on<SettingBlocEvent_privacyPolicyTapped>((event, emit) async {
      await launchUrl(Uri.parse(AppConstant.privacyPolicyUrl));
    });

    ///
    /// CHANGE CHUNK SIZE
    ///
    on<SettingBlocEvent_changeChunkSize>((event, emit) async {
      await sharedRepo.changeChunkSize(chunkSize: event.chunkSize);
      add(SettingBlocEvent_load());
    });

       ///
    /// CHANGE LANG CODE
    ///
    on<SettingBlocEvent_changeLangCode>((event, emit) async {
      await sharedRepo.changeLangCode(langCode: event.langCode);
      add(SettingBlocEvent_load());
    });
  

  }


  

  // Method to get download location
  Future<String> getDownloadLocation() async {
    if (state is SettingBlocState_loaded) {
      return (state as SettingBlocState_loaded).downloadLocation;
    }
    // Return default download location if not loaded
    return await sharedRepo.getDownloadLocation();
  }
}
