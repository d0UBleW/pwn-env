FROM ubuntu:20.04

ENV LANG en_US.utf8
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING UTF-8
ENV TZ Asia/Kuala_Lumpur

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qq \
    git \
    vim \
    tmux \
    python3 \
    python3-pip \
    locales && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

WORKDIR /pwn

RUN pip install pwntools

RUN git clone https://github.com/pwndbg/pwndbg && \
    cd pwndbg && \
    DEBIAN_FRONTEND=noninteractive ./setup.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq \
    ipython3

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq \
    curl \
    wget

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq \
    strace \
    ltrace

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq \
    libreadline-dev \
    libgmp-dev

RUN wget "https://github.com/io12/pwninit/releases/download/3.3.0/pwninit" \
    -O /usr/local/bin/pwninit && \
    chmod +x "/usr/local/bin/pwninit"

RUN wget "https://github.com/NixOS/patchelf/releases/download/0.17.0/patchelf-0.17.0-x86_64.tar.gz" \
    -O /tmp/patchelf.tar.gz && \
    mkdir /tmp/patchelf && \
    tar xzvf /tmp/patchelf.tar.gz --directory=/tmp/patchelf && \
    cp /tmp/patchelf/bin/patchelf /usr/local/bin/patchelf && \
    cp /tmp/patchelf/share/man/man1/patchelf.1 /usr/share/man/man1/patchelf.1 && \
    rm -rf /tmp/patchelf/ /tmp/patchelf.tar.gz

# ADD ./gdb-11.2.tar.gz /opt
#
# RUN cd /opt/gdb-11.2 && mkdir build && cd build && \
#     ../configure --with-system-readline --with-python=/usr/bin/python3 && \
#     make && make install

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq \
    gcc-multilib

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq \
    ipython3

RUN git clone https://github.com/jerdna-regeiz/splitmind /opt/splitmind

COPY ./splitmind.rc /tmp/splitmind.rc

RUN cat /tmp/splitmind.rc >> /root/.gdbinit && \
    rm /tmp/splitmind.rc

RUN groupadd -g 1000 pwn && \
    useradd -m -r -u 1000 -g pwn pwn

RUN cp /root/.gdbinit /home/pwn/.gdbinit

COPY ./gdb-ex /usr/local/bin/gdb-ex

USER pwn

COPY tmux.conf /home/pwn/.tmux.conf
COPY inputrc /home/pwn/.inputrc

ENV TERM=xterm-256color

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["/usr/bin/tmux"]
