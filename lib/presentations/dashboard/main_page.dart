import 'package:flutter/material.dart';
import 'package:posmobile/presentations/dashboard/product/productmainpage/product_main_page.dart';
import 'package:posmobile/presentations/dashboard/transaction/transactioncart/transaction_cart_page.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/history_transaction_screen.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/custom_alert_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            // Lakukan logout dan navigasi
            Navigator.of(context).pushReplacementNamed('/login');
          },
          onCancel: () {},
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
              child: PageView(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Menonaktifkan swipe
                children: const [
                  TransactionCartPage(),
                  // Center(
                  //   child: Text(
                  //     'Home Page',
                  //     style: TextStyle(
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  ProductMainPage(),
                  // Center(
                  //   child: Text(
                  //     'Riwayat Transaksi',
                  //     style: TextStyle(
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  HistoryTransactionScreen(),
                  // Center(
                  //   child: Text(
                  //     'Menu Page',
                  //     style: TextStyle(
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),

                  // HomePage(),
                  // MenuPage(),
                  // DetailTransactionPage(),
                ],
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
            label: 'Pesanan',
            icon: Icons.restaurant_menu,
            page: MainPageTab.home,
          ),
          _buildMenuItem(
            label: 'Produk',
            icon: Icons.fastfood_rounded,
            page: MainPageTab.menu,
          ),
          _buildMenuItem(
            label: 'Riwayat Pesanan',
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
      padding: const EdgeInsets.only(
        top: 10,
      ), // Kembali ke 10 seperti permintaan
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/food_logo.svg',
            clipBehavior: Clip.hardEdge,
          ),
          const SizedBox(height: 8),
          const Divider(
            height: 2,
            color: AppColors.textSecondary,
            // indent: 20,
            // endIndent: 20,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(height: 5),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
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
            CircleAvatar(
              backgroundColor: Colors.white54,
              child: Icon(
                Icons.logout_outlined,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            SizedBox(height: 5),
            Text("Keluar", style: TextStyle(color: Colors.white, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
