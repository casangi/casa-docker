FROM daskdev/dask:2025.7.0-py3.12

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

USER $NB_USER