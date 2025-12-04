// define your context menu entries
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/presentation/send_page/bloc/picked_files_bloc.dart';

getEntries(BuildContext context) => <ContextMenuEntry>[
  //const MenuHeader(text: "Context Menu"),
  MenuItem(
    label: const Text('Select File'),
    icon: const Icon(AppIcon.documentIcon),
    onSelected: (value) {
      context.read<PickedFilesBloc>().add(PickedFilesBlocEvent_selectFile());
    },
  ),
  MenuItem.submenu(
    items: [
      MenuItem(
        label: const Text('From gallery'),
        value: "gallery",
        icon: const Icon(AppIcon.imageIcon),
        onSelected: (value) {},
      ),
      MenuItem(
        label: const Text('From camera'),
        value: 'camera',
        icon: const Icon(AppIcon.cameraIcon),
        onSelected: (value) {
          // implement redo
        },
      ),
    ],
    label: const Text('Select Photo'),
    icon: const Icon(AppIcon.imageIcon),
    onSelected: (value) {
      // implement cut
    },
  ),
  MenuItem(
    label: const Text('Select Multiple Files'),
    icon: const Icon(AppIcon.multipleFileIcon),
    onSelected: (value) {
      context.read<PickedFilesBloc>().add(
        PickedFilesBlocEvent_selectMultipleFile(),
      );
    },
  ),
];

// initialize a context menu
ContextMenu menu(BuildContext context) => ContextMenu(
  entries: getEntries(context),
  position: const Offset(400, 450),
  padding: const EdgeInsets.all(8.0),
);
