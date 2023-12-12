# ENMUmobile

<p align="justify">
     <img align="right" src="https://github.com/nwc6624/ENMU_CS_458_Semester_Project/assets/6959463/dbf6bc5c-e256-4b77-9840-1f48ecce088f" alt="Screenshot_20231211-182235">
    In our CS 458, Android Development course, we embraced the challenge of addressing a pressing issue faced by students at Eastern New Mexico University. Despite a vibrant student body of over 4,000, the university lacked a dedicated campus-specific application to cater to student needs. Drawing from our own experiences as students, we had a clear vision of the ideal functionalities and features
    of such an application. To bring this vision to life, we utilized Flutter, a cutting-edge UI software development kit, ensuring seamless cross-compatibility across both Android and IOS platforms. This project not only enhanced our technical skills but also will contribute significantly to the student community at ENMU.
</p>

## Getting Started
  <tr>
    <td>

This guide walks you through the process of downloading and setting up the project in Android Studio, assuming Flutter and Dart are already installed.

## Steps

  <tr>
    <td>

This guide walks you through the process of downloading and setting up the project in Android Studio, assuming Flutter and Dart are already installed.

## Steps

<table>
<tr>
    <td>
        <img src="https://github.com/nwc6624/ENMU_CS_458_Semester_Project/assets/6959463/81801da1-433f-4f31-89f8-20cabe724c6a" alt="Screenshot_20231211-183934" width="200" height="400">
        <img src="https://github.com/nwc6624/ENMU_CS_458_Semester_Project/assets/6959463/311ed258-dd62-4b06-93eb-2458554947e7" alt="Screenshot_20231211-191049" width="200" height="400">
        <img src="https://github.com/nwc6624/ENMU_CS_458_Semester_Project/assets/6959463/5fbed7f8-b084-4e41-9312-171463d3604d" alt="Screenshot_20231211-191106" width="200" height="400">
    </td>
</tr>



<h3>1. Clone the Repository</h3>
<p>Open Android Studio and follow these steps:</p>
<ul>
    <li>Navigate to <code>File &gt; New &gt; Project from Version Control</code>.</li>
    <li>In the URL field, enter <code>https://github.com/nwc6624/ENMU_CS_458_Semester_Project.git</code>.</li>
    <li>Select the directory to clone into and click <code>Clone</code>.</li>
</ul>

<h3>2. Open the Cloned Project</h3>
<p>If the project isn't automatically opened:</p>
<ul>
    <li>Go to <code>File &gt; Open</code>.</li>
    <li>Select the cloned project directory.</li>
</ul>

<h3>3. Install Flutter and Dart Plugins</h3>
<p>If not already installed:</p>
<ul>
    <li>Go to <code>File &gt; Settings &gt; Plugins</code>.</li>
    <li>Search and install <code>Flutter</code>. This should also install <code>Dart</code>.</li>
    <li>Restart Android Studio.</li>
</ul>

<h3>4. Get Dependencies</h3>
<p>Within Android Studio's terminal:</p>
<ul>
    <li>Run <code>flutter pub get</code> in the project's root directory.</li>
</ul>

<h3>5. Run the Project</h3>
<ul>
    <li>Select a device or emulator.</li>
    <li>Click the 'Run' icon.</li>
</ul>

### Prerequisites

<h1>Project Prerequisites</h1>

<p>Before setting up the project, ensure you have the following software installed:</p>

<h2>Required Software</h2>

<ul>
    <li><strong>Flutter:</strong> Used for mobile app development.</li>
    <li><strong>Dart SDK:</strong> Programming language used by Flutter.</li>
    <li><strong>Android Studio:</strong> IDE for Android development.</li>
</ul>

<h2>Installation Guide</h2>

