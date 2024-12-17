import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';


class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.message, this.onClose});
  final String message;
  // call back function to close the error card
  final Function? onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: Consts.paddingM,
      // height: double.infinity,
      // width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 100,
            color: Colors.red,
          ),
          Consts.gapVM,
          Text(
            'errorOccurred',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Consts.gapVM,
          if (onClose != null)
            OutlinedButton(
              onPressed: () {
                onClose!();
              },
              child: Text('back'),
            ),
        ],
      ),
    );
  }
}
