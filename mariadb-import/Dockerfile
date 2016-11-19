FROM mariadb
RUN ["sed", "-i", "-e", "s/exec \"$@\"//", "--follow-symlinks", "docker-entrypoint.sh"]
