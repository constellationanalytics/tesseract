# ------------------------------------------------------------------------------
# Base image
# From debian:buster
# --
FROM debian:buster as base

RUN set -eux && apt-get -y update && apt-get -y install \
    wget \
    curl \
		build-essential \
		automake \
		ca-certificates \
		g++ \
		git \
		gcc \
		libc6-dev \
		make \
		pkg-config \
		libtool \
    libleptonica-dev && \
    apt-get -y autoremove --purge && apt-get -y clean && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1  https://github.com/tesseract-ocr/tesseract.git && \
	cd tesseract && \
	./autogen.sh && \
	./configure && \
	make  && \
	make install  && \
	ldconfig && \
	cd .. && \
	rm -rf tesseract

RUN wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.23.1
RUN wget  -O  /usr/local/share/tessdata/eng.traineddata "https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata"
ENTRYPOINT ["/bin/sh", "-c"]
