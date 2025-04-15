import 'package:attendance_check/view/hub/model/qr/qr_generation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerationView extends StatelessWidget {
  const QrGenerationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QrGeneretionModel>(
      create: (context) => QrGeneretionModel(),
      child: const _DataEntryWidget(),
    );
  }
}

class _DataEntryWidget extends StatelessWidget {
  const _DataEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<QrGeneretionModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Генерация QR-кода'),
        centerTitle: true,
      ),
      body: Center(
        child: Tooltip(
          message: "Вы успешно отмечены на лекции",
          child: QrImageView(
            data: model.qrData,
            size: 300,
            version: QrVersions.auto,
          ),
        ),
      ),
    );
  }
}
