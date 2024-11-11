import 'package:flutex_admin/data/model/project/project_model.dart';
import 'package:flutex_admin/data/model/project/project_post_model.dart';

abstract class ProjectRepository {
 Stream<ProjectsModel>  getProjectDataStream();
  Future<void> addProjectDataToFirestore(ProjectPostModel projectData);
}
