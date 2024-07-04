FROM debian

RUN mkdir /var/app; mkdir /var/app/nobg

WORKDIR /var/app

RUN apt-get update; apt-get install -y make git zlib1g-dev libssl-dev gperf cmake clang libc++-dev libc++abi-dev 

RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git

WORKDIR /var/app/telegram-bot-api

RUN rm -rf build

RUN mkdir build

WORKDIR /var/app/telegram-bot-api/build

RUN CXXFLAGS="-stdlib=libc++" CC=/usr/bin/clang CXX=/usr/bin/clang++ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..

RUN cmake --build . --target install

WORKDIR /var/app

ENTRYPOINT ["telegram-bot-api"]