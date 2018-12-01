import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'dart:convert';
import 'package:image/image.dart';

@Component(
    selector: 'image-complessor',
    styleUrls: ['image_complessor_component.css'],
    templateUrl: 'image_complessor_component.html',
    directives: [
      NgFor,
      NgIf,
    ],
    providers: [])
class ImageComplessorComponent implements OnInit {
  var selectedFile;
  List<Result> results;
  int source_bytes;

  ImageComplessorComponent();

  @override
  Future<Null> ngOnInit() async {
    resultsInit();
  }

  resultsInit() {
    results = [];
    for (var i = 10; i <= 100; i = i + 10) {
      results.add(Result(i, 0));
    }
  }

  onFileChanged(event) {
    resultsInit();

    selectedFile = event.target.files[0];

    FileReader reader = new FileReader();
    reader.readAsArrayBuffer(selectedFile);
    reader.onLoad.listen((fileEvent) {
      List<int> sourceData = reader.result;
      Image sourceImage = decodeImage(sourceData);

      var source64 = new Base64Encoder().convert(sourceData);

      ImageElement sourceImg = document.querySelector("#sourceImage");
      sourceImg.src = 'data:image/png;base64,${source64}';
      source_bytes = source64.length;

      for (var i = 10; i <= 100; i = i + 10) {
        JpegEncoder jpegEncoder = new JpegEncoder(quality: i);
        List EncodedBinary = jpegEncoder.encodeImage(sourceImage);
        var Encoded64 = new Base64Encoder().convert(EncodedBinary);

        ImageElement target = document.querySelector("#level${i}");
        target.src = 'data:image/jpeg;base64,${Encoded64}';

        results.forEach((result) {
          if (result.id == i) {
            result.bytes = Encoded64.length;
          }
        });
      }
    });
  }

  onUpload() {}
}

class Result {
  int id;
  int bytes;
  Result(this.id, this.bytes);
  @override
  String toString() => '$id: $bytes';
}
