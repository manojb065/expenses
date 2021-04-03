import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> rt;
  Chart(this.rt);

  List<Map<String, Object>> get groupTrans {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      print(weekday);
      double tsum = 0.0;
      for (int i = 0; i < rt.length; i++) {
        if (rt[i].date.day == weekday.day &&
            rt[i].date.weekday == weekday.weekday &&
            rt[i].date.year == weekday.year) {
          tsum += rt[i].amount;
        }
      }
      return {'Day': DateFormat.E().format(weekday), 'spent': tsum};
    });
  }

  double get maxSpend {
    return groupTrans.fold(0.0, (p, e) {
      return p + e['spent'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupTrans);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...groupTrans.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: Barchart(
                    e['Day'],
                    maxSpend == 0.0 ? 0.0 : (e['spent'] as double) / maxSpend,
                    e['spent']),
              );
            })
          ],
        ),
      ),
    );
  }
}
