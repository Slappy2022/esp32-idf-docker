FROM debian:bullseye

RUN apt-get update && \
  apt-get install -y \
  git curl gcc clang ninja-build cmake libudev-dev unzip xz-utils \
  python3 python3-pip python3-venv libusb-1.0-0 libssl-dev pkg-config libpython2.7

RUN curl https://sh.rustup.rs -sSf | bash -s -- \
  --default-toolchain stable --profile minimal -y

ENV PATH="$PATH:/root/.cargo/bin"
RUN cargo install espup
RUN cargo install ldproxy
RUN espup install

RUN cargo install cargo-espflash
WORKDIR /
RUN git clone https://github.com/esp-rs/esp-idf-hal
WORKDIR esp-idf-hal
RUN sed -i 's/gpio4/gpio2/g' examples/blinky.rs

RUN . /root/export-esp.sh && cargo +esp build --release --target xtensa-esp32-espidf --example blinky -vv

CMD . /root/export-esp.sh && cargo +esp espflash --release --target xtensa-esp32-espidf --example blinky --monitor /dev/ttyUSB0 
