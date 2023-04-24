// import 'package:flutter/material.dart';

// class Transaction extends StatefulWidget {
//   const Transaction({Key? key}) : super(key: key);

//   @override
//   State<Transaction> createState() => _TransactionState();
// }

// class _TransactionState extends State<Transaction> with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     TabController tabController=TabController(length: 2, vsync: this);

//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.grey.shade300,

//         body: Column(children: [
//           const SizedBox(height: 50,),
//           const Text("Transaction page",style: TextStyle(fontSize: 30.0),),
//           const SizedBox(height: 10,),
//           Card(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
//             elevation: 5,
//             child: TabBar(
//               indicator: const BoxDecoration(
//                 color: Colors.blue,
//                 shape:BoxShape.rectangle,

//               ),
//               controller: tabController,
//               isScrollable: true,
//               labelPadding: const EdgeInsets.symmetric(horizontal: 70),
//               tabs: const [
//                 Tab(child: Text('incoming',style: TextStyle(color: Colors.black),),),
//                 Tab(child: Text('outgoing',style: TextStyle(color: Colors.black),),),
//               ],
//             ),
//           ),
//           Expanded(child:TabBarView(
//             controller: tabController,
//             children: [
//               ListView.builder(itemBuilder:(context,index){
//                 return Card(
//                   elevation: 2.0,
//                   shape: BeveledRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),

//                   child: InkWell(onLongPress: (){},
//                       child: ListTile(
//                           leading: const CircleAvatar(child: Icon(Icons.upgrade_sharp,color: Colors.green,)),
//                           title: const Text('chinmay'),
//                           subtitle:const Text('23/2/2003'),
//                           //Text((DateFormat('yMMMd').format(DateTime.now())),),
//                           // ignore: prefer_interpolation_to_compose_strings
//                           trailing: Wrap(
//                             spacing: 15,
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('1100'),
//                               ),
//                               IconButton(icon: const Icon(Icons.edit),onPressed: (){
//                                 showDialog(context: context, builder: (context){
//                                   return const AlertDialog(
//                                     title: Text('name'),
//                                     content: Text('amount'),
//                                     actions: [
//                                       InkWell(
//                                         child: Padding(
//                                           padding: EdgeInsets.all(8.0),
//                                           child: Text('delete'),
//                                         ),

//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.all(8.0),
//                                         child: Text('edit'),

//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.all(8.0),
//                                         child: Text('done'),
//                                       )
//                                     ],
//                                   );
//                                 });
//                               },)
//                             ],
//                           )
//                       )

//                   ),
//                 );

//               },itemCount: 5,),
//               ListView.builder(itemBuilder:(context,index){
//                 return Card(
//                   elevation: 2.0,
//                   shape: BeveledRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),

//                   child: InkWell(onLongPress: (){},
//                     child: ListTile(
//                         leading: const CircleAvatar(child: Icon(Icons.upgrade_sharp,color: Colors.green,)),
//                         title: const Text('chinmay'),
//                         subtitle:const Text('23/2/2003'),
//                         //Text((DateFormat('yMMMd').format(DateTime.now())),),
//                         // ignore: prefer_interpolation_to_compose_strings
//                         trailing: Wrap(
//                           spacing: 15,
//                           children: [
//                             const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text('1100'),
//                             ),
//                             IconButton(icon: const Icon(Icons.edit),onPressed: (){
//                               showDialog(context: context, builder: (context){
//                                 return const AlertDialog(
//                                   title: Text('name'),
//                                   content: Text('amount'),
//                                   actions: [
//                                     Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Text('delete'),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Text('edit'),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Text('done'),
//                                     )
//                                   ],
//                                 );
//                               });
//                             },)
//                           ],
//                         )
//                     ),
//                   ),
//                 );

