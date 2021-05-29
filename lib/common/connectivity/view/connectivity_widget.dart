import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kouiz/common/common.dart';
import 'package:kouiz/common/connectivity/service/connectivity_provider.dart';
import 'package:kouiz/theme/constants.dart';
import '../../common.dart';

class ConnectivityWidget extends ConsumerWidget {
  const ConnectivityWidget({Key? key, required this.networkWidget})
      : super(key: key);
  final Widget networkWidget;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final connectionState = watch(connectivityProvider);
    return ParticlesBackground(
      child: Center(
        child: connectionState.when(
            data: (data) => data == ConnectivityResult.none
                ? OfflineWidget()
                : networkWidget,
            loading: () => LoadingIndicator(),
            error: (_, __) => Container()),
      ),
    );
  }
}

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ParticlesBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.wifi_off,
              size: 72,
              color: Theme.of(context).disabledColor,
            ),
            SizedBox(
              height: kBaseFactor,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  'Please connect to the internet',
                  style: TextStyle(color: Theme.of(context).disabledColor),
                  textScaleFactor: 1.2,
                ))
          ],
        ),
      ),
    );
  }
}
