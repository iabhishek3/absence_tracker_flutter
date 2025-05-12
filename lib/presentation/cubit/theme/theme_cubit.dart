import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false); // false = light mode, true = dark mode

  void toggleTheme() {
    emit(!state);
  }
} 