//               },itemCount: 5,),
//             ],
//           ))
//         ],
//         ),
//         floatingActionButton: IconButton(icon: const CircleAvatar(radius: 50.0,child: Icon(Icons.add),),iconSize: 50,onPressed: (){
//           showDialog(context: context, builder: (context){
//             return AlertDialog(
//               title: const Text('NEW ITEM',style: TextStyle(fontWeight: FontWeight.bold),),
//               actions: [
//                 const TextField(decoration: InputDecoration(hintText: 'Name',),),
//                 const TextField(decoration: InputDecoration(hintText: 'Due Date'),),
//                 const TextField(decoration: InputDecoration(hintText: 'Amount'),),
//                 const TextField(decoration: InputDecoration(hintText: 'Description'),maxLines: 2,),
//                 TextButton(onPressed: (){}, child: const Text('ADD'))
//               ],
//             );
//           });
//         },),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Boxes/Boxes.dart';
import 'models/notes_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> with TickerProviderStateMixin {
  bool isloading = true;
  List<dynamic> pendingTrans = [];
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List> fetchPendingTranscation() async {
    final response = await http.get(Uri.parse(
        'https://shamhadchoudhary.pythonanywhere.com/api/store/delay-transcation?is_pending=True'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        isloading = false;
        pendingTrans = data;
      });
      print(data);
      return data;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return [];
  }

  Future<void> fetchData() async {
    List<dynamic> result = await fetchPendingTranscation();
    setState(() {
      data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _showMyDialog();
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: const [
                Color(0xfface0f9),
                Color(0xfffff1eb),
              ])),
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Transaction",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 10,
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent,
                      ),
                      controller: tabController,
                      tabs: const [
                        Text(
                          "INCOMMING",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Text(
                          "OUTGOING",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ValueListenableBuilder<List<dynamic>>(
                        valueListenable: ValueNotifier(data),
                        builder: (context, dataList, _) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 11, vertical: 5),
                            child: ListView.builder(
                                itemCount: dataList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 80,
                                    child: Card(
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  data[index]['name']
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  data[index]['amount']
                                                          .toString() +
                                                      " /Rs",
                                                  style: TextStyle(
                                                      color: Colors.blue[500],
                                                      fontSize: 12),
                                                ),
                                                Spacer(),
                                                InkWell(
                                                    onTap: () {
                                                      _editMyDialog(
                                                          data[index]);
                                                    },
                                                    child: Icon(Icons.edit)),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    pendingTranscationData(
                                                        data[index]['id']);
                                                  },
                                                  child: Icon(
                                                    Icons.done_all,
                                                    color:
                                                        Colors.redAccent[200],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              data[index]['deadline']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.red[200],
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        },
                      ),
                      notesStarred(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  var _deadline;

  Future<void> _showDatePicker(BuildContext context) async {
    await
        // void _showDatePicker() {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime.now())
            .then((value) {
      setState(() {
        _deadline = value!;
        _deadline = _deadline.toString().split(' ')[0];
      });
    });
  }

  Future<void> postTranscationData() async {
    final url = Uri.parse(
        'https://shamhadchoudhary.pythonanywhere.com/api/store/delay-transcation');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "name": nameController.text,
      "description": descriptionController.text,
      "amount": amountController.text,
      "is_pending": true,
      "deadline": _deadline,
    });

    print(body);

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // request successful
      print(response.body);
      setState(() {
        isloading = false;
      });
    } else {
      // request failed
      print(response.reasonPhrase);
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            content: Container(
              // height: 250,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "Enter Name or Leave Empty",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText: "Enter Description or Leave Empty",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    decoration: InputDecoration(
                        hintText: "Enter Amount in Rs..",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        _deadline == null
                            ? 'Deadline date'
                            : 'Selected Deadline: ${_deadline.toString()}',
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.calendar_month, size: 32),
                        color: Colors.blue,
                        onPressed: () {
                          _showDatePicker(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            title: Text("Add Transaction"),
            actions: [
              TextButton(
                  onPressed: () {
                    postTranscationData();

                    nameController.clear();
                    descriptionController.clear();
                    nameController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Add")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"))
            ],
          ),
        );
      },
    );
  }

  Future<void> _editMyDialog(data) async {
    nameController.text = data['name'];
    descriptionController.text = data['description'];
    amountController.text = data['amount'].toString();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            content: Container(
              // height: 250,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "Enter Name or Leave Empty",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText: "Enter Description or Leave Empty",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    decoration: InputDecoration(
                        hintText: "Enter Amount in Rs..",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        _deadline == null
                            ? 'Deadline date'
                            : 'Selected Deadline: ${_deadline.toString()}',
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.calendar_month, size: 32),
                        color: Colors.blue,
                        onPressed: () {
                          _showDatePicker(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            title: Text("Add Transaction"),
            actions: [
              TextButton(
                  onPressed: () {
                    updateTranscationData(data['id']);

                    nameController.clear();
                    descriptionController.clear();
                    amountController.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Add")),
              TextButton(
                  onPressed: () {
                    nameController.clear();
                    descriptionController.clear();
                    amountController.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"))
            ],
          ),
        );
      },
    );
  }

  Future<void> updateTranscationData(int id) async {
    final url = Uri.parse(
        'https://shamhadchoudhary.pythonanywhere.com/api/store/update-delay-transcation/$id');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "name": nameController.text,
      "description": descriptionController.text,
      "amount": amountController.text,
      "is_pending": true,
      "deadline": _deadline,
    });

    print(body);

    final response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // request successful
      print(response.body);
      setState(() {
        // fetchData();
      });
    } else {
      // request failed
      print(response.reasonPhrase);
    }
  }

  Future<void> pendingTranscationData(int id) async {
    final url = Uri.parse(
        'https://shamhadchoudhary.pythonanywhere.com/api/store/update-delay-transcation/$id');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "is_pending": false,
    });

    print(body);

    final response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // request successful
      print(response.body);
      setState(() {
        // fetchData();
      });
    } else {
      // request failed
      print(response.reasonPhrase);
    }
  }
}

