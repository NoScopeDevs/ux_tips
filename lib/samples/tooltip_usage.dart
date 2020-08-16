import 'package:flutter/material.dart';

class TooltipUsage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.toString())),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < 4; i++)

            // * tip 7: use tooltips to make your app accesible

            Tooltip(
              message: i.toString(),
              child: FloatingActionButton(
                mini: true,
                child: Icon(Icons.add),
                onPressed: () {},
              ),
            )
        ],
      ),
    );
  }
}
