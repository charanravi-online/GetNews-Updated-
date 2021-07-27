// import 'package:flutter/material.dart';
// import 'package:getnews/pages/category.dart';
// import 'homepage.dart';

// class NavigationDrawerWidget extends StatefulWidget {
//   const NavigationDrawerWidget({Key? key}) : super(key: key);

//   @override
//   _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
// }

// class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
  
//   child: ListView(
   
//     padding: EdgeInsets.zero,
//     children: [
//       const DrawerHeader(
//         decoration: BoxDecoration(
//           color: Colors.blue,
//         ),
//         child: Text('Drawer Header'),
//       ),
//       ListTile(
//         title: const Text('The Times of India'),
//         onTap: () {
//           Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => Category(
//                                     query: drawerItem[index],
//                                   )));
          
//         },
//       ),
//       ListTile(
//         title: const Text('BBC News'),
//         onTap: () {
         
//         },
//       ),
//        ListTile(
//         title: const Text('National Geographic'),
//         onTap: () {
         
//         },
//       ),
//        ListTile(
//         title: const Text('News 24'),
//         onTap: () {
         
//         },
//       ),
//        ListTile(
//         title: const Text('Tech Radar'),
//         onTap: () {
         
//         },
//       ),
//        ListTile(
//         title: const Text('Mashable'),
//         onTap: () {
         
//         },
//       ),
//        ListTile(
//         title: const Text('BuzzFeed'),
//         onTap: () {
         
//         },
//       ),
//        ListTile(
//         title: const Text('ESPN'),
//         onTap: () {
         
//         },
//       ),
//     ],
//   ),
// );
//   }
// }
