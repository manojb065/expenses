import 'package:flutter/material.dart';

class Barchart extends StatelessWidget {
  final String label;
  final double spent;
  final double per;
  Barchart(this.label, this.per, this.spent);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, con) {
        return Column(
          children: [
            Container(
              height: con.maxHeight * 0.15,
              child: FittedBox(
                child: Text('\u{20B9} ${spent.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: con.maxHeight * 0.05,
            ),
            Container(
              height: con.maxHeight * 0.6,
              width: 10,
              child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                )),
                FractionallySizedBox(
                    heightFactor: per,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
              ]),
            ),
            SizedBox(
              height: con.maxHeight * 0.05,
            ),
            Container(height: con.maxHeight * 0.15, child: Text('${label}')),
          ],
        );
        ;
      },
    );
  }
}
