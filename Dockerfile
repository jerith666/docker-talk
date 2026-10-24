FROM scratch

# a simple container that spawns a netcat listener on port 1234,
# which prints a message of the day and then disconnects.

COPY sh /sh

# produce the statically-linked 'nc' binary with:
# nix-build netcat-static.nix -o netcat-static; cp -v netcat-static-nc/bin/nc nc #nix-build appends the '-nc'
COPY nc /nc

COPY message-of-the-day.txt /

# run with:
# docker run --interactive --tty --rm --publish 1234:1234 <image id>
ENTRYPOINT [ "/sh", "-c", "/nc -N -l 1234 < /message-of-the-day.txt" ]
