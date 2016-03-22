FROM selenium/node-chrome-debug

RUN echo "deb http://us.archive.ubuntu.com/ubuntu wily main universe" | tee -a /etc/apt/sources.list

WORKDIR /usr/src/app
RUN apt-get update
RUN apt-get install -y --force-yes libc6=2.21-0ubuntu4 libc-dev g++ dpkg-dev netbase rename bzip2 \
  perl-base=5.20.2-6
RUN apt-get install -y git build-essential

# Dependencies to make "headless" chrome/selenium work:
RUN apt-get install -y xvfb

# # Install Erlang
RUN apt-get install -y libwxbase3.0-0 libwxgtk3.0-0
RUN wget http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_1_general/esl-erlang_18.2-1~ubuntu~wily_amd64.deb
RUN dpkg -i esl-erlang_18*
RUN apt-get update
RUN apt-get install -y esl-erlang

#RUN apt-get install -y elixir=1.2.0
RUN apt-get install -y git
RUN git clone https://github.com/elixir-lang/elixir.git
RUN cd elixir && git checkout v1.2.3
RUN cd elixir && make && make install

RUN apt-get install -y vim

RUN mix local.hex --force
RUN mix local.rebar --force
COPY mix.exs .
COPY mix.lock .
COPY lib/ lib/
COPY config/ config/
RUN mix deps.get --force
RUN mix deps.compile --force
RUN mix compile --force

CMD Xvfb -ac :99 -screen 0 1280x1024x16 & export DISPLAY=:99 \
  & mix run --no-halt
