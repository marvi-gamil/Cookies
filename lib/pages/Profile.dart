import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'onboard.dart';
import '../providers/auth_provider.dart';
import '../service/widget_support.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget profileInfoTile(
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: const Color(0xFF1C4BA0)),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C4BA0),
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final username = auth.userData!['username'] ?? 'User Name';
    final email = auth.userData!['email'] ?? 'example@mail.com';
    final phone = auth.userData!['phone'] ?? '0123456789';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/HomeBackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Profile 👤", style: AppWidget.LogoTextStyle()),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Color(0xFF1C4BA0),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Settings Clicked")),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Avatar & Name
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          "assets/images/user_avatar.jpg",
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C4BA0),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        phone,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1C4BA0),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Edit Profile Clicked"),
                            ),
                          );
                        },
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Profile Info Cards
                profileInfoTile(
                  Icons.location_on,
                  "Address",
                  "Port Said, Egypt",
                  onTap: () {},
                ),
                profileInfoTile(
                  Icons.credit_card,
                  "Payment Methods",
                  "Visa • MasterCard",
                  onTap: () {},
                ),
                profileInfoTile(
                  Icons.history,
                  "Order History",
                  "View your past orders",
                  onTap: () {},
                ),
                profileInfoTile(
                  Icons.lock,
                  "Change Password",
                  "Update your password",
                  onTap: () {},
                ),

                const SizedBox(height: 20),

                // Logout Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    auth.logout();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Logged out successfully")),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const OneBoard()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
