FROM ubuntu:22.04

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

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq \
    gcc-multilib

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq \
    ipython3

RUN pip install ropper

RUN git clone https://github.com/jerdna-regeiz/splitmind /opt/splitmind

RUN wget -O /pwn/.gdbinit-gef.py -q https://gef.blah.cat/py

COPY ./config/splitmind-rc.py /opt
COPY ./config/splitmind-no-io-rc.py /opt

COPY ./config/gdbinit /root/.gdbinit
COPY ./config/tmux.conf /root/.tmux.conf
COPY ./config/inputrc /root/.inputrc

COPY ./bin/container/pwndbg /usr/local/bin
COPY ./bin/container/pwndbg-splitmind /usr/local/bin
COPY ./bin/container/gef /usr/local/bin
COPY ./bin/container/pwn-init /usr/local/bin
COPY ./bin/container/unstrip-libc.py /usr/local/bin

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq \
    netcat zip

RUN wget https://github.com/0vercl0k/rp/releases/download/v2.1.1/rp-lin-clang.zip -O /tmp/rp.zip && \
    unzip /tmp/rp.zip -d /usr/local/bin && rm /tmp/rp.zip && \
    mv /usr/local/bin/rp-lin /usr/local/bin/rp && \
    chmod +x /usr/local/bin/rp

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qq \
    ruby

RUN gem install one_gadget

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN $HOME/.cargo/bin/cargo install ropr

# RUN echo "deb http://th.archive.ubuntu.com/ubuntu jammy main" >> /etc/apt/sources.list
#
# RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -qq \
#     libc6
#
# RUN groupadd -g 1000 pwn && \
#     useradd -m -r -u 1000 -g pwn pwn
#
# RUN cp /root/.gdbinit /home/pwn/.gdbinit
#
# USER pwn
#
# COPY ./config/tmux.conf /home/pwn/.tmux.conf
# COPY ./config/inputrc /home/pwn/.inputrc

ENV TERM=xterm-256color

ENTRYPOINT ["/bin/bash"]

# CMD ["/usr/bin/tmux"]
