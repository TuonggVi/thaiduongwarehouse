import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/injector.dart';
import 'package:mobile_warehouse_thaiduong/presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: AppRoute.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      title: "Storage Management",
    );
  }
}

// class User {
//   const User(this.name, this.id);
//   final String name;
//   final String id;
// }

// class MyApp extends StatefulWidget {
//   State createState() => new MyAppState();
// }

// class MyAppState extends State<MyApp> {
//   User? selectedUser;
//   ItemModel? selectedItem;
//   List<ItemModel> items = <ItemModel>[
//     ItemModel('1', 'Một', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
//     ItemModel('2', 'Hai', UnitModel('kg'), ItemClassModel('TP'), 100, 10)
//   ];
//   List<User> users = <User>[User('Foo', '1'), User('Bar', '2')];
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             children: [
//               DropdownButton<ItemModel>(
//                 hint: Text("Select a user"),
//                 value: selectedItem,
//                 onChanged: (ItemModel? newValue) {
//                   setState(() {
//                     selectedItem = newValue;
//                     print(items.indexOf(selectedItem as ItemModel));
//                   });
//                 },
//                 items: items.map((ItemModel item) {
//                   return DropdownMenuItem<ItemModel>(
//                     value: item,
//                     child: Text(
//                       item.itemId,
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   );
//                 }).toList(),
//               ),
//                DropdownButton<ItemModel>(
//                 hint: Text("Select a user"),
//                 value: selectedItem,
//                 onChanged: (ItemModel? newValue) {
//                   setState(() {
//                     selectedItem = newValue;
//                     print(items.indexOf(selectedItem as ItemModel));
//                   });
//                 },
//                 items: items.map((ItemModel item) {
//                   return DropdownMenuItem<ItemModel>(
//                     value: item,
//                     child: Text(
//                       item.itemName,
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   );
//                 }).toList(),
//               ),
//                 DropdownButton<ItemModel>(
//                 hint: Text("Select a user"),
//                 value: selectedItem,
//                 onChanged: (ItemModel? newValue) {
                  
//                   setState(() {
//                     selectedItem = newValue;
//                     print(items.indexOf(selectedItem as ItemModel));
//                   });
//                 },
//                 items: items.map((ItemModel item) {
//                   return DropdownMenuItem<ItemModel>(
//                     value: item,
//                     child: Text(
//                       item.unit.toString(),
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               // DropdownButton<User>(
//               //   hint: Text("Select a user"),
//               //   value: selectedUser,
//               //   onChanged: (User? newValue) {
//               //     setState(() {
//               //       selectedUser = newValue;
//               //       print(users.indexOf(selectedUser as User));
//               //     });
//               //   },
//               //   items: users.map((User user) {
//               //     return DropdownMenuItem<User>(
//               //       value: user,
//               //       child: Text(
//               //         user.id,
//               //         style: TextStyle(color: Colors.black),
//               //       ),
//               //     );
//               //   }).toList(),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // khi muốn thay đổi unit thì ko set selected
