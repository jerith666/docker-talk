FROM scratch

# a simple container that spawns a netcat listener on port 1234,
# which prints out anything it receives to stdout and exits on disconnect

# produce the statically-linked 'nc' binary with:
# nix-build netcat-static.nix -o netcat-static; cp -v netcat-static-nc/bin/nc nc #nix-build appends the '-nc'
COPY nc /nc

# run with:
# docker run --interactive --tty --rm --publish 1234:1234 <image id>
ENTRYPOINT ["/nc", "-l", "1234"]
