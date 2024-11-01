import 'package:get_it/get_it.dart';
import 'package:suvido_eshop/shared/_project_shared_exporter.dart';
import 'package:suvido_eshop/shared/networking/network_manager.dart';

final getIt = GetIt.instance;

void initProject() {
  getIt.registerSingleton<DummyJsonApi>(
    DummyJsonApi(
      networkManager: NetworkManager(
        baseUrl: EnvironmentVariables.dummyJsonBaseUrl,
        timeOut: 5,
      ),
    ),
  );
}
