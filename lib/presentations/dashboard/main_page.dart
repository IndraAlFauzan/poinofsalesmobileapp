import 'package:flutter/material.dart';
import 'package:posmobile/presentations/widgets/custom_alert_dialog.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainPageTab _pageActive = MainPageTab.home;
  final _pageController = PageController();

  void _onPageSelected(MainPageTab page) {
    if (_pageActive != page) {
      setState(() {
        _pageActive = page;
      });
      _pageController.jumpToPage(page.index);
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: 'Logout',
          content: 'Apakah Anda yakin ingin keluar?',
          cancelText: 'Tidak',
          confirmText: 'Ya',
          onConfirm: () {
            Navigator.of(context).pop();
            // Lakukan logout dan navigasi
            Navigator.of(context).pushReplacementNamed('/login');
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Sidebar
            SideMenu(
              pageActive: _pageActive,
              onPageSelected: _onPageSelected,
              onLogout: _showLogoutDialog,
            ),
            // Content Area
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                child: PageView(
                  controller: _pageController,
                  physics:
                      const NeverScrollableScrollPhysics(), // Menonaktifkan swipe
                  children: const [
                    // HomePage(),
                    // MenuPage(),
                    // DetailTransactionPage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}

// Enum untuk mengelola tab
enum MainPageTab { home, menu, history }

// --- File: widgets/side_menu.dart ---

class SideMenu extends StatefulWidget {
  final MainPageTab pageActive;
  final Function(MainPageTab) onPageSelected;
  final VoidCallback onLogout;

  const SideMenu({
    super.key,
    required this.pageActive,
    required this.onPageSelected,
    required this.onLogout,
  });

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  MainPageTab? _hoveredItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildLogo(),
          const SizedBox(height: 30),
          _buildMenuItem(
            label: 'Home',
            icon: Icons.home_rounded,
            page: MainPageTab.home,
          ),
          _buildMenuItem(
            label: 'Menu',
            icon: Icons.fastfood_rounded,
            page: MainPageTab.menu,
          ),
          _buildMenuItem(
            label: 'Riwayat',
            icon: Icons.history_rounded,
            page: MainPageTab.history,
          ),
          const Spacer(),
          const Divider(
            height: 1,
            color: Colors.white24,
            indent: 20,
            endIndent: 20,
          ),
          _buildLogoutButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Icon(
            Icons.restaurant,
            color: Colors.white,
            size: 40,
            shadows: const [Shadow(blurRadius: 4, color: Colors.black26)],
          ),
          const SizedBox(height: 8),
          Text(
            'Kedai Seblak',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String label,
    required IconData icon,
    required MainPageTab page,
  }) {
    final bool isActive = widget.pageActive == page;
    final bool isHover = _hoveredItem == page;
    final bgColor = isActive
        ? Colors.white24
        : isHover
        ? Colors.white12
        : Colors.transparent;
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredItem = page),
      onExit: (_) => setState(() => _hoveredItem = null),
      child: GestureDetector(
        onTap: () => widget.onPageSelected(page),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(height: 5),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: widget.onLogout,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: const [
            Icon(Icons.logout_rounded, color: Colors.white, size: 24),
            SizedBox(height: 5),
            Text("Logout", style: TextStyle(color: Colors.white, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
