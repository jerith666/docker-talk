FROM scratch

# a simple container that spawns a socat listener on port 1234,
# which prints a message of the day and then disconnects.

# produce the statically-linked 'socat' binary with:
# nix-build socat-static.nix -o socat-static; cp -v socat-static/bin/socat socat
COPY socat /socat

COPY message-of-the-day.txt /

# run with:
# docker run --interactive --tty --rm --publish 1234:1234 <image id>
ENTRYPOINT [ "/socat", "TCP-LISTEN:1234,fork", "OPEN:/message-of-the-day.txt,ignoreeof" ]
