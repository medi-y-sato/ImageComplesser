import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'dart:convert';
import 'package:image/image.dart';

import 'image_complessor_service.dart';

@Component(
    selector: 'image-complessor',
    styleUrls: ['image_complessor_component.css'],
    templateUrl: 'image_complessor_component.html',
    directives: [
      MaterialCheckboxComponent,
      MaterialFabComponent,
      MaterialIconComponent,
      materialInputDirectives,
      NgFor,
      NgIf,
    ],
    providers: [ClassProvider(ImageComplessorService)])
class ImageComplessorComponent implements OnInit {
  final ImageComplessorService imageComplessorService;

  var selectedFile;
  List<String> results = [];

  ImageComplessorComponent(this.imageComplessorService);

  @override
  Future<Null> ngOnInit() async {
    for (var i = 10; i <= 100; i = i + 10) {
      results.add(i.toString());
    }
  }

  onFileChanged(event) {
    selectedFile = event.target.files[0];

    FileReader reader = new FileReader();
    reader.readAsArrayBuffer(selectedFile);
    reader.onLoad.listen((fileEvent) {
      List<int> sourceData = reader.result;
      Image sourceImage = decodeImage(sourceData);

      var source64 = new Base64Encoder().convert(sourceData);

      ImageElement sourceImg = document.querySelector("#sourceImage");
      sourceImg.src = 'data:image/png;base64,${source64}';

      for (var i = 10; i <= 100; i = i + 10) {
        JpegEncoder jpegEncoder = new JpegEncoder(quality: i);
        List EncodedBinary = jpegEncoder.encodeImage(sourceImage);
        var Encoded64 = new Base64Encoder().convert(EncodedBinary);

        ImageElement target = document.querySelector("#level${i}");
        target.src = 'data:image/jpeg;base64,${Encoded64}';
      }
    });
  }

  onUpload() {}
}
