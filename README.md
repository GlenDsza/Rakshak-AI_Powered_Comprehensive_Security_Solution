<img align="left" style="margin-top:25px" width="60" height="60" src="Assets/logo.png">

## Rakshak (रक्षक): AI Powered Comprehensive Security Solution

<p style='text-align: justify;'>Rakshak is an AI powered Comprehensive Security Solution which provides Web Interface platform for Security personels, Mobile App (Multi-lingual, Dual Mode) for On Duty guards and Citizens to administer, report and enhance overall security.</p>
<p style='text-align: justify;'>Rakshak integrates various Machine Learning & Deep Learning based models to detect & identify various types of crimes/accidents via CCTV streams.</p>

## Problem Definition✨

- <p style='text-align: justify;'>Security personnel (Police)👮🏻‍♂️ are burdened with manually monitoring multiple CCTV streams, leading to potential security incidents.</p>
- <p style='text-align: justify;'>👀Manual surveillance not only consumes manpower but also increases the risk of human error and security breaches.</p>
- <p style='text-align: justify;'>On-duty personnel struggle to maintain real-time communication with authorities analyzing CCTV footage for incident detection.</p>
- <p style='text-align: justify;'>The lack of a user-friendly platform for incident reporting by citizens contributes to delays in emergency response protocols.</p>

## Scope & Features 💡

Rakshak consists of Web Interface for Admins, Mobile App Module for On-Duty personnels, Mobile App for Citizens.

### 🖥️<u>Web Interface for Admins</u>:

- <p style='text-align: justify;'> Admin for particular police Station can access <b><u>dashboard containing stats</u></b>📊📈 of various detected/reported incidents.</p>
- <p style='text-align: justify;'>View CCTV streams for specific location via <b><u>Interactive map</u>🗺️</b>.</p>
- <p style='text-align: justify;'>View Real-time incident detections (accidents/crime) detected in CCTV streams.</p>
- <p style='text-align: justify;'><b><u>Automated Alerts & notifications</b></u>🔔 about detected incidents & plot details such as description, type, location on 🗺️</p>
- <p style='text-align: justify;'>Admin has access to <b><u>LLM powered interface</u>🤖</b> to query in natural language about incidents and gain insights.</p>
- <p style='text-align: justify;'>Provides an interface for <b><u>Feedback Learning</b></u>🧠 which enables to train model via admins feedback about <b><u>False Positives & False Negatives</b></u>.</p>
- <p style='text-align: justify;'>View Info & Status of all on-duty personnels.</p>

### 👮🏻‍♂️<u>Mobile App for On-Duty personnels</u>:

- <p style='text-align: justify;'> <b><u>Report Incidents</b></u> in vicinity by providing basic info such as type description and visual evidence.🏞️</p>
- <p style='text-align: justify;'> Get notified about the status of reported Incident.</p>

### 👩‍👩‍👧‍👦<u>Mobile App for Citizens</u>:

- <p style='text-align: justify;'> Mobile App provides <b><u>Automated Alerts & Notifications about incidents</b></u>🔔 in vicinty. View details about incidents 📍 plotted on map🗺️</p>
- <p style='text-align: justify;'> Access to CCTV streams of specific location via user-friendly map.</p>

## Video Demo ▶️

[![Youtube Video Demo](Assets/logo.png)](https://youtu.be/zETnd8Bkduo?si=qMlMdoFPos6wUcwV)

## Tech Stack 👨‍💻

- React, Typescript & FAST API (Web Interface)
- Flutter, Dart, BLOC for State Management
- MongoDB, AWS S3 (For Storage)
- Mapbox API, Google Maps SDK
- TensorFlow, YOLO, PyTorch (Machine Learning)
- Mixtral 8x7B Open source LLM

## Start Mobile App

Flutter SDK version requirement : `>=2.12.0 < 3.0.0`

```bash
cd App
flutter pub get
flutter run
```

## Start frontend

```bash
cd Frontend
npm install
npm run dev
```

## Start backend

```bash
cd Backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload --port=5000
```

### Start video streaming server

```bash
cd video-server
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python video_server.py
```
