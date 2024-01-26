## Rakshak (रक्षक)

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