# Build environment
FROM alpine AS build
RUN apk add --no-cache build-base git && \
    cd /src && \
    git clone https://github.com/emikulic/darkhttpd.git && \
    make darkhttpd-static && \
    strip darkhttpd-static

# Just the static binary
FROM scratch
WORKDIR /www
COPY --from=build /src/darkhttpd/darkhttpd-static /darkhttpd
EXPOSE 80
ENTRYPOINT ["/darkhttpd"]
CMD ["."]

