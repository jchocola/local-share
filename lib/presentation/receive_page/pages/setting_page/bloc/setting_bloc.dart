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
  SettingBlocState_loaded({
    required this.overwriteExistingFile,
    required this.autoAcceptSmallFile,
    required this.transferNotification,
  });

  @override
  List<Object?> get props => [
    overwriteExistingFile,
    autoAcceptSmallFile,
    transferNotification,
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
    on<SettingBlocEvent_load>((event, emit) {
      final overwrite = sharedRepo.getOverwriteExistingFile();
      final autoAccept = sharedRepo.getAutoAcceptSmallFile();
      final transferNot = sharedRepo.getTransferNotification();

      logger.i(
        'Setting bloc loaded : overwrite $overwrite, autoAccept $autoAccept , transferNot $transferNot',
      );

      emit(
        SettingBlocState_loaded(
          overwriteExistingFile: overwrite,
          autoAcceptSmallFile: autoAccept,
          transferNotification: transferNot,
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
    on<SettingBlocEvent_termsOfServiceTapped>((event, emit) async{
        await launchUrl(Uri.parse(AppConstant.termOfServiceUrl));
   
  });

    ///
    ///  Privacy Policy
    ///
    on<SettingBlocEvent_privacyPolicyTapped>((event, emit) async{
      await launchUrl(Uri.parse(AppConstant.privacyPolicyUrl));
    });
  }
}
