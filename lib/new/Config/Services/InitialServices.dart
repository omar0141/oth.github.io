import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Categories/categories_bloc.dart';

class InitialServices {
  Future getDependancies() async {
    BlocProvider.of<CategoriesBloc>(navigatorKey.currentContext!)
        .add(GetCategoriesEvent());
  }
}
