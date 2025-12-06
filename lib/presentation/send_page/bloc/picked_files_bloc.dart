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

class PickedFilesBlocEvent_removeFile extends PickedFilesBlocEvent {
  final int index;
  PickedFilesBlocEvent_removeFile({required this.index});

  @override
  List<Object?> get props => [index];
}

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
  // Expose files for external access
  List<File> get files {
    final result = state is PickedFilesBlocStateLoaded 
        ? (state as PickedFilesBlocStateLoaded).files 
        : <File>[];
    logger.i('Accessing files, count: ${result.length}');
    return result;
  }
      
  PickedFilesBloc() : super(PickedFilesBlocStateLoaded()) {
    ///
    /// SELECT FILE
    ///
    on<PickedFilesBlocEvent_selectFile>((event, emit) async {
      logger.i('Select file tapped');

      final result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.first.path!);
        logger.i('Selected file: ${file.path}');
        
        // Validate file
        if (file.path.isEmpty) {
          logger.e('Selected file has empty path');
          return;
        }
        
        if (!file.existsSync()) {
          logger.e('Selected file does not exist: ${file.path}');
          return;
        }
        
        try {
          final length = await file.length();
          logger.i('Selected file size: $length bytes');
        } catch (e) {
          logger.e('Cannot read selected file size: $e');
        }

        final currentState = state;

        if (currentState is PickedFilesBlocStateLoaded) {
          List<File> newfiles = List.from(currentState.files);
          newfiles.add(file);
          logger.i('Total files: ${newfiles.length}');
          emit(PickedFilesBlocStateLoaded(files: newfiles));
        }
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
        logger.i('Selected ${listFile.length} photos from gallery');
        
        // Validate files
        final validFiles = <File>[];
        for (var i = 0; i < listFile.length; i++) {
          final file = listFile[i];
          if (file.path.isEmpty) {
            logger.w('Skipping empty file path at index $i');
            continue;
          }
          
          if (!file.existsSync()) {
            logger.w('File does not exist: ${file.path}');
            continue;
          }
          
          try {
            final length = await file.length();
            logger.i('File $i size: $length bytes');
          } catch (e) {
            logger.e('Cannot read file size: $e');
          }
          
          validFiles.add(file);
        }

        final currentState = state;
        if (currentState is PickedFilesBlocStateLoaded) {
          List<File> newfiles = List.from(currentState.files);
          newfiles = newfiles + validFiles;
          logger.i('Total files: ${newfiles.length}');
          emit(PickedFilesBlocStateLoaded(files: newfiles));
        }
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
        logger.i('Selected photo from camera: ${file.path}');
        
        // Validate file
        if (file.path.isEmpty) {
          logger.e('Camera photo has empty path');
          return;
        }
        
        if (!file.existsSync()) {
          logger.e('Camera photo does not exist: ${file.path}');
          return;
        }
        
        try {
          final length = await file.length();
          logger.i('Camera photo size: $length bytes');
        } catch (e) {
          logger.e('Cannot read camera photo size: $e');
        }

        final currentState = state;

        if (currentState is PickedFilesBlocStateLoaded) {
          List<File> newfiles = List.from(currentState.files);
          newfiles.add(file);
          logger.i('Total files: ${newfiles.length}');
          emit(PickedFilesBlocStateLoaded(files: newfiles));
        }
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
        logger.i('Selected ${list.length} files');
        
        // Validate files
        final validFiles = <File>[];
        for (var i = 0; i < list.length; i++) {
          final file = list[i];
          if (file.path.isEmpty) {
            logger.w('Skipping empty file path at index $i');
            continue;
          }
          
          if (!file.existsSync()) {
            logger.w('File does not exist: ${file.path}');
            continue;
          }
          
          try {
            final length = await file.length();
            logger.i('File $i size: $length bytes');
          } catch (e) {
            logger.e('Cannot read file size: $e');
          }
          
          validFiles.add(file);
        }

        final currentState = state;
        if (currentState is PickedFilesBlocStateLoaded) {
          List<File> newfiles = List.from(currentState.files);
          newfiles = newfiles + validFiles;
          logger.i('Total files: ${newfiles.length}');
          emit(PickedFilesBlocStateLoaded(files: newfiles));
        }
      }
    });

    ///
    /// CLEAR FILES
    ///
    on<PickedFilesBlocEvent_clearFile>((event, emit) {
      logger.i('Clear file tapped');
      emit(PickedFilesBlocStateLoaded());
    });

    ///
    /// ON REMOVE FILE
    ///
    on<PickedFilesBlocEvent_removeFile>((event, emit) {
      logger.i('Remove file');

      final currentState = state;

      if (currentState is PickedFilesBlocStateLoaded) {
        List<File> newList = List.from(currentState.files);

        newList.removeAt(event.index);
        emit(PickedFilesBlocStateLoaded(files: newList));
      }
    });
  }
}
