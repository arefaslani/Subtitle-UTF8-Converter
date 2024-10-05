# Subtitle UTF-8 Converter
Subtitle UTF-8 Converter is a simple macOS app that converts SRT subtitle files with Windows-1256 encoding (commonly used for Arabic subtitles) to UTF-8 encoding. This app was built as a personal project to automate a task I frequently encountered, but I decided to share it for anyone who might find it useful.

Previously, I used a bash script for this job, but now this native app provides a user-friendly macOS interface to accomplish the same task.

## Features
* Convert SRT subtitle files from Windows-1256 encoding to UTF-8.
* Easy drag-and-drop interface for quick conversion.
* Saves the converted files automatically to a desired location.
* Lightweight and fast.

## Requirements
* macOS 11.0 (Big Sur) or later.

## Installation
### Option 1: Download Prebuilt App
1. Download the latest release from the Releases section.
2. Open the .dmg file and drag the app into your Applications folder.

### Option 2: Build from Source
1. Clone the repository:
```bash
git clone https://github.com/arefaslani/Subtitle-UTF8-Converter.git
cd Subtitle-UTF8-Converter
```
2. Open the project in Xcode:
```
open Subtitle\ UTF-8\ Converter.xcodeproj
```
3. Build and run the project in Xcode.

## Usage
1. Launch the app.
2. Drag and drop the .srt subtitle files into the app window.
3. The app will automatically detect if the files are in Windows-1256 encoding and convert them to UTF-8.
4. The converted files will be saved to the original folder or another destination you choose.

## Why Use This App?
If you're working with SRT subtitle files that contain text in languages such as Arabic (Windows-1256 encoding), they may not display correctly on macOS media players or subtitle editors or in built-in TV media players. Converting these files to UTF-8 encoding resolves this issue.

## Contributing
If you'd like to contribute or suggest improvements, feel free to fork the repository and create a pull request.
1. Fork the repository
2. Create your feature branch: git checkout -b my-new-feature
3. Commit your changes: git commit -am 'Add some feature'
4. Push to the branch: git push origin my-new-feature
5. Submit a pull request

## License
This project is licensed under the MIT License.

## Acknowledgments
Thanks to the open-source community for various code snippets and libraries that inspired parts of this project.

Special thanks to Rob for providing the Swift code to convert Windows-1256 to UTF-8 encoding under [this Stack Overflow question](https://stackoverflow.com/questions/67142078/arabic-text-file-couldn-t-be-opened).
