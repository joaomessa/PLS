# Usa a imagem oficial do Shiny como base
FROM rocker/shiny:latest

# Instala dependências do sistema Linux necessárias para pacotes como fs, bslib e plotly
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    zlib1g-dev \
    libuv1-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala os pacotes R utilizados no painel
RUN R -e "install.packages(c('bslib', 'plotly', 'ggplot2'), repos='https://cloud.r-project.org/')"

# Limpa a página de boas-vindas padrão do Shiny e copia o seu app.R para o servidor
RUN rm -rf /srv/shiny-server/*
COPY app.R /srv/shiny-server/

# A imagem rocker/shiny exige a exposição da porta 3838
EXPOSE 3838

# Garante que o usuário do servidor tenha permissão para ler o arquivo
RUN chown -R shiny:shiny /srv/shiny-server

# Inicia o servidor do Shiny
CMD ["/usr/bin/shiny-server"]