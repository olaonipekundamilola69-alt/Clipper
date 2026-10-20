FROM python:3.11-slim
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg fonts-dejavu-core fonts-noto-core fontconfig \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
ENV WHISPER_MODEL=base
CMD gunicorn -b 0.0.0.0:${PORT:-5000} --workers 1 --threads 8 --timeout 900 app:app
