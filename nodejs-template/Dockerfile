FROM dmp

RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y supervisor curl
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs