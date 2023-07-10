// import 'package:flutter/material.dart';
// import 'package:mobile_warehouse_thaiduong/constant.dart';
// import 'package:mobile_warehouse_thaiduong/function.dart';
// import 'package:mobile_warehouse_thaiduong/presentation/dialog/dialog_two_button.dart';

// class DrawerUser extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);

//     return Container(
//       color: Constants.mainColor,
//       width: 240 * SizeConfig.ratioWidth,
//       child: Drawer(
//         child: Container(
//           color: Constants.secondaryColor,
//           child: Stack(
//             children: [
//               SingleChildScrollView(
//                 child: Container(
//                   color: Constants.secondaryColor,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 320 * SizeConfig.ratioHeight,
//                           ),
//                           Builder(builder: (context) {
//                             // test drawer , chuyển sang !=
//                             {
//                               return Column(
//                                 children: [
//                                   TextButton(
//                                       onPressed: () {
//                                         AlertDialogTwoBtnCustomized(
//                                                 context,
//                                                 'Bạn có chắc?',
//                                                 "Trở về trang chính",
//                                                 "Đồng ý",
//                                                 "Hủy bỏ", () {
//                                           Navigator.pushNamed(
//                                             context,
//                                             '///',
//                                           );
//                                         }, () {}, 18, 21)
//                                             .show();
//                                       },
//                                       child: IconTextButtonDrawer(
//                                         icon: Icons.home,
//                                         text: "Trang chính",
//                                       )),
//                                   TextButton(
//                                       onPressed: () {
//                                         AlertDialogTwoBtnCustomized(
//                                                 context,
//                                                 'Bạn có chắc?',
//                                                 "Chuyển sang trang xuất kho",
//                                                 "Đồng ý",
//                                                 "Hủy bỏ", () async {
//                                           Navigator.pushNamed(
//                                               context, '/issue_screen');
//                                         }, () {}, 18, 21)
//                                             .show();
//                                       },
//                                       child: IconTextButtonDrawer(
//                                           icon: Icons.shopping_cart,
//                                           text: "Xuất kho")),
//                                   TextButton(
//                                       onPressed: () {
//                                         AlertDialogTwoBtnCustomized(
//                                                 context,
//                                                 'Bạn có chắc?',
//                                                 "Chuyển sang trang nhập kho",
//                                                 "Đồng ý",
//                                                 "Hủy bỏ", () async {
//                                           Navigator.pushNamed(
//                                               context, '/receipt_screen');
//                                         }, () {}, 18, 21)
//                                             .show();
//                                       },
//                                       child: IconTextButtonDrawer(
//                                           icon: Icons.shopping_cart,
//                                           text: "Nhập kho")),
//                                   TextButton(
//                                       onPressed: () {
//                                         AlertDialogTwoBtnCustomized(
//                                                 context,
//                                                 'Bạn có chắc?',
//                                                 "Chuyển sang trang thẻ kho",
//                                                 "Đồng ý",
//                                                 "Hủy bỏ", () {
//                                           Navigator.pushNamed(
//                                               context, '/stockcard_screen');
//                                         }, () {}, 18, 21)
//                                             .show();
//                                       },
//                                       child: IconTextButtonDrawer(
//                                         icon: Icons.article,
//                                         text: "Thẻ kho",
//                                       )),
//                                   TextButton(
//                                       onPressed: () {
//                                         AlertDialogTwoBtnCustomized(
//                                                 context,
//                                                 'Bạn có chắc?',
//                                                 "Đăng xuất khỏi hệ thống",
//                                                 "Đăng xuất",
//                                                 "Trở lại", () {
//                                           // logout(context);
//                                         }, () {}, 18, 21)
//                                             .show();
//                                       },
//                                       child: IconTextButtonDrawer(
//                                         icon: Icons.logout,
//                                         text: 'Logout',
//                                       )),
//                                 ],
//                               );
//                             }
//                           })
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: const BoxDecoration(
//                     borderRadius:
//                         BorderRadius.vertical(bottom: Radius.circular(30)),
//                     color: Constants.mainColor),
//                 height: 300 * SizeConfig.ratioHeight,
//                 width: double.infinity,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 60 * SizeConfig.ratioHeight,
//                     ),
//                     Icon(
//                       Icons.account_circle,
//                       size: 100 * SizeConfig.ratioWidth,
//                       color: Colors.white,
//                     ),
//                     SizedBox(
//                       height: 40 * SizeConfig.ratioHeight,
//                     ),
//                     Text(
//                       "Employee id:",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           height: 1.5 * SizeConfig.ratioHeight,
//                           fontSize: 20 * SizeConfig.ratioFont,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     Text(
//                       //  stringCut(employeeIdOverall, 16, suffix: "..."),
//                       '',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           height: 1.5 * SizeConfig.ratioHeight,
//                           fontSize: 20 * SizeConfig.ratioFont,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class IconTextButtonDrawer extends StatefulWidget {
//   IconData icon;
//   String text;
//   IconTextButtonDrawer({super.key, this.icon = Icons.logout, this.text = "Đăng xuất"});

//   @override
//   State<IconTextButtonDrawer> createState() => _IconTextButtonDrawerState();
// }

// class _IconTextButtonDrawerState extends State<IconTextButtonDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);

//     return SizedBox(
//       width: 160 * SizeConfig.ratioWidth,
//       height: 55 * SizeConfig.ratioHeight,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             widget.icon,
//             size: 30 * SizeConfig.ratioRadius,
//             color: Colors.white,
//           ),
//           SizedBox(width: 20 * SizeConfig.ratioWidth),
//           FittedBox(
//             fit: BoxFit.contain,
//             child: SizedBox(
//               width: 110 * SizeConfig.ratioWidth,
//               child: Text(
//                 widget.text,
//                 style: TextStyle(
//                     color: Colors.white, fontSize: 20 * SizeConfig.ratioFont),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
