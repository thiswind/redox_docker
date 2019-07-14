FROM rustlang/rust:nightly

ENV IMAGE_NAME=redox-os-docker

# Change apt-source to TUNA
RUN set -ex; \
	apt-get update \
	&& apt-get install apt-transport-https \
	&& sed -i s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g /etc/apt/sources.list \
	&& sed -i s/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g /etc/apt/sources.list

RUN set -ex; \
	apt-get update; \
	apt-get install -q -y --no-install-recommends \
		apt-transport-https \
		bison \
		flex \
		fuse \
		gosu \
		libfuse-dev \
		nasm \
		qemu-utils \
		sudo \
		texinfo \
		autopoint \
		git \
		cmake \
		gperf \
		libhtml-parser-perl \
		vim


# change cargo source to LUG of USTC
RUN mkdir .cargo; \
echo \
"[source.crates-io]\n\
registry = \"https://github.com/rust-lang/crates.io-index\"\n\
replace-with = 'ustc'\n\
[source.ustc]\n\
registry = \"git://mirrors.ustc.edu.cn/crates.io-index\"\n" > .cargo/config

RUN cargo install xargo; \
	cargo install cargo-config; \
	apt-get autoremove -q -y; \
	apt-get clean -q -y; \
	rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/
COPY .bash_aliases /etc/skel/

# pre-install build/run dependences, in order to save net traffic
RUN apt-get update && apt-get install -q -y \
	build-essential \
	libc6-dev-i386 \
	nasm \
	curl \
	file \
	git \
	libfuse-dev \
	fuse \
	pkg-config \
	cmake \
	autopoint \
	autoconf \
	libtool \
	m4 \
	syslinux-utils \
	genisoimage \
	flex \
	bison \
	gperf \
	libpng-dev \
	libhtml-parser-perl \
	texinfo \
	qemu-system-x86 \
	qemu-kvm

# change time zone to China
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo 'Asia/Shanghai' >/etc/timezone

# set source to buster, install glibc:2.25+, the set back to stretch
RUN sed -i s/stretch/buster/g /etc/apt/sources.list \
		&& apt-get update \
		&& apt-get install -q -y libc6; \
	sed -i s/buster/stretch/g /etc/apt/sources.list \
		&& apt-get update

ENTRYPOINT ["bash", "/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]

