# HomeScreen_IVI
Phát triển từ đồ án AAD305x khóa học Automotive
* Đang phát triển tiếp
***
**Chú ý: cần cài thêm các thư viện hỗ trợ **
* Install LGL nếu build bị lỗi -lGL error
  - `sudo apt-get install libgl1-mesa-dev`

* Thư viện Gstream (hỗ trợ phát các link stream trực tiếp dạng m3u8...). Ứng dụng Video và Radio đang phát dạng này.
  - Cài đặt: `sudo apt-get install libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio`
  - Tham khảo tại: https://minhng.info/scripts/cai-dat-gstreamer.html	
   https://gstreamer.freedesktop.org/documentation/installing/on-linux.html?gi-language=c

***
**IDE/Compiler: Qt Creator 5.14 64bit/GCC**
* Platform suport: Ubuntu / Windows
* Note:
  - Trên Windows, không giao tiếp được D-Bus

***
** Sử dụng **
* Mở app InputData trước khi mở app HomeScreen vì HomeScreen sẽ kết nối và đọc dữ liệu từ InputData
* Sử dụng hardkey:
  - Nhấn Enter để bắt đầu hiển thị focus
  - Nhấn Up/Down/Left/Right để select
  - Nhấn giữ Shit + navigation để reorder
  -

***
** Các ứng dụng bên trong app Home **
* Map
* Media
* Video: Play/Pause live TV khi nhấn Enter/mouse
* Radio: Play/Pause radio online khi nhấn Enter/mouse
* Phone
* Climate
* Setting
* Other ... coming soon

***


