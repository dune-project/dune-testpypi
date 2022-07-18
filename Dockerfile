FROM ubuntu:latest

RUN apt update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install -y libopenmpi-dev

RUN pip install dune-geometry
