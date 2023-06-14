import 'package:flutter/material.dart';
import 'package:hautemerapp/models/data.dart';
import 'package:hautemerapp/ui/entry_card.dart';
import 'package:hautemerapp/ui/total_box.dart';


class Point extends StatefulWidget {
  const Point({super.key});

  @override
  State<Point> createState() => _PointState();
}

class _PointState extends State<Point> {
  double totalIncom = 0;
  double totalExpenses = 0;
  double totalBalance = 0;
  int currentIndex=0;

  calculate() {
    totalIncom = 0;
    totalExpenses = 0;
    totalBalance = 0;
    dataList.forEach((element) {
      if (element.type == 'cr') {
        totalIncom += element.amount;
      } else {
        totalExpenses += element.amount;
      }

      setState(() {
        totalBalance = totalIncom - totalExpenses;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    calculate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TotalBox(
                        title: 'Reduisson',
                        amount: '$totalIncom',
                        colors: Colors.blue),
                    SizedBox(
                      height: 26,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    TotalBox(
                        title: 'Point depensé',
                        amount: "$totalExpenses",
                        colors: Colors.red),
                    SizedBox(
                      height: 26,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    TotalBox(
                        title: 'Point',
                        amount: '$totalBalance',
                        colors: Colors.green),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                calculate();
                return Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) => EntryCard(
                    title: dataList[index].title,
                    amount: dataList[index].amount.toString(),
                    type: dataList[index].type),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
