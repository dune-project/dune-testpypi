FROM ubuntu:latest

RUN apt update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install -yq g++ cmake python3 python3-pip python3-venv pkg-config libopenmpi-dev > /dev/null

RUN pip install dune-geometry
