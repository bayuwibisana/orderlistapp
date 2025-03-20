import 'package:flutter/material.dart';
import '../utils/shared_preferences_service.dart';
import 'login_screen.dart';
import '../models/user_model.dart';




class HomeScreen extends StatelessWidget {
  final SharedPreferencesService _prefsService = SharedPreferencesService();
  final User user;

  HomeScreen({required this.user});



  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _prefsService.clearToken();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Header
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                color: Colors.blue,
              ),
              Positioned(
                bottom: 25,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    'assets/images/profile.png',
                  ), // Replace with a valid image
                ),
              ),
            ],
          ),
          SizedBox(height: 40), // Space for profile pic adjustment
          // User Info Section
          Column(
            children: [
              Text(
                '${user.name}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text("Flutter Developer", style: TextStyle(color: Colors.grey)),
            ],
          ),

          SizedBox(height: 20),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Follow")),
              OutlinedButton(onPressed: () {}, child: Text("Message")),
            ],
          ),

          SizedBox(height: 20),

          // Recent Activities Section
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                activityCard("Liked your post", Icons.thumb_up),
                activityCard("Commented: Nice Work!", Icons.comment),
                activityCard("Started following you", Icons.person_add),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget activityCard(String text, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(text),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
