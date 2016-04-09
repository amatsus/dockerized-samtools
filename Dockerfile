FROM docker.io/centos:7
MAINTAINER Akihiro Matsushima <amatsusbit@gmail.com>

RUN yum -y update && \
    yum -y install bzip2 gcc make ncurses-devel zlib-devel && \
    bash -c "tar jxf <(curl -L https://github.com/samtools/samtools/releases/download/1.3/samtools-1.3.tar.bz2) -C /tmp" && \
    cd /tmp/samtools-1.3 && \
    ./configure --prefix=/opt/samtools-1.3_centos7 && \
    make && make install && \
    rm -rf /tmp/samtools-1.3 && \
    curl -Lo /usr/local/bin/run_wrapper.py \
        https://raw.githubusercontent.com/gifford-lab/docker_signal_wrapper/master/run_wrapper.py && \
    chmod +x /usr/local/bin/run_wrapper.py

ENTRYPOINT [ "/usr/local/bin/run_wrapper.py", "/opt/samtools-1.3_centos7/bin/samtools" ]
CMD ["--help"]
