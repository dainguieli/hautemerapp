import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hautemerapp/models/data.dart';
import 'package:hautemerapp/models/transaction.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  String type = 'dr'; // cr incom ,dr - expense
  //final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController amountCont = TextEditingController();
  TextEditingController titleCont = TextEditingController();


  showToastMsg(String msg,{Color c = Colors.red}){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add income/Expenses'),
      ),
      body: Column(

        children: [
          Padding(
            padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Entre Amount",
              ),
              keyboardType: TextInputType.number,
              controller: amountCont,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Entre Title",
              ),
              keyboardType: TextInputType.text,
              controller:titleCont ,
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Type'),
              SizedBox(
                width: 14,
              ),
              GestureDetector(
                  onTap: () {
                    type = 'cr';
                    setState(
                      () {},
                    );
                  },
                  child: Chip(
                      backgroundColor:
                          type == "cr" ? Colors.orange : Colors.grey[100],
                      label: Text('Income'))),
              SizedBox(
                width: 14,
              ),
              GestureDetector(
                  onTap: () {
                    type = 'dr';
                    setState(() {});
                  },
                  child: Chip(
                      backgroundColor:
                          type == "dr" ? Colors.orange : Colors.grey[100],
                      label: Text('Expense'))),
            ],
          ),
          SizedBox(
            width: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (amountCont.text.isEmpty) {
                   showToastMsg('Entre valid Amount');
                   return;
                  }else if(titleCont.text.isEmpty) {
                    showToastMsg('Entre valid titre');
                    return;
                  }
                  dataList.add(Transation(titleCont.text.trim(), double.parse(amountCont.text.trim()),type ));
               showToastMsg('saved!',c: Colors.green);
                },
                child: Container(
                    width: 100,
                    child: Center(
                      child: Text('Commander'),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
