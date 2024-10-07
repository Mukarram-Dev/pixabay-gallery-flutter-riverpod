import 'package:pixabay_gallery/config/assets/image_assets.dart';
import 'package:pixabay_gallery/models/category_pics.dart';
import 'package:pixabay_gallery/models/language_model.dart';

class AppConstants {
  static final languageList = <Language>[
    Language(name: 'English', flag: '🇬🇪'),
    Language(name: 'Italian', flag: '🇹🇫'),
    Language(name: 'Chinese', flag: '🇨🇴'),
    Language(name: 'French', flag: '🇨🇬'),
    Language(name: 'German', flag: '🇩🇪'),
    Language(name: 'Spanish', flag: '🇨🇰'),
  ];

  static final categoryList = <CategoryPics>[
    CategoryPics(categoryName: 'People', categoryImage: ImageAssets.peoplePic),
    CategoryPics(categoryName: 'Flower', categoryImage: ImageAssets.flowerPic),
    CategoryPics(categoryName: 'Animal', categoryImage: ImageAssets.animalPic),
    CategoryPics(categoryName: 'Nature', categoryImage: ImageAssets.naturePic),
  ];
}
