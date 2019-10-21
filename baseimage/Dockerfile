FROM ubuntu:18.04

# update apt and install all required packages
RUN apt-get update \
    && apt-get install -y \
		curl \
		file \
		gcc \
		g++ \
		git \
		make \
		openssh-client \
		autoconf \
		automake \
		cmake \
		libtool \
		libcurl4-openssl-dev \
		libssl-dev \
		libelf-dev \
		libdw-dev \
		binutils-dev \
		zlib1g-dev \
		libiberty-dev \
		wget \
		xz-utils \
		pkg-config \
		python \
		libpcap-dev \
		build-essential \
		yasm \
	&& apt-get clean

# Install ffmpeg related stuff
RUN mkdir -p /ffmpeg/build \
	&& mkdir -p /ffmpeg/install \
	&& cd /ffmpeg/build \
	&& wget http://ffmpeg.org/releases/ffmpeg-4.1.4.tar.xz \
	&& tar xf ffmpeg-4.1.4.tar.xz \
	&& cd ffmpeg-4.1.4 \
	&& ./configure --prefix=/ffmpeg/install \
		--disable-programs \
		--disable-doc \
		--disable-avdevice \
		--disable-postproc \
		--disable-avfilter \
		--disable-encoders \
		--disable-decoders \
		--disable-muxers \
		--disable-demuxers \
		--disable-protocols \
		--disable-devices \
		--disable-filters \
		--enable-muxer=dash \
		--enable-muxer=ismv \
		--enable-muxer=mp4 \
		--enable-muxer=mpegts \
		--enable-demuxer=dash \
		--enable-demuxer=mp4 \
		--enable-demuxer=mpegts \
		--enable-encoder=mjpeg \
		--enable-decoder=aac \
		--enable-decoder=mjpeg \
		--enable-decoder=mpeg4 \
		--enable-decoder=h264 \
		--enable-gpl --enable-version3 --enable-nonfree \
		--enable-shared --disable-static \
	&& make -j $(cat /proc/cpuinfo | grep ^processor | wc -l) \
	&& make install \
	&& rm -rf /ffmpeg/build

# install rustup
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain none --profile minimal

ENV PATH "/root/.cargo/bin:$PATH"
ENV CFG_RELEASE_CHANNEL "stable"

# install rust versions and components
ARG rust_version
RUN rustup install nightly \
	&& rustup install $rust_version \
	&& rustup default $rust_version \
	&& rustup component add clippy \
	&& rustup component add rustfmt \
	&& cargo install cargo-audit \
	&& cargo install cargo-udeps

# ld config
RUN bash -l -c 'echo $(rustc --print sysroot)/lib >> /etc/ld.so.conf' && \
	bash -l -c 'echo /usr/local/lib >> /etc/ld.so.conf' && \
	bash -l -c 'echo /ffmpeg/install/lib >> /etc/ld.so.conf' && \
	ldconfig

# set required env variable
ENV FFMPEG_INCLUDE_DIR "/ffmpeg/install/include"
ENV FFMPEG_LIB_DIR "/ffmpeg/install/lib"

# Set configs
COPY cargo.config /root/.cargo/config
RUN mkdir -p /root/.ssh \
	&& chmod 0700 /root/.ssh
COPY ssh.config /root/.ssh/config
