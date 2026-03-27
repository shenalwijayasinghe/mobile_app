import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 46,
                          backgroundColor: Colors.green.shade100,
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "John Doe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "johndoe@email.com",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat("12", "Orders"),
                      _buildDivider(),
                      _buildStat("3", "Favorites"),
                      _buildDivider(),
                      _buildStat("2", "Addresses"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Account Section
            _buildSectionTitle("Account"),
            _buildMenuCard([
              _buildMenuItem(Icons.person_outline, "Personal Info", onTap: () {}),
              _buildDividerLine(),
              _buildMenuItem(Icons.location_on_outlined, "Delivery Addresses", onTap: () {}),
              _buildDividerLine(),
              _buildMenuItem(Icons.credit_card_outlined, "Payment Methods", onTap: () {}),
            ]),

            const SizedBox(height: 16),

            // Preferences Section
            _buildSectionTitle("Preferences"),
            _buildMenuCard([
              _buildMenuItem(Icons.notifications_outlined, "Notifications", onTap: () {}),
              _buildDividerLine(),
              _buildMenuItem(Icons.language_outlined, "Language", trailing: "English", onTap: () {}),
              _buildDividerLine(),
              _buildMenuItem(Icons.dark_mode_outlined, "Dark Mode", isToggle: true),
            ]),

            const SizedBox(height: 16),

            // Support Section
            _buildSectionTitle("Support"),
            _buildMenuCard([
              _buildMenuItem(Icons.help_outline, "Help Center", onTap: () {}),
              _buildDividerLine(),
              _buildMenuItem(Icons.star_outline, "Rate the App", onTap: () {}),
              _buildDividerLine(),
              _buildMenuItem(Icons.privacy_tip_outlined, "Privacy Policy", onTap: () {}),
            ]),

            const SizedBox(height: 20),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade50,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 30, width: 1, color: Colors.white38);
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    String? trailing,
    bool isToggle = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: isToggle ? null : onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.green, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: isToggle
          ? Switch(
              value: false,
              onChanged: (val) {},
              activeColor: Colors.green,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trailing != null)
                  Text(
                    trailing,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                    ),
                  ),
                const SizedBox(width: 4),
                Icon(Icons.chevron_right, color: Colors.grey.shade400),
              ],
            ),
    );
  }

  Widget _buildDividerLine() {
    return Divider(
      height: 1,
      indent: 60,
      endIndent: 16,
      color: Colors.grey.shade100,
    );
  }
}