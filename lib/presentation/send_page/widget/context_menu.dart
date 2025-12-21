// define your context menu entries
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/send_page/bloc/picked_files_bloc.dart';

getEntries(BuildContext context) => <ContextMenuEntry>[
  //const MenuHeader(text: "Context Menu"),
  MenuItem(
    label: Text(S.of(context).selectFile),
    icon: const Icon(AppIcon.documentIcon),
    onSelected: (value) {
      context.read<PickedFilesBloc>().add(PickedFilesBlocEvent_selectFile());
    },
  ),
  MenuItem.submenu(
    items: [
      MenuItem(
        label: Text(S.of(context).fromGallery),
        value: "gallery",
        icon: const Icon(AppIcon.imageIcon),
        onSelected: (value) {
          context.read<PickedFilesBloc>().add(
            PickedFilesBlocEvent_selectPhotoFromGallery(),
          );
        },
      ),
      MenuItem(
        label: Text(S.of(context).fromCamera),
        value: 'camera',
        icon: const Icon(AppIcon.cameraIcon),
        onSelected: (value) {
          context.read<PickedFilesBloc>().add(
            PickedFilesBlocEvent_selectPhotoFromCamera(),
          );
        },
      ),
    ],
    label: Text(S.of(context).selectPhoto),
    icon: const Icon(AppIcon.imageIcon),
    onSelected: (value) {},
  ),
  MenuItem(
    label: Text(S.of(context).selectMultipleFiles),
    icon: const Icon(AppIcon.multipleFileIcon),
    onSelected: (value) {
      context.read<PickedFilesBloc>().add(
        PickedFilesBlocEvent_selectMultipleFile(),
      );
    },
  ),
];

// initialize a context menu
ContextMenu menu(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return ContextMenu(
    entries: getEntries(context),
    position:  Offset(size.width , size.height * 0.7),
    padding: const EdgeInsets.all(8.0),
  );
}
