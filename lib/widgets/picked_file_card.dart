import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/core/utils/format_file_size.dart';
import 'package:path/path.dart' as p;
import 'package:mime/mime.dart';
import 'package:thumbnailer/thumbnailer.dart';

class PickedFileCard extends StatelessWidget {
  const PickedFileCard({super.key, this.withFixedWidth = false, this.file});
  final bool withFixedWidth;
  final File? file;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return SizedBox(
      width: withFixedWidth ? size.width * 0.6 : double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.appPadding),
          child: Row(
            spacing: AppConstant.appPadding,
            children: [
              //Icon(AppIcon.documentIcon, color: theme.colorScheme.primary),
              Thumbnail(
                mimeType: lookupMimeType(file!.path) ?? 'default',
                widgetSize: AppConstant.bigIcon,
                dataResolver: () async {
                  return file!.readAsBytes();
                },
              ),
              SizedBox(
                 width: withFixedWidth ? size.width * 0.4 : double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.basename(file?.path ?? 'Unknown'),
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatFileSize(file?.lengthSync() ?? 0),
                          style: theme.textTheme.bodySmall,
                        ),
                
                        Text(p.extension(file!.path, ), style: theme.textTheme.bodySmall,)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
