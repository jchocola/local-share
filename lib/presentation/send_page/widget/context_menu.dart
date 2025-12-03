// define your context menu entries
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:local_share/core/icons/app_icon.dart';

final entries = <ContextMenuEntry>[
  //const MenuHeader(text: "Context Menu"),
  MenuItem(
    label: const Text('Select File'),
    icon: const Icon(AppIcon.documentIcon),
    onSelected: (value) {
      // implement copy
    },
  ),
  MenuItem(
 
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
      // implement paste
    },
  ),
];

// initialize a context menu
final menu = ContextMenu(
  entries: entries,
  position: const Offset(400, 450),
  padding: const EdgeInsets.all(8.0),
);