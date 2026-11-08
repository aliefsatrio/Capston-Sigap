// Model untuk menyimpan topik darurat P3K
class FirstAidTopic {
  final String title; // Nama topik
  final bool isDefaultActive; 

  const FirstAidTopic({
    required this.title,
    this.isDefaultActive = false,
  });
}

// Model untuk menyimpan langkah panduan P3K
class FirstAidStep {
  final int number; // Nomor langkah
  final String title;
  final String description; 

  const FirstAidStep({
    required this.number,
    required this.title,
    required this.description,
  });
}

// nentuin fungsi dibutuhkn 
abstract class FirstAidRepository {
  Future<List<FirstAidTopic>> getQuickTopics();
  // Mengambil daftar topik P3K

  Future<List<FirstAidStep>> getGuidanceSteps(String topic);
  // Mengambil panduan berdasarkan topik

  Future<String> sendChatMessage(String message);
  // Mengirim pesan dan menerima respons bot
}

// Implementasi repository dengan data simulasi
class MockFirstAidRepository implements FirstAidRepository {
  @override
  Future<List<FirstAidTopic>> getQuickTopics() async {
    return const [
      FirstAidTopic(
        title: 'Pendarahan Hebat',
        isDefaultActive: true,
      ),
      FirstAidTopic(title: 'Resusitasi Jantung (CPR)'),
      FirstAidTopic(title: 'Patah Tulang'),
      FirstAidTopic(title: 'Korban Tidak Sadar'),
      FirstAidTopic(title: 'Keracunan / Sengatan'),
    ];
  }

  @override
  Future<List<FirstAidStep>> getGuidanceSteps(String topic) async {
    // Mengembalikan tiga langkah panduan P3K
    return const [
      FirstAidStep(
        number: 1,
        title: 'Amankan & Jangan Gerakkan Leher',
        description: 'Pastikan posisi aman...',
      ),
      // Langkah 2 , 3 mengikuti struktur yg sama
    ];
  }

  @override
  Future<String> sendChatMessage(String message) async {
    
    return 'Bantuan medis sedang dipandu. Tetap tenang...';
  }
}