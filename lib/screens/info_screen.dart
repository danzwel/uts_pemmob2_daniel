import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_routes.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
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
        title: Text("Info Mahasiswa"),
        backgroundColor: Colors.blueAccent,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInfoCard(
            title: "Pengumuman Kampus",
            content:
                "Perkuliahan tatap muka minggu depan dialihkan menjadi daring karena kegiatan kampus.",
            icon: Icons.campaign,
          ),

          _buildInfoCard(
            title: "Jadwal Akademik",
            content:
                "UTS dimulai tanggal 20–25 Desember. Pastikan mengisi KRS sebelum tanggal 10!",
            icon: Icons.calendar_month,
          ),

          _buildInfoCard(
            title: "Tips Belajar",
            content:
                "Gunakan teknik Pomodoro: belajar 25 menit, istirahat 5 menit. Ulangi 4 kali.",
            icon: Icons.lightbulb,
          ),

          _buildInfoCard(
            title: "Layanan Kampus",
            content:
                "Administrasi kampus buka setiap hari Senin–Jumat pukul 08.00–15.00.",
            icon: Icons.support_agent,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent, size: 28),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

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
                Text(
                  "Hi, $userName",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.home),
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
            selected: true,
            onTap: () => Navigator.pop(context),
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
