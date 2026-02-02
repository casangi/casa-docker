# FROM python:3.12-slim

# USER root
# RUN apt-get update && apt-get install -y --no-install-recommends \
#       build-essential \
#       screen \
#     && apt-get clean && rm -rf /var/lib/apt/lists/*

# RUN groupadd -r radpsuser && useradd -r -g radpsuser radpsuser
# RUN mkdir -p /home/radpsuser
# RUN chown -R radpsuser:radpsuser /home/radpsuser
# USER radpsuser
# RUN mkdir -p /home/radpsuser/.casa/data
# COPY requirements.txt /tmp/requirements.txt
# RUN pip install --no-cache-dir -r /tmp/requirements.txt

FROM python:3.12-slim

# System packages
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      screen \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create user with existing GID 100 (do NOT recreate the group)
RUN useradd \
      -u 1000 \
      -g 100 \
      -m \
      -d /home/jovyan \
      -s /bin/bash \
      jovyan

# CASA requires this directory
RUN mkdir -p /home/jovyan/.casa/data \
 && chown -R 1000:100 /home/jovyan

# Environment
ENV HOME=/home/jovyan
ENV PATH="/home/jovyan/.local/bin:${PATH}"

# Python requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Drop privileges
USER 1000:100
WORKDIR /home/jovyan


