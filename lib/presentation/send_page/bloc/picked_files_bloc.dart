// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:local_share/main.dart';

///
///EVENT
///
abstract class PickedFilesBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickedFilesBlocEvent_selectFile extends PickedFilesBlocEvent {}

class PickedFilesBlocEvent_selectPhotoFromGallery
    extends PickedFilesBlocEvent {}

class PickedFilesBlocEvent_selectPhotoFromCamera extends PickedFilesBlocEvent {}

class PickedFilesBlocEvent_selectMultipleFile extends PickedFilesBlocEvent {}

class PickedFilesBlocEvent_clearFile extends PickedFilesBlocEvent {}

///
/// STATE
///
abstract class PickedFilesBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickedFilesBlocStateLoaded extends PickedFilesBlocState {
  final List<File> files;

  PickedFilesBlocStateLoaded({this.files = const []});

  @override
  List<Object?> get props => [files];

  PickedFilesBlocStateLoaded copyWith({List<File>? files}) {
    return PickedFilesBlocStateLoaded(files: files ?? this.files);
  }
}

///
/// BLOC
///
class PickedFilesBloc extends Bloc<PickedFilesBlocEvent, PickedFilesBlocState> {
  PickedFilesBloc() : super(PickedFilesBlocStateLoaded()) {
    ///
    /// SELECT FILE
    ///
    on<PickedFilesBlocEvent_selectFile>((event, emit) async {
      logger.i('Select file tapped');

      final result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.first.path!);
        emit(PickedFilesBlocStateLoaded(files: [file]));
      }
    });

    ///
    /// SELECT PHOTO FROM GALLERY
    ///
    on<PickedFilesBlocEvent_selectPhotoFromGallery>((event, emit) async {
      logger.i('Select photo from gallery');

      final picker = ImagePicker();
      final result = await picker.pickMultiImage();

      if (result.isNotEmpty) {
        final listFile = result.map((xfile) => File(xfile.path)).toList();

        emit(PickedFilesBlocStateLoaded(files: listFile));
      }
    });

    ///
    /// SELECT PHOTO FROM CAMERA
    ///
    on<PickedFilesBlocEvent_selectPhotoFromCamera>((event, emit) async {
      logger.i('Select photo from gallery');

      final picker = ImagePicker();
      final result = await picker.pickImage(source: ImageSource.camera);

      if (result != null) {
        final file = File(result.path);
        emit(PickedFilesBlocStateLoaded(files: [file]));
      }
    });

    ///
    /// SELECT MULTIPLE FILE
    ///
    on<PickedFilesBlocEvent_selectMultipleFile>((event, emit) async {
      logger.i('Select multiple file tapped');

      final result = await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result != null) {
        final List<File> list = result.files
            .map((file) => File(file.path!))
            .toList();
        emit(PickedFilesBlocStateLoaded(files: list));
      }
    });

    ///
    /// CLEAR FILES
    ///
    on<PickedFilesBlocEvent_clearFile>((event, emit) {
      logger.i('Clear file tapped');
      emit(PickedFilesBlocStateLoaded());
    });
  }
}
