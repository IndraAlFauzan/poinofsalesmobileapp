import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/bloc/category/category_bloc.dart';
import 'package:posmobile/bloc/flavor/flavor_bloc.dart';
import 'package:posmobile/bloc/payment_method/payment_method_bloc.dart';
import 'package:posmobile/bloc/pending_transaction/pending_transaction_bloc.dart';
import 'package:posmobile/bloc/payment_settlement/payment_settlement_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';
import 'package:posmobile/bloc/spicylevel/spicy_level_bloc.dart';
import 'package:posmobile/bloc/table/table_bloc.dart';
import 'package:posmobile/data/repository/payment_method_repository.dart';
import 'package:posmobile/data/repository/payment_repository.dart';
import 'package:posmobile/data/repository/spicy_level_repository.dart';
import 'package:posmobile/data/repository/table_repository.dart';
import 'package:posmobile/data/repository/transaction_repository.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/bloc/add_transaction_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/bloc/history_transaction_bloc.dart';
import 'package:posmobile/shared/config/app_themes.dart';
import 'package:posmobile/data/repository/auth_repository.dart';
import 'package:posmobile/data/repository/category_repository.dart';
import 'package:posmobile/data/repository/flavor_repository.dart';
import 'package:posmobile/data/repository/product_repository.dart';
import 'package:posmobile/dependecies_injection/dependencies_injection.dart';
import 'package:posmobile/presentations/dashboard/main_page.dart';
import 'package:posmobile/presentations/login/bloc/login_bloc.dart';
import 'package:posmobile/presentations/login/ui/login_screen.dart';

void main() {
  dependenciesInjection();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(locator<AuthRepository>())),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(
          create: (context) => CategoryBloc(locator<CategoryRepository>()),
        ),
        BlocProvider(
          create: (context) => FlavorBloc(locator<FlavorRepository>()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(locator<ProductRepository>()),
        ),
        BlocProvider(
          create: (context) => SpicyLevelBloc(locator<SpicyLevelRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              HistoryTransactionBloc(locator<TransactionRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              AddTransactionBloc(locator<TransactionRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              PaymentMethodBloc(locator<PaymentMethodRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              PendingTransactionBloc(locator<TransactionRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              PaymentSettlementBloc(locator<PaymentRepository>()),
        ),
        BlocProvider(
          create: (context) => TableBloc(locator<TableRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'POS',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        darkTheme: AppThemes.light,
        themeMode: ThemeMode.system,

        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/main': (context) => MainPage(),
        },
      ),
    );
  }
}
