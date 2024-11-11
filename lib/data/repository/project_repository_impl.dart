import 'package:flutex_admin/data/datasource/project_remote_datsource.dart';
import 'package:flutex_admin/data/model/project/project_model.dart';
import 'package:flutex_admin/data/model/project/project_post_model.dart';
import 'package:flutex_admin/domain/project_repository.dart';


class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;

  ProjectRepositoryImpl(this.remoteDataSource);
 
 

  @override
  Stream<ProjectsModel> getProjectDataStream() {
      return remoteDataSource.getProjectDataStream().map((data) {
      final projectsModel = ProjectsModel.fromJson(data['data']);
      return projectsModel;
    });
  }

  @override
  Future<void> addProjectDataToFirestore(ProjectPostModel projectData)async {
      Map<String, dynamic> projectJson = projectData.toJson();
    await remoteDataSource.addProjectToFirestore(projectJson);
  }
}
