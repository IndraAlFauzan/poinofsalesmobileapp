import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/dashboard/payment/payment_history_page.dart';
import 'package:posmobile/presentations/dashboard/product/productmainpage/product_main_page.dart';
import 'package:posmobile/presentations/dashboard/transaction/transactioncart/transaction_cart_page.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/history_transaction_screen.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/payment_page.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';
import 'package:posmobile/shared/widgets/adaptive_widgets.dart';
import 'package:posmobile/shared/cubit/theme_cubit.dart';
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
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 8,
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: context.colorScheme.surface,
              border: Border.all(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header dengan gradient
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(context.spacing.lg),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    gradient: context.customColors.gradientPrimary,
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.logout_rounded, size: 32, color: Colors.white),
                      SizedBox(height: context.spacing.sm),
                      Text(
                        'Konfirmasi Logout',
                        style: context.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Padding(
                  padding: EdgeInsets.all(context.spacing.lg),
                  child: Column(
                    children: [
                      Text(
                        'Apakah Anda yakin ingin keluar dari aplikasi?',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: context.spacing.lg),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Batal'),
                            ),
                          ),
                          SizedBox(width: context.spacing.sm),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/login',
                                  (route) => false,
                                );
                              },
                              child: const Text('Keluar'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                  ProductMainPage(),
                  PaymentPage(),
                  PaymentHistoryPage(),
                  HistoryTransactionScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: context.colorScheme.surface,
    );
  }
}

// Enum untuk mengelola tab
enum MainPageTab { home, menu, payment, historyTransaction, hitoryPayment }

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
        gradient: context.customColors.gradientPrimary,
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildLogo(), // Logo tetap di atas, tidak bisa di-scroll

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: context.spacing.xl),
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
                    label: 'Pembayaran',
                    icon: Icons.payment_rounded,
                    page: MainPageTab.payment,
                  ),
                  _buildMenuItem(
                    label: 'Riwayat Pembayaran',
                    icon: Icons.payment_rounded,
                    page: MainPageTab.hitoryPayment,
                  ),
                  _buildMenuItem(
                    label: 'Riwayat Transaksi',
                    icon: Icons.history_rounded,
                    page: MainPageTab.historyTransaction,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  AdaptiveDivider(
                    color: Colors.white.withValues(alpha: 0.3),
                    indent: 20,
                    endIndent: 20,
                  ),
                  _buildThemeToggle(),
                  _buildLogoutButton(),
                  SizedBox(height: context.spacing.md),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(context.spacing.sm),

          child: SvgPicture.asset(
            'assets/images/food_logo.svg',
            height: 40,
            width: 40,
          ),
        ),
        SizedBox(height: context.spacing.sm),
        AdaptiveDivider(color: Colors.white.withValues(alpha: 0.3)),
      ],
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
        ? Colors.white.withValues(alpha: 0.3)
        : isHover
        ? Colors.white.withValues(alpha: 0.2)
        : Colors.transparent;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredItem = page),
      onExit: (_) => setState(() => _hoveredItem = null),
      child: GestureDetector(
        onTap: () => widget.onPageSelected(page),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(
            horizontal: context.spacing.sm,
            vertical: context.spacing.xs,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(context.radius.md),
            border: isActive
                ? Border.all(
                    color: Colors.white.withValues(alpha: 0.5),
                    width: 1,
                  )
                : null,
          ),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: context.spacing.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              SizedBox(height: context.spacing.xs),
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return GestureDetector(
          onTap: () {
            context.read<ThemeCubit>().toggleTheme();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: context.spacing.sm),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(context.radius.md),
            ),
            padding: EdgeInsets.symmetric(vertical: context.spacing.sm),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(context.spacing.sm),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    context.read<ThemeCubit>().themeIcon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(height: context.spacing.xs),
                Text(
                  "Tema",
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: widget.onLogout,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: context.spacing.sm),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(context.radius.md),
        ),
        padding: EdgeInsets.symmetric(vertical: context.spacing.sm),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(context.spacing.sm),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.logout_outlined, color: Colors.white, size: 24),
            ),
            SizedBox(height: context.spacing.xs),
            Text(
              "Keluar",
              style: context.textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
