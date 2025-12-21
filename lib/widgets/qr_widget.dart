import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrWidget extends StatelessWidget {
  const QrWidget({super.key , this.data = 'http://localhost:8080'});
  final String data;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(AppConstant.appBorder),
      child: SizedBox(
        width: size.width * 0.5,
        height: size.width * 0.5,
        child: PrettyQrView.data(
          data: data,
          decoration:  PrettyQrDecoration(
            image: const PrettyQrDecorationImage(image: AssetImage('assets/share.png')),
            quietZone: PrettyQrQuietZone.standart,
            background: theme.colorScheme.primary.withOpacity(0.1)
          ),
        ),
      ),
    );
  }
}
