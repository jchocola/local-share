import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/utils/count_file_size.dart';
import 'package:local_share/core/utils/format_file_size.dart';
import 'package:local_share/presentation/send_page/bloc/picked_files_bloc.dart';
import 'package:local_share/widgets/picked_file_card.dart';

class FilesToSendWidget extends StatelessWidget {
  const FilesToSendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<PickedFilesBloc, PickedFilesBlocState>(
        builder: (context, state) {
          if (state is PickedFilesBlocStateLoaded) {
            return Card(
              child: Padding(
                padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Files to Send (${state.files.length})',
                      style: theme.textTheme.titleMedium,
                    ),
                   Center(
                     child: SizedBox(
                      height: size.height * 0.4,
                      child: SingleChildScrollView(
                        child: Column(
                         
                          children:  List.generate(state.files.length, (index) {
                          return PickedFileCard(file: state.files[index],withFixedWidth: true,);
                        }),
                        ),
                      ),
                     ),
                   ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Size',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                        Text(  formatFileSize(countFilesSize(files: state.files)), style: theme.textTheme.titleMedium),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
