import 'package:flutter/material.dart';
import 'package:my_app/categorys.dart';

import 'login.dart';
import 'product.dart';
import 'profile.dart';

class Home extends StatelessWidget {
   Home(this.user, {super.key});
   String user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Home page"),
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple,
        child: ListTileTheme(
          iconColor: Colors.white,
          textColor: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text("page list",style: TextStyle(
              fontSize: 24,
              color:  Colors.white,
            ),
            ),
            const SizedBox(
              height: 10,
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              subtitle: const Text('Go to Home screen'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context); // يقفل الـ Drawer
                // هنا تقدر تروح لصفحة ثانية
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const Home(),
                //   ),
                // );
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              subtitle: const Text('Go to Profile screen'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context); // يقفل الـ Drawer
                // هنا تقدر تروح لصفحة ثانية
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Product'),
              subtitle: const Text('Go to Product screen'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context); // يقفل الـ Drawer
                // هنا تقدر تروح لصفحة ثانية
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Product(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Category'),
              subtitle: const Text('Go to Categorys screen'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context); // يقفل الـ Drawer
                // هنا تقدر تروح لصفحة ثانية
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Categorys(),
                  ),
                );
              },
            ),
            const Spacer(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red,),
              title: const Text('Logout',style: TextStyle(
                color: Colors.red,
              ),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),

                  ),
                   (route) => false,
                );
              },
            ),
          ],
        ),
      ),
          ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. بطاقة الترحيب (Welcome Banner)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurpleAccent, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    "$user مرحبا بك يا  👋",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "استكشف أحدث المنتجات والعروض المتوفرة اليوم.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // عنوان قسم الوصول السريع
            const Text(
              "الوصول السريع",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // 2. بطاقات الاختصارات (Quick Access Cards)
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: const [
                          Icon(Icons.shopping_bag_outlined, size: 36, color: Colors.deepPurpleAccent),
                          SizedBox(height: 8),

                          Text("المنتجات", style: TextStyle(fontWeight: FontWeight.w600)),

                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: const [
                          Icon(Icons.person_outline, size: 36, color: Colors.deepPurpleAccent),
                          SizedBox(height: 8),
                          Text("الملف الشخصي", style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // عنوان قسم النشاطات
            const Text(
              "أحدث التحديثات",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // 3. قائمة التحديثات (Recent Activity)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: const [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFFEDE7F6),
                      child: Icon(Icons.local_offer_outlined, color: Colors.deepPurpleAccent),
                    ),
                    title: Text("عروض خاصة للمستخدمين الجدد"),
                    subtitle: Text("خصم 20% على أول طلب"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFFEDE7F6),
                      child: Icon(Icons.notifications_active_outlined, color: Colors.deepPurpleAccent),
                    ),
                    title: Text("تحديث أمان الحساب"),
                    subtitle: Text("تم تأمين حسابك بنجاح"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
