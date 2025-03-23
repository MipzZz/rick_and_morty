import 'package:rick_and_morty/features/app/model/app_theme.dart';
import 'package:rick_and_morty/features/settings/data/source/theme_datasource.dart';
import 'package:rick_and_morty/features/settings/domain/repository/i_theme_repository.dart';

/// Theme repository implementation
final class ThemeRepository implements IThemeRepository {
  /// Create theme repository
  const ThemeRepository({required ThemeDataSource themeDataSource}) : _themeDataSource = themeDataSource;

  final ThemeDataSource _themeDataSource;

  @override
  Future<AppTheme?> getTheme() => _themeDataSource.getTheme();

  @override
  Future<void> setTheme(AppTheme theme) {
    return _themeDataSource.setTheme(theme);
  }
}
