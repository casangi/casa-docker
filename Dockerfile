FROM python:3.12-slim

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      screen \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN groupadd -r radpsuser && useradd -r -g radpsuser radpsuser
RUN mkdir -p /home/radpsuser
RUN chown -R radpsuser:radpsuser /home/radpsuser
USER radpsuser
RUN mkdir -p /home/radpsuser/.casa/data
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

