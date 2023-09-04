// import 'package:flutter/cupertino.dart';

// import '../resource/model/service_model.dart';
// import 'booking/booking_screen.dart';

// import 'home_detail/home_detail_screen.dart';
// import 'notification/notification_screen.dart';
// import 'service_details/service_details.dart';
// import 'service_edit/service_edit.dart';
// import 'service_list/service_list.dart';

// class AppRouter {
//   static Future<void> goToNotification(BuildContext context) => Navigator.push(
//         context,
//         CupertinoPageRoute(
//           builder: (context) => const NotificationScreen(),
//         ),
//       );

//   static Future<void> goToBooking(
//     BuildContext context,
//     int idService,
//   ) =>
//       Navigator.push(
//         context,
//         CupertinoPageRoute(
//           builder: (context) => const BookingScreen(),
//           settings: RouteSettings(arguments: idService),
//         ),
//       );

//   static Future<void> goToMyServiceList(BuildContext context) => Navigator.push(
//         context,
//         CupertinoPageRoute(
//           builder: (context) => const ServiceListScreen(),
//         ),
//       );

//   static Future<void> goToHomeDetails(
//     BuildContext context,
//     int idService,
//   ) =>
//       Navigator.push(
//         context,
//         CupertinoPageRoute(
//           builder: (context) => const HomeDetailScreen(),
//           settings: RouteSettings(arguments: idService),
//         ),
//       );

//   static Future<void> goToMyServiceDetails(
//     BuildContext context,
//     int idMyService,
//   ) =>
//       Navigator.push(
//         context,
//         CupertinoPageRoute(
//           builder: (context) => const ServiceDetailsScreen(),
//           settings: RouteSettings(arguments: idMyService),
//         ),
//       );

//   static Future<void> goToMyServiceEdit(
//     BuildContext context,
//     Service myService,
//   ) =>
//       Navigator.push(
//         context,
//         CupertinoPageRoute(
//           builder: (context) => const ServiceEditScreen(),
//           settings: RouteSettings(arguments: myService),
//         ),
//       );
// }
