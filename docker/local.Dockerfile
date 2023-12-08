# To build the docker image the first time:
# docker build --platform linux/x86_64 . -t mrfast:latest
#
# To run mrfast with the current directory accessible from within a transient container:
# docker run --platform linux/x86_64 --rm --mount=type=bind,source=.,target=/home mrfast

FROM ubuntu:16.04
RUN apt-get update -y --fix-missing
RUN apt-get install make gcc zlib1g-dev -y
RUN --mount=type=bind,source=.,target=/mrfast_source \
	mkdir -p /mrfast /home && \
	cp -rfp /mrfast_source/* /mrfast/ && \
	cd /mrfast && \
	rm -rf .git && \
	make
WORKDIR /home
ENV PATH="/mrfast:${PATH}"
ENTRYPOINT ["/mrfast/mrfast"]