// class notesAll extends StatefulWidget {
//   const notesAll({Key? key}) : super(key: key);
//
//   @override
//   State<notesAll> createState() => _notesAllState();
// }
//
// class _notesAllState extends State<notesAll> {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
//
//
// }

Future<void> deleteitem(NotesModel notesModel) async {
  await notesModel.delete();
}

class notesStarred extends StatefulWidget {
  const notesStarred({Key? key}) : super(key: key);

  @override
  State<notesStarred> createState() => _notesStarredState();
}

class _notesStarredState extends State<notesStarred> {
  bool isloading = true;
  List<dynamic> DoneTrans = [];

  @override
  void initState() {
    super.initState();
    fetchDoneTranscation();
  }

  Future<void> fetchDoneTranscation() async {
    final response = await http.get(Uri.parse(
        'https://shamhadchoudhary.pythonanywhere.com/api/store/delay-transcation?is_pending=False'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        isloading = false;
        DoneTrans = data;
      });
      print(data);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: DoneTrans.length,
        itemBuilder: (BuildContext, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0.8),
            child: Card(
              child: InkWell(
                onTap: () {},
                child: ListTile(
                  leading: Text(
                    "${index + 1}",
                    style: TextStyle(
                        fontSize: 20, textBaseline: TextBaseline.alphabetic),
                  ),
                  title: Text(DoneTrans[index]['name']),
                  subtitle: Text(DoneTrans[index]['description']),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

//
    // # http://127.0.0.1:8000/api/store/delay-transcation?id=3
    // # http://127.0.0.1:8000/api/store/delay-transcation?is_pending=True
    // path('update-delay-transcation/<str:pk>', TranscationUpdateView.as_view()),
    // # http://127.0.0.1:8000/api/store/update-delay-transcation/3