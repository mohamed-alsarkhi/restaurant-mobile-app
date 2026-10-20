import 'package:flutter/material.dart';
import 'package:my_app/data/categoryService.dart';

class Categorys extends StatefulWidget {
  const Categorys({super.key});

  @override
  State<Categorys> createState() => _CategorysState();
}

class _CategorysState extends State<Categorys> {
  final Categoryservice categoryservice = Categoryservice();
  late Future<List<dynamic>> categorys;

  @override
  void initState() {
    super.initState();
    categorys = categoryservice.getCategorys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Categorys page"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: categorys,
        builder: (context, snapshot) {
          // 1. حالة الانتظار (تحميل)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // 2. حالة حدوث خطأ
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          // 3. استخراج البيانات والتحقق من القائمة الفارغة
          final categoriesList = snapshot.data ?? [];

          if (categoriesList.isEmpty) {
            return const Center(
              child: Text('No Categories Found'),
            );
          }

          // 4. بناء القائمة باستخدام ListView.builder
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: categoriesList.length,
            itemBuilder: (context, index) {
              final category = categoriesList[index];

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  // أيقونة خلفية دائرية ملونة بدلاً من الصورة
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.deepPurpleAccent.withOpacity(0.12),
                    child: const Icon(
                      Icons.restaurant_menu,
                      color: Colors.deepPurpleAccent,
                      size: 26,
                    ),
                  ),
                  // اسم التصنيف
                  title: Text(
                    category['name']?.toString() ?? '',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // سهم التنقل
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    // التنقل أو تصفية المنتجات حسب التصنيف
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}