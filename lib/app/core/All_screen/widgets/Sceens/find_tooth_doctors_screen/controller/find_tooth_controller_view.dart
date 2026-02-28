// controllers/find_doctor_controller.dart
import 'package:get/get.dart';

class FindDoctorController extends GetxController {
  // সার্চ টেক্সট
  var searchText = ''.obs;
  
  // সিলেক্টেড ক্যাটাগরি (null মানে সব ক্যাটাগরি দেখাবে)
  var selectedCategory = RxnString('');
  
  // ডাক্তারদের তালিকা (সকল ক্যাটাগরি)
  final List<Map<String, dynamic>> allDoctors = [
    // Dentists
    {
      'name': 'Dr. Sarah Johnson',
      'specialty': 'Dentist',
      'exp': '8 years experience',
      'like': '98%',
      'stories': '120+ stories',
      'isFavorite': false,
      'nextAvailable': 'Today, 2:30 PM',
      'category': 'Dentist',
      'image': 'https://i.pravatar.cc/150?u=1',
    },
    {
      'name': 'Dr. Michael Chen',
      'specialty': 'Dentist',
      'exp': '12 years experience',
      'like': '95%',
      'stories': '200+ stories',
      'isFavorite': false,
      'nextAvailable': 'Tomorrow, 10:00 AM',
      'category': 'Dentist',
      'image': 'https://i.pravatar.cc/150?u=2',
    },
    
    // Cardiologists
    {
      'name': 'Dr. Emily Williams',
      'specialty': 'Cardiologist',
      'exp': '15 years experience',
      'like': '99%',
      'stories': '180+ stories',
      'isFavorite': false,
      'nextAvailable': 'Today, 4:00 PM',
      'category': 'Cardiologist',
      'image': 'https://i.pravatar.cc/150?u=3',
    },
    {
      'name': 'Dr. James Brown',
      'specialty': 'Cardiologist',
      'exp': '10 years experience',
      'like': '97%',
      'stories': '150+ stories',
      'isFavorite': false,
      'nextAvailable': 'Wed, 9:30 AM',
      'category': 'Cardiologist',
      'image': 'https://i.pravatar.cc/150?u=4',
    },
    
    // Eye Specialists
    {
      'name': 'Dr. Lisa Garcia',
      'specialty': 'Eye Specialist',
      'exp': '9 years experience',
      'like': '96%',
      'stories': '110+ stories',
      'isFavorite': false,
      'nextAvailable': 'Today, 5:15 PM',
      'category': 'Eye Specialist',
      'image': 'https://i.pravatar.cc/150?u=5',
    },
    {
      'name': 'Dr. David Kim',
      'specialty': 'Eye Specialist',
      'exp': '14 years experience',
      'like': '98%',
      'stories': '165+ stories',
      'isFavorite': false,
      'nextAvailable': 'Thu, 11:00 AM',
      'category': 'Eye Specialist',
      'image': 'https://i.pravatar.cc/150?u=6',
    },
    
    // Physiotherapists
    {
      'name': 'Dr. Robert Taylor',
      'specialty': 'Physiotherapist',
      'exp': '7 years experience',
      'like': '94%',
      'stories': '95+ stories',
      'isFavorite': false,
      'nextAvailable': 'Today, 3:45 PM',
      'category': 'Physiotherapist',
      'image': 'https://i.pravatar.cc/150?u=7',
    },
    {
      'name': 'Dr. Maria Rodriguez',
      'specialty': 'Physiotherapist',
      'exp': '11 years experience',
      'like': '97%',
      'stories': '130+ stories',
      'isFavorite': false,
      'nextAvailable': 'Fri, 2:00 PM',
      'category': 'Physiotherapist',
      'image': 'https://i.pravatar.cc/150?u=8',
    },
    
    // General Physicians
    {
      'name': 'Dr. John Smith',
      'specialty': 'General Physician',
      'exp': '6 years experience',
      'like': '92%',
      'stories': '80+ stories',
      'isFavorite': false,
      'nextAvailable': 'Today, 6:30 PM',
      'category': 'General Physician',
      'image': 'https://i.pravatar.cc/150?u=9',
    },
    {
      'name': 'Dr. Patricia White',
      'specialty': 'General Physician',
      'exp': '13 years experience',
      'like': '96%',
      'stories': '140+ stories',
      'isFavorite': false,
      'nextAvailable': 'Mon, 10:30 AM',
      'category': 'General Physician',
      'image': 'https://i.pravatar.cc/150?u=10',
    },
  ];

  // ফিল্টার করা ডাক্তারদের তালিকা (observable)
  var filteredDoctors = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    
    // প্রাথমিকভাবে সব ডাক্তার দেখাবে
    filteredDoctors.value = allDoctors;
  }

  // ক্যাটাগরি সেট করার মেথড
  void setCategory(String category) {
    selectedCategory.value = category;
    applyFilters();
  }

  // সব ক্যাটাগরি দেখানোর মেথড
  void showAllCategories() {
    selectedCategory.value = '';
    applyFilters();
  }

  // সার্চ আপডেট করার মেথড
  void updateSearch(String query) {
    searchText.value = query;
    applyFilters();
  }

  // সার্চ ক্লিয়ার করার মেথড
  void clearSearch() {
    searchText.value = '';
    applyFilters();
  }

  // ফিল্টার প্রয়োগ করার মেথড
  void applyFilters() {
    var filtered = allDoctors;

    // ক্যাটাগরি ফিল্টার প্রয়োগ
    if (selectedCategory.value != null && selectedCategory.value!.isNotEmpty) {
      filtered = filtered.where((doctor) => 
        doctor['category'] == selectedCategory.value
      ).toList();
    }

    // সার্চ ফিল্টার প্রয়োগ
    if (searchText.value.isNotEmpty) {
      filtered = filtered.where((doctor) {
        final name = doctor['name'].toString().toLowerCase();
        final specialty = doctor['specialty'].toString().toLowerCase();
        final query = searchText.value.toLowerCase();
        
        return name.contains(query) || specialty.contains(query);
      }).toList();
    }

    filteredDoctors.value = filtered;
  }

  // ফেভারিট টগল করার মেথড
  void toggleFavorite(int index) {
    if (index >= 0 && index < allDoctors.length) {
      allDoctors[index]['isFavorite'] = !allDoctors[index]['isFavorite'];
      
      // ফিল্টার করা তালিকাও আপডেট করুন
      final doctorName = allDoctors[index]['name'];
      final filteredIndex = filteredDoctors.indexWhere((d) => d['name'] == doctorName);
      
      if (filteredIndex != -1) {
        filteredDoctors[filteredIndex]['isFavorite'] = allDoctors[index]['isFavorite'];
        filteredDoctors.refresh();
      }
    }
  }
}