import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../utils/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LatLng kampusLocation = LatLng(-6.8904, 107.6103); // UTB BANDUNG
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
        title: Text("Map Kampus UTB"),
        backgroundColor: Colors.blueAccent,
      ),

      body: FlutterMap(
        options: MapOptions(
          initialCenter: kampusLocation,
          initialZoom: 16,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: "com.example.utb_student_app",
          ),

          MarkerLayer(
            markers: [
              Marker(
                point: kampusLocation,
                width: 80,
                height: 80,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
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
            selected: true,
            onTap: () =>
                Navigator.pop(context), // tetap di halaman ini
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