<h3>Installing Flutter</h3>
<ul>
    <li>Download Flutter SDK from <a href="https://flutter.dev/docs/get-started/install">Flutter's official website</a>.</li>
    <li>Extract the SDK to a preferred location on your system.</li>
    <li>Add Flutter to your system's PATH.</li>
    <li>Run <code>flutter doctor</code> in a terminal to check for any additional dependencies.</li>
</ul>

<h3>Installing Android Studio</h3>
<ul>
    <li>Download Android Studio from <a href="https://developer.android.com/studio">Android's official website</a>.</li>
    <li>Run the installer and follow the setup wizard.</li>
    <li>Open Android Studio, go to <code>File &gt; Settings &gt; Plugins</code>.</li>
    <li>Search for the Flutter plugin and install it (this should automatically install Dart).</li>
</ul>


<h2>Flutter Dependencies</h2>
<p>Add the following (Android) dependencies to your <code>pubspec.yaml</code> file:</p>

<pre>
dependencies:
  flutter:
    sdk: flutter
  latlong2: ^0.9.0      # Upgraded to ^0.9.0 to resolve the version conflict
  url_launcher: ^6.2.1
  cupertino_icons: ^1.0.2
  image_gallery_saver: ^2.0.3
  connectivity_plus: ^5.0.1
  syncfusion_flutter_pdfviewer: ^23.1.43
  webview_flutter: ^3.0.3
  flutter_map: ^6.0.1
  http: ^1.0.0
  html: ^0.15.0
  flutter_native_splash: ^2.3.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/pdfs/
</pre>

<!-- Additional Setup Instructions Here -->

</body>
<h2>Installing</h2>

<p>After adding (Or verifying) the dependencies, save the <code>pubspec.yaml</code> file.</p>
<p>Android Studio will prompt you to get packages. You can click on <strong>Get dependencies</strong> in the bar that appears at the top of the editor.</p>
<p>Alternatively, you can open the terminal within Android Studio (usually located at the bottom of the IDE) and run the command:</p>

<pre><code>flutter pub get</code></pre>

<h3>Verify Installation:</h3>
<p>Once the dependencies are fetched, you should see a message in the terminal indicating that the process is complete.</p>
<p>Your project is now ready to use these dependencies.</p>

<h3>Sync Your Project:</h3>
<p>If needed, click on <strong>Sync Now</strong> in the bar that appears at the top of the IDE to ensure everything is up to date.</p>

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

<h2>Running the App on an Android Device</h2>

<ol>
    <li><strong>Enable Developer Options and USB Debugging:</strong>
        <ul>
            <li>On your Android device, go to <code>Settings &gt; About phone</code>, tap <code>Build number</code> 7 times.</li>
            <li>Go to <code>Settings &gt; System &gt; Advanced &gt; Developer options</code>, enable <code>USB debugging</code>.</li>
        </ul>
    </li>
    <li><strong>Connect Device to Computer:</strong>
        <p>Use a USB cable to connect your device to the computer.</p>
    </li>
    <li><strong>Run the App from Android Studio:</strong>
        <ul>
            <li>Open your project in Android Studio.</li>
            <li>Select your device from the dropdown in the toolbar.</li>
            <li>Click the ‘Run’ button.</li>
        </ul>
    </li>
</ol>

<p><em>Note: This project is TBA for Google Play Store deployment.</em></p>


## Built With

* [Flutter](https://flutter.dev/) - UI SDK used
* [Dart](https://dart.dev/) - Language used
* [Open Street Maps](https://www.openstreetmap.org/) - Used to display real time-map of the city of Portales


## Authors

* **Noah Caulfield** - *Senior in Computer Science* - [Github](https://github.com/nwc6624)
*  **Jake Gill**     - *Senior in Industrial Mathematics* - [Github](https://github.com/GillieWillie)

See also the list of [contributors](https://github.com/nwc6624/ENMU_CS_458_Semester_Project/blob/main/s1_team_proj_idea.txt) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

We hope that this code will serve asa bacis for furter development for an ENMU resources application. 
