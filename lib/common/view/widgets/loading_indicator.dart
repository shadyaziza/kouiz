import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitCubeGrid(
      itemBuilder: (_, int index) {
        return DecoratedBox(
            decoration: BoxDecoration(
                color: index.isEven
                    ? Theme.of(context).cardColor
                    : Theme.of(context).disabledColor));
      },
    );
  }
}
