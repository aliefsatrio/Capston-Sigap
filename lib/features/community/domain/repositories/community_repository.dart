class CommunityPost {
  final String id;
  final String authorName;
  final String timeAgo;
  final String distance;
  final String tag;
  final String title;
  final String description;
  final String? imagePath;
  final int likes;
  final int comments;
  final bool isSuspectedHoax;

// model nyimpan data post di feed komunitas
  const CommunityPost({
    required this.id,
    required this.authorName,
    required this.timeAgo,
    required this.distance,
    required this.tag,
    required this.title,
    required this.description,
    this.imagePath,
    required this.likes,
    required this.comments,
    this.isSuspectedHoax = false,
  });
}


abstract class CommunityRepository {
  Future<List<CommunityPost>> getFeedPosts();
  Future<List<Map<String, dynamic>>> getMapIncidents();
}
// Implementasi repository dengan data simulasi
class MockCommunityRepository implements CommunityRepository {
  @override
  Future<List<CommunityPost>> getFeedPosts() async {
    
    return const [
      CommunityPost(
        id: 'post-1',
        authorName: 'Warga Tegal',
        timeAgo: '2 jam yang lalu',
        distance: '1,2 km',
        tag: 'Darurat',
        title: 'Kecelakaan di Jl. Pancasila',
        description:
            'Terjadi kecelakaan motor dan mobil di Jl. Pancasila arah kota. Mohon hindari jalur ini sementara waktu.',
        likes: 120,
        comments: 15,
        isSuspectedHoax: true,
      ),
      CommunityPost(
        id: 'post-2',
        authorName: 'Rizky_07',
        timeAgo: '4 jam yang lalu',
        distance: '2,5 km',
        tag: '',
        title: 'Banjir di Perumahan Taman Indah',
        description: 'Air sudah mulai naik sekitar 30 cm. Hati-hati yang melintas.',
        likes: 45,
        comments: 6,
        isSuspectedHoax: false,
      ),
    ];
  }
  
  @override
  Future<List<Map<String, dynamic>>> getMapIncidents() async {
    return const [
      {
        'id': 'map-1',
        'category': 'Kecelakaan',
        'location': 'Jl. Pancasila, Tegal',
        'timeAgo': '2 jam yang lalu',
        'latitude': -6.8797,
        'longitude': 109.1256,
      },
    ];
  }
}