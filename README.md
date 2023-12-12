# ENMUmobile

<p align="justify">
     <img align="right" src="https://github.com/nwc6624/ENMU_CS_458_Semester_Project/assets/6959463/dbf6bc5c-e256-4b77-9840-1f48ecce088f" alt="Screenshot_20231211-182235">
    In our CS 458, Android Development course, we embraced the challenge of addressing a pressing issue faced by students at Eastern New Mexico University. Despite a vibrant student body of over 4,000, the university lacked a dedicated campus-specific application to cater to student needs. Drawing from our own experiences as students, we had a clear vision of the ideal functionalities and features
    of such an application. To bring this vision to life, we utilized Flutter, a cutting-edge UI software development kit, ensuring seamless cross-compatibility across both Android and IOS platforms. This project not only enhanced our technical skills but also will contribute significantly to the student community at ENMU.
</p>

## Getting Started

<h1>Project Setup Instructions</h1>

<p>This guide walks you through the process of downloading and setting up the project in Android Studio, assuming Flutter and Dart are already installed.</p>

<h2>Steps</h2>

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

<h1>Project Prerequisites and Dependencies</h1>

<p>Before setting up the project, ensure you have the following software and dependencies installed:</p>

<h2>Required Software</h2>
<!-- Software Installation Guide Here -->

<h2>Flutter Dependencies</h2>
<p>Add the following dependencies to your <code>pubspec.yaml</code> file:</p>

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
### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

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

Add additional notes about how to deploy this on a live system

## Built With

* [Flutter](https://flutter.dev/) - UI SDK used
* [Dart](https://dart.dev/) - Language used
* [Open Street Maps](https://www.openstreetmap.org/) - Used to display real time-map of the city of Portales

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Noah Caulfield** - *Senior in Computer Science* - [Github](https://github.com/nwc6624)
*  **Jake Gill**     - *Senior in Industrial Mathematics* - [Github](https://github.com/GillieWillie)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc


/////////////////////////////////////////////////////////////

![image](https://github.com/nwc6624/ENMU_CS_458_Semester_Project/assets/6959463/66a403f3-e517-4a76-b20b-31f9a8423016)
![image](https://github.com/nwc6624/ENMU_CS_458_Semester_Project/assets/6959463/6378e59f-5bc1-4963-9526-f42fd865f338)
![image](https://github.com/nwc6624/ENMU_CS_458_Semester_Project/assets/6959463/1c78a341-f028-4ca7-b900-af67568bb0ea)

