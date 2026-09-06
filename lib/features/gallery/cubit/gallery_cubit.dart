import 'package:cubit_practice/features/gallery/cubit/gallery_state.dart';
import 'package:cubit_practice/features/gallery/repo/gallery_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryCubit extends Cubit<GalleryState> {
  final GalleryRepo _galleryRepo;

  GalleryCubit({GalleryRepo? galleryRepo})
      : _galleryRepo = galleryRepo ?? GalleryRepo(),
        super(const GalleryState()) {
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    emit(state.copyWith(isLoading: true));

    try {
      final photos = await _galleryRepo.fetchPhotos();
      emit(state.copyWith(photos: photos, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
