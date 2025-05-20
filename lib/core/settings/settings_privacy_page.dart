import 'package:flutter/material.dart';

class SettingsPrivacyPage extends StatelessWidget {
  const SettingsPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings and Privacy'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 12),

          // Account Section
          const _SectionTitle('ACCOUNT'),
          _SettingsTile(
            icon: Icons.person,
            title: 'Manage account',
            onTap: () {},
          ),
          _SettingsTile(icon: Icons.security, title: 'Security', onTap: () {}),

          const Divider(),

          // Privacy Section
          const _SectionTitle('PRIVACY'),
          _SettingsTile(
            icon: Icons.lock,
            title: 'Privacy settings',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.block,
            title: 'Blocked accounts',
            onTap: () {},
          ),

          const Divider(),

          // Content and Activity Section
          const _SectionTitle('CONTENT & ACTIVITY'),
          _SettingsTile(
            icon: Icons.notifications,
            title: 'Push notifications',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.video_library,
            title: 'Watch history',
            onTap: () {},
          ),

          const Divider(),

          // Support Section
          const _SectionTitle('SUPPORT'),
          _SettingsTile(
            icon: Icons.help_outline,
            title: 'Help Center',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.report_problem,
            title: 'Report a problem',
            onTap: () {},
          ),

          const Divider(),

          // About Section
          const _SectionTitle('ABOUT'),
          _SettingsTile(icon: Icons.info_outline, title: 'About', onTap: () {}),
          _SettingsTile(
            icon: Icons.policy,
            title: 'Terms & Policies',
            onTap: () {},
          ),

          const SizedBox(height: 20),

          // Logout
          Center(
            child: TextButton(
              onPressed: () {
                // Implement logout logic
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
