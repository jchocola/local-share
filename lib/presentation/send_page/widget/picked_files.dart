import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/core/utils/count_file_size.dart';
import 'package:local_share/core/utils/format_file_size.dart';
import 'package:local_share/presentation/send_page/bloc/picked_files_bloc.dart';
import 'package:local_share/widgets/picked_file_card.dart';

class PickedFiles extends StatelessWidget {
  const PickedFiles({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<PickedFilesBloc, PickedFilesBlocState>(
      builder: (context, state) {
        if (state is PickedFilesBlocStateLoaded) {
          if (state.files.isEmpty) {
            return SizedBox();
          }

          return Column(
            spacing: AppConstant.appPadding,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${state.files.length} Files',
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(formatFileSize(countFilesSize(files:  state.files)), style: theme.textTheme.titleMedium),
                ],
              ),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<PickedFilesBloc>().add(
                        PickedFilesBlocEvent_clearFile(),
                      );
                    },
                    icon: Icon(AppIcon.deleteIcon),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          state.files.length,
                          (index) => PickedFileCard(withFixedWidth: true, file: state.files[index],),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
