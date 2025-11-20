import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_routes.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
        title: Text("Tentang Aplikasi"),
        backgroundColor: Colors.blueAccent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.school, color: Colors.blueAccent, size: 80),

                    SizedBox(height: 15),

                    Text(
                      "Student Helper App",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Versi 1.0.0",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      "Aplikasi Student Helper App dibuat untuk membantu mahasiswa dalam mendapatkan "
                      "informasi kampus, navigasi lokasi kampus, serta berbagai informasi akademik lainnya. "
                      "Aplikasi ini dirancang dengan tampilan sederhana, modern, dan mudah digunakan.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: 25),

                    Divider(),

                    SizedBox(height: 10),

                    Text(
                      "Developer:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "Daniel Desmanto Nugraha\nNPM: ********55",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
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
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.info),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Tentang Aplikasi"),
            selected: true,
            onTap: () => Navigator.pop(context),
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
