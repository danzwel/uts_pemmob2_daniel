import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("name") ?? "Mahasiswa";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),

      appBar: AppBar(
        title: Text("Student Helper App"),
        backgroundColor: Colors.blueAccent,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          // -------------------------------------------------
          // Banner Welcome
          // -------------------------------------------------
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat Datang, $userName!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Semoga harimu menyenangkan 👋",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // -------------------------------------------------
          // Jadwal Kuliah Hari Ini
          // -------------------------------------------------
          _buildSectionTitle("Jadwal Kuliah Hari Ini"),
          _buildInfoBox(
            icon: Icons.calendar_month,
            title: "Pemrograman Mobile 2",
            subtitle: "10:00 - 12:00 WIB • Ruang Lab 305",
          ),

          SizedBox(height: 20),

          // -------------------------------------------------
          // Motivasi Mahasiswa
          // -------------------------------------------------
          _buildSectionTitle("Motivasi Hari Ini"),
          _buildQuoteCard(
            "“Tidak perlu hebat untuk memulai, tapi kamu harus mulai untuk menjadi hebat.”",
          ),

          SizedBox(height: 20),

          // -------------------------------------------------
          // To-Do List mini
          // -------------------------------------------------
          _buildSectionTitle("To-Do List Mahasiswa"),
          _buildTodoCard(),
          
          SizedBox(height: 25),

          // -------------------------------------------------
          // MAIN MENU (Grid)
          // -------------------------------------------------
          _buildSectionTitle("Menu Utama"),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              _buildMenuCard(
                icon: Icons.map,
                title: "Map Kampus",
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.map),
              ),
              _buildMenuCard(
                icon: Icons.info,
                title: "Info Mahasiswa",
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.info),
              ),
              _buildMenuCard(
                icon: Icons.person,
                title: "Tentang Aplikasi",
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.about),
              ),
              _buildMenuCard(
                icon: Icons.book,
                title: "Dokumen Belajar",
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================================================
  // COMPONENTS
  // =========================================================

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoBox({required IconData icon, required String title, required String subtitle}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent, size: 35),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _buildQuoteCard(String text) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildTodoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTodoItem("Kerjakan laporan UTS"),
            _buildTodoItem("Presentasi minggu depan"),
            _buildTodoItem("Review materi Pemrograman Mobile 2"),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoItem(String text) {
    return Row(
      children: [
        Icon(Icons.check_circle_outline, color: Colors.blueAccent),
        SizedBox(width: 10),
        Text(text),
      ],
    );
  }

  Widget _buildMenuCard({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.blueAccent),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  // DRAWER
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.school, color: Colors.white, size: 60),
                SizedBox(height: 10),
                Text(
                  "Student Helper App",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text("Hi, $userName", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            selected: true,
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text("Map Kampus"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.map),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("Info Mahasiswa"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.info),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Tentang Aplikasi"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.about),
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
