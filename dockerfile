# Usa imagem leve do Debian com Python 3.13.5
FROM python:3.13.5-slim

# Evita interações durante o build
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_CACHE_DIR=yes \
    PYTHONUNBUFFERED=1

# Instala dependências básicas e Chrome + Chromedriver
RUN apt-get update && apt-get install -y --no-install-recommends \
    firefox-esr \
    curl \
    bash \
    unzip \
    gnupg \
    wget \
    libgbm1 \
    libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1 \
    libxss1 \
    libasound2 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxrandr2 \
    libgtk-3-0 \
    fonts-liberation \
    libappindicator3-1 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Instalar GeckoDriver (última versão estável)
RUN GECKODRIVER_VERSION=$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest | grep tag_name | cut -d '"' -f4) && \
    curl -sSL "https://github.com/mozilla/geckodriver/releases/download/${GECKODRIVER_VERSION}/geckodriver-${GECKODRIVER_VERSION}-linux64.tar.gz" -o /tmp/geckodriver.tar.gz && \
    tar -xzf /tmp/geckodriver.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/geckodriver && \
    rm /tmp/geckodriver.tar.gz

# Instalar Google Chrome 
# RUN CHROME_VERSION=137.0.7151.119 && \
#     curl -sSL "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/${CHROME_VERSION}/linux64/chrome-linux64.zip" -o /tmp/chrome.zip && \
#     unzip /tmp/chrome.zip -d /opt && \
#     ln -s /opt/chrome-linux64/chrome /usr/bin/google-chrome && \
#     rm /tmp/chrome.zip

# # Instalar ChromeDriver
# RUN CHROMEDRIVER_VERSION=137.0.7151.119 && \
#     curl -sSL "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/${CHROMEDRIVER_VERSION}/linux64/chromedriver-linux64.zip" -o /tmp/chromedriver.zip && \
#     unzip /tmp/chromedriver.zip -d /opt && \
#     mv /opt/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver && \
#     chmod +x /usr/local/bin/chromedriver && \
#     rm -rf /tmp/chromedriver.zip

# Instala Robot Framework e libs
RUN pip install --upgrade pip && \
    pip install \
        robotframework \
        robotframework-seleniumlibrary \
        robotframework-metrics==3.7.0 \
        robotframework-databaselibrary \
        pymysql \
        -U robotframework-pabot

# Define diretório de trabalho
WORKDIR /usr/src/app

#COPY . /usr/src/app

#ENTRYPOINT ["pabot"]

#CMD ["--testlevelsplit","--processes 3","--outputdir", "results/", "tests/"]