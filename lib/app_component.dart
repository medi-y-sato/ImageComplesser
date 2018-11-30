import 'package:angular/angular.dart';

//import 'src/todo_list/todo_list_component.dart';
import 'src/image_complessor/image_complessor_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [ImageComplessorComponent],
)
class AppComponent {}
