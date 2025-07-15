<h1>📱 QR Scanner - Flutter App</h1>
<p>
A simple and lightweight Flutter application to scan QR codes using the device camera, 
view the scanned data, copy it to clipboard, or open it in a browser (if it is a URL).
</p>

<h2>✨ Features</h2>
  <ul>
    <li>Scan QR codes in real-time using the camera</li>
    <li>Display scanned result instantly on screen</li>
    <li>Detects and handles URLs – tap to open them in the browser</li>
    <li>Copy scanned text or URL to clipboard with a button</li>
    <li>Toggle flashlight on/off for scanning in dark environments</li>
    <li>Switch between front and back camera easily</li>
    <li>Clean, user-friendly interface</li>
  </ul>

<h2>🚀 Getting Started</h2>
  <ol>
    <li>Make sure you have <strong>Flutter SDK</strong> installed. You can download it from <a href="https://flutter.dev/">flutter.dev</a>.</li>
    <li>Clone this repository:
      <pre><code>git clone https://github.com/yourusername/qr_scanner_flutter.git</code></pre>
    </li>
    <li>Navigate into the project folder:
      <pre><code>cd qr_scanner_flutter</code></pre>
    </li>
    <li>Install dependencies:
      <pre><code>flutter pub get</code></pre>
    </li>
    <li>Run the app on your device or emulator:
      <pre><code>flutter run</code></pre>
    </li>
  </ol>

<h2>🛠️ Dependencies Used</h2>
  <ul>
    <li><code>mobile_scanner</code> – For scanning QR codes with the camera</li>
    <li><code>url_launcher</code> – To open scanned URLs in an external browser</li>
  </ul>

<h2>📸 How It Works</h2>
  <ol>
    <li>Open the app; the camera view will appear automatically.</li>
    <li>Point the camera at a QR code to scan it.</li>
    <li>The scanned text or URL is displayed below the camera preview.</li>
    <li>If it’s a URL, you can:
      <ul>
        <li>Tap "Open Link" to launch it in your default browser</li>
        <li>Tap "Copy" to copy the text to your clipboard</li>
      </ul>
    </li>
    <li>You can also scan another QR code by pressing "Scan Again."</li>
  </ol>

<h2>📂 Project Structure</h2>
  <ul>
    <li><code>main.dart</code> – Contains the entire app including the UI and scanning logic</li>
  </ul>

<h2>💡 Note</h2>
<p>
Make sure you grant camera permissions to the app when prompted, or the scanner will not function.
</p>

<hr>
<p>Created with ❤️ using Flutter.</p>