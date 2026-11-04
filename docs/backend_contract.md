# SIGAP - Dokumen Kontrak Antarmuka Frontend ke Backend

Dokumen ini mendefinisikan interface repository, struktur data DTO/Model, dan endpoint REST API yang dibutuhkan oleh lapisan UI SIGAP untuk integrasi nyata di masa mendatang.

---

## 1. Modul Autentikasi (`AuthRepository`)

### A. Registrasi Pengguna Baru
- **Method**: `POST`
- **Endpoint**: `/api/v1/auth/register`
- **Payload Request**:
```json
{
  "full_name": "Syifa Khaerunisa Nabila",
  "phone_number": "+6281234567890",
  "email": "syifa@example.com",
  "password": "SecretPassword123",
  "emergency_contact": {
    "name": "Ibu",
    "phone_number": "+6281234567890",
    "relation": "Ibu"
  }
}
```
- **Response `201 Created`**:
```json
{
  "success": true,
  "message": "Registrasi berhasil, kode OTP telah dikirim.",
  "data": {
    "user_id": "usr_99812",
    "otp_expires_in_seconds": 60
  }
}
```

### B. Verifikasi OTP
- **Method**: `POST`
- **Endpoint**: `/api/v1/auth/verify-otp`
- **Payload Request**:
```json
{
  "phone_number": "+6281234567890",
  "otp_code": "482103"
}
```
- **Response `200 OK`**:
```json
{
  "success": true,
  "token": "jwt_token_sample_here",
  "user": {
    "id": "usr_99812",
    "full_name": "Syifa Khaerunisa Nabila",
    "phone_number": "+6281234567890"
  }
}
```

### C. Kirim Ulang OTP
- **Method**: `POST`
- **Endpoint**: `/api/v1/auth/resend-otp`
- **Payload Request**:
```json
{
  "phone_number": "+6281234567890",
  "channel": "whatsapp" // atau "sms"
}
```

---

## 2. Modul Layanan Darurat & Lokasi (`EmergencyServiceRepository`)

### A. Daftar Instansi Darurat Terdekat
- **Method**: `GET`
- **Endpoint**: `/api/v1/emergency-services/nearby?lat=-6.8797&lng=109.1256&radius_km=5`
- **Response `200 OK`**:
```json
{
  "success": true,
  "data": [
    {
      "id": "svc_1",
      "name": "Polisi",
      "category": "police",
      "distance_km": 1.2,
      "phone_number": "110",
      "latitude": -6.8790,
      "longitude": 109.1230
    },
    {
      "id": "svc_2",
      "name": "Damkar",
      "category": "fire",
      "distance_km": 2.4,
      "phone_number": "113",
      "latitude": -6.8820,
      "longitude": 109.1280
    },
    {
      "id": "svc_3",
      "name": "Rumah Sakit",
      "category": "hospital",
      "distance_km": 1.5,
      "phone_number": "118",
      "latitude": -6.8750,
      "longitude": 109.1210
    },
    {
      "id": "svc_4",
      "name": "PMI",
      "category": "ambulance",
      "distance_km": 2.8,
      "phone_number": "0283-356123",
      "latitude": -6.8840,
      "longitude": 109.1300
    }
  ]
}
```

---

## 3. Modul Pelaporan Kejadian (`ReportRepository`)

### A. Unggah Laporan Kejadian
- **Method**: `POST` (Multipart / Form-Data)
- **Endpoint**: `/api/v1/reports`
- **Fields**:
  - `category`: "Kecelakaan" | "Kebakaran" | "Bencana Alam" | "Lainnya"
  - `description`: "Kecelakaan di depan minimarket..."
  - `latitude`: -6.8797
  - `longitude`: 109.1256
  - `address`: "Jl. Pancasila, Tegal"
  - `photo`: File binary (JPEG)
- **Response `201 Created`**:
```json
{
  "success": true,
  "message": "Laporan berhasil dikirim dan menunggu verifikasi.",
  "data": {
    "report_id": "rep_20261104_001",
    "status": "pending_verification",
    "created_at": "2026-11-04T10:45:00Z"
  }
}
```

---

## 4. Modul Feed Komunitas (`CommunityRepository`)

### A. Feed Laporan Publik
- **Method**: `GET`
- **Endpoint**: `/api/v1/community/feed?lat=-6.8797&lng=109.1256&limit=20`
- **Response `200 OK`**:
```json
{
  "success": true,
  "data": [
    {
      "id": "post_01",
      "author_name": "Warga Tegal",
      "time_ago": "2 jam yang lalu",
      "distance": "1,2 km",
      "tag": "Darurat",
      "title": "Kecelakaan di Jl. Pancasila",
      "description": "Terjadi kecelakaan motor dan mobil di Jl. Pancasila arah kota...",
      "image_url": "https://cdn.sigap.id/reports/rep_01.jpg",
      "likes_count": 120,
      "comments_count": 15,
      "is_suspected_hoax": true
    },
    {
      "id": "post_02",
      "author_name": "Rizky_07",
      "time_ago": "4 jam yang lalu",
      "distance": "2,5 km",
      "tag": null,
      "title": "Banjir di Perumahan Taman Indah",
      "description": "Air sudah mulai naik sekitar 30 cm. Hati-hati yang melintas.",
      "image_url": null,
      "likes_count": 45,
      "comments_count": 6,
      "is_suspected_hoax": false
    }
  ]
}
```

---

## 5. Modul Asisten P3K & AI Assistant (`FirstAidRepository`)

### A. Kirim Pesan / Voice Memo P3K
- **Method**: `POST`
- **Endpoint**: `/api/v1/first-aid/chat`
- **Payload Request**:
```json
{
  "message": "Korban kecelakaan motor tergeletak di tepi jalan...",
  "voice_audio_url": "https://storage.sigap.id/voice/memo_12.m4a",
  "location": {
    "address": "Jl. Pancasila No. 12",
    "accuracy": "3m",
    "lat": -6.8797,
    "lng": 109.1256
  }
}
```
- **Response `200 OK`**:
```json
{
  "success": true,
  "ambulance_dispatch": {
    "status": "Ambulans PMI Tegal terkoordinasi",
    "eta_minutes": 6
  },
  "guidance": {
    "priority": 1,
    "topic": "Panduan Tanggap: Korban Tak Sadar & Pendarahan Lengan",
    "steps": [
      {
        "step": 1,
        "title": "Amankan & Jangan Gerakkan Leher",
        "description": "Pastikan posisi aman dari arus lalu lintas..."
      },
      {
        "step": 2,
        "title": "Tekan Kuat Titik Pendarahan",
        "description": "Gunakan kain bersih, perban, atau pakaian tebal..."
      },
      {
        "step": 3,
        "title": "Cek Jalan Napas & Denyut Nadi",
        "description": "Dekatkan pipi ke hidung korban selama 10 detik..."
      }
    ]
  }
}
```
