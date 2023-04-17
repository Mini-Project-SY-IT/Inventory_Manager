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

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> with TickerProviderStateMixin {
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

            // var box = await Hive.openBox('asif');
            //
            //
            // box.put('name', 'asif taj');
            // box.put('age', 25);
            // box.put('details', {'pro': 'developer', 'kash': 'sdsdf'});
            //
            // print(box.get('name'));
            // print(box.get('age'));
            // print(box.get('details')['pro']);
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
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
                      tabs: [
                        Text(
                          "All",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Text(
                          "Starred",
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
                      ValueListenableBuilder<Box<NotesModel>>(
                        valueListenable: Boxes.getData().listenable(),
                        builder: (context, box, _) {
                          var data = box.values.toList().cast<NotesModel>();
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 11, vertical: 5),
                            child: ListView.builder(
                                itemCount: box.length,
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
                                                  data[index]
                                                      .title
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Spacer(),
                                                InkWell(
                                                    onTap: () {
                                                      _editMyDialog(
                                                          data[index],
                                                          data[index]
                                                              .title
                                                              .toString(),
                                                          data[index]
                                                              .description
                                                              .toString());
                                                    },
                                                    child: Icon(Icons.edit)),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    deleteitem(data[index]);
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.redAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              data[index]
                                                      .description
                                                      .toString() +
                                                  " /-Rs",
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

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: "Enter Name", border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText: "Enter Amount", border: OutlineInputBorder()),
                  )
                ],
              ),
            ),
            title: Text("Add Transaction"),
            actions: [
              TextButton(
                  onPressed: () {
                    final data = NotesModel(
                        title: titleController.text,
                        description: descriptionController.text);
                    final box = Boxes.getData();
                    box.add(data);
                    // print(box.get('0'));

                    data.save();
                    titleController.clear();
                    descriptionController.clear();
                    titleController.clear();
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
          );
        });
  }

  Future<void> _editMyDialog(
      NotesModel notesModel, String title, String description) async {
    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: "Edit Name", border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText: "Enter Amount", border: OutlineInputBorder()),
                  )
                ],
              ),
            ),
            title: Text("Edit Transaction"),
            actions: [
              TextButton(
                  onPressed: () async {
                    notesModel.title = titleController.text.toString();
                    notesModel.description =
                        descriptionController.text.toString();
                    notesModel.save();
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Edit")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ],
          );
        });
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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 20,
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
                  title: Text("Demo text"),
                  subtitle: Text("Detailed text"),
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
