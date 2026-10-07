FROM rocker/r-ver:4.3.2

# Instalar dependências de sistema do Linux para C/C++ (httpuv, sodium, plumber)
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev \
    zlib1g-dev \
    libsodium-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Instalar o pacote plumber
RUN R -e "install.packages('plumber', repos='https://cloud.r-project.org/')"

WORKDIR /app
COPY . /app

EXPOSE 8080

CMD ["Rscript", "entrypoint.R"]