class FirstAidTopic {
  final String title;
  final bool isDefaultActive;

  const FirstAidTopic({required this.title, this.isDefaultActive = false});
}

class FirstAidStep {
  final int number;
  final String title;
  final String description;

  const FirstAidStep({
    required this.number,
    required this.title,
    required this.description,
  });
}

abstract class FirstAidRepository {
  Future<List<FirstAidTopic>> getQuickTopics();
  Future<List<FirstAidStep>> getGuidanceSteps(String topic);
  Future<String> sendChatMessage(String message);
}

class MockFirstAidRepository implements FirstAidRepository {
  @override
  Future<List<FirstAidTopic>> getQuickTopics() async {
    return const [
      FirstAidTopic(title: 'Pendarahan Hebat', isDefaultActive: true),
      FirstAidTopic(title: 'Resusitasi Jantung (CPR)'),
      FirstAidTopic(title: 'Patah Tulang'),
      FirstAidTopic(title: 'Korban Tidak Sadar'),
      FirstAidTopic(title: 'Keracunan / Sengatan'),
    ];
  }

  @override
  Future<List<FirstAidStep>> getGuidanceSteps(String topic) async {
    return const [
      FirstAidStep(
        number: 1,
        title: 'Amankan & Jangan Gerakkan Leher',
        description:
            'Pastikan posisi aman dari arus lalu lintas. Jangan memindahkan leher atau punggung jika dicurigai cedera benturan tulang belakang.',
      ),
      FirstAidStep(
        number: 2,
        title: 'Tekan Kuat Titik Pendarahan',
        description:
            'Gunakan kain bersih, perban, atau pakaian tebal. Tekan terus-menerus tepat di atas luka. Jangan lepas tekanan sampai petugas medis tiba.',
      ),
      FirstAidStep(
        number: 3,
        title: 'Cek Jalan Napas & Denyut Nadi',
        description:
            'Dekatkan pipi ke hidung korban selama 10 detik. Jika napas terhenti, mulailah kompresi dada (CPR 100-120x per menit).',
      ),
    ];
  }

  @override
  Future<String> sendChatMessage(String message) async {
    // Simulasi respons bot P3K
    return 'Bantuan medis sedang dipandu. Tetap tenang dan ikuti langkah darurat di atas.';
  }
}
