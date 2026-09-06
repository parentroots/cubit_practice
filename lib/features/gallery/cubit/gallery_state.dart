import 'package:cubit_practice/features/gallery/data/model/gallery_model.dart';
import 'package:equatable/equatable.dart';

class GalleryState extends Equatable {
  final List<PhotoModel> photos;
  final bool isLoading;
  final String? errorMessage;


  const GalleryState({
    this.photos = const [],
    this.isLoading = false,
    this.errorMessage,
  });


  GalleryState copyWith({
    List<PhotoModel>? photos,
    bool? isLoading,
    String? errorMessage,
  }) =>
      GalleryState(
        photos: photos ?? this.photos,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
      );


  @override
  // TODO: implement props
  List<Object?> get props => [
    photos,
    isLoading,
    errorMessage,
  ];
}