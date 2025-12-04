import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/core/utils/format_file_size.dart';
import 'package:path/path.dart' as p;
import 'package:mime/mime.dart';
import 'package:thanos_snap_effect/thanos_snap_effect.dart';
import 'package:thumbnailer/thumbnailer.dart';

class PickedFileCard extends StatefulWidget {
  const PickedFileCard({
    super.key,
    this.withFixedWidth = false,
    this.file,
    this.onLongPress,
  });
  final bool withFixedWidth;
  final File? file;
  final void Function()? onLongPress;

  @override
  State<PickedFileCard> createState() => _PickedFileCardState();
}

class _PickedFileCardState extends State<PickedFileCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
   // _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return GestureDetector(
      onLongPress: () async {
        // Запускаем "Thanos snap"
       

        // После исчезновения — вызываем удаление
        if (widget.onLongPress != null) {
          await _animationController.forward();
          widget.onLongPress!();
          
         // Восстанавливаем виджет (если надо)
  _animationController.reset();  
        }
      },
      child: Snappable(
        animation: _animationController,
        child: SizedBox(
          width: widget.withFixedWidth ? size.width * 0.6 : double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstant.appPadding),
              child: Row(
                spacing: AppConstant.appPadding,
                children: [
                  //Icon(AppIcon.documentIcon, color: theme.colorScheme.primary),
                  Thumbnail(
                    mimeType: lookupMimeType(widget.file!.path) ?? 'default',
                    widgetSize: AppConstant.bigIcon,
                    dataResolver: () async {
                      return widget.file!.readAsBytes();
                    },
                  ),
                  SizedBox(
                    width: widget.withFixedWidth
                        ? size.width * 0.4
                        : double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.basename(widget.file?.path ?? 'Unknown'),
                          style: theme.textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatFileSize(widget.file?.lengthSync() ?? 0),
                              style: theme.textTheme.bodySmall,
                            ),

                            Text(
                              p.extension(widget.file!.path),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
