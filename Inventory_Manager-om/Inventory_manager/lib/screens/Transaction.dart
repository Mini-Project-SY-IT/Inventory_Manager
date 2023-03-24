import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController=TabController(length: 2, vsync: this);

    return MaterialApp(
      home: Scaffold(

        body: Column(children: [
          const SizedBox(height: 50,),
          const Text("Transaction page",style: TextStyle(fontSize: 30.0),),
          const SizedBox(height: 10,),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
            elevation: 5,
            child: TabBar(
              indicator: const BoxDecoration(
                color: Colors.blue,

              ),
              controller: tabController,
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 70),
              tabs: const [
                Tab(child: Text('incoming',style: TextStyle(color: Colors.black),),),
                Tab(child: Text('outgoing',style: TextStyle(color: Colors.black),),),
              ],
            ),
          ),
          Expanded(child:TabBarView(
            controller: tabController,
            children: [
              ListView.builder(itemBuilder:(context,index){
                return Card(
                  elevation: 2.0,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),

                  child: InkWell(onLongPress: (){},
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.upgrade_sharp,color: Colors.green,)),
                      title: const Text('chinmay'),
                      subtitle:const Text('23/2/2003'),
                      //Text((DateFormat('yMMMd').format(DateTime.now())),),
                      // ignore: prefer_interpolation_to_compose_strings
                      trailing: Wrap(
                        spacing: 15,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('1100'),
                            ),
                            IconButton(icon: const Icon(Icons.edit),onPressed: (){
                              showDialog(context: context, builder: (context){
                                return const AlertDialog(
                                  title: Text('name'),
                                  content: Text('amount'),
                                  actions: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('delete'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('edit'),

                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('done'),
                                    )
                                  ],
                                );
                              });
                            },)
                          ],
                      )
                      )

                    ),
                  );

              },itemCount: 5,),
              ListView.builder(itemBuilder:(context,index){
                return Card(
                  elevation: 2.0,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),

                  child: InkWell(onLongPress: (){},
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.upgrade_sharp,color: Colors.green,)),
                      title: const Text('chinmay'),
                      subtitle:const Text('23/2/2003'),
                      //Text((DateFormat('yMMMd').format(DateTime.now())),),
                      // ignore: prefer_interpolation_to_compose_strings
                      trailing: Wrap(
                        spacing: 15,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('1100'),
                          ),
                          IconButton(icon: const Icon(Icons.edit),onPressed: (){
                            showDialog(context: context, builder: (context){
                              return const AlertDialog(
                                title: Text('name'),
                                content: Text('amount'),
                                actions: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('delete'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('edit'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('done'),
                                  )
                                ],
                              );
                            });
                          },)
                        ],
                      )
                    ),
                  ),
                );

              },itemCount: 5,),
            ],
          ))
        ],
        ),
        floatingActionButton: IconButton(icon: const CircleAvatar(radius: 50.0,child: Icon(Icons.add),),iconSize: 50,onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: const Text('NEW ITEM',style: TextStyle(fontWeight: FontWeight.bold),),
                actions: [
                  const TextField(decoration: InputDecoration(hintText: 'Name',),),
                  const TextField(decoration: InputDecoration(hintText: 'Due Date'),),
                  const TextField(decoration: InputDecoration(hintText: 'Amount'),),
                  const TextField(decoration: InputDecoration(hintText: 'Description'),maxLines: 2,),
                  TextButton(onPressed: (){}, child: const Text('ADD'))
                ],
              );
            });
        },),
      ),
    );
  }
}
