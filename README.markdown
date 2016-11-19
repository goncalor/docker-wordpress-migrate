
This repository provides a set of scripts to ease migrating [WordPress][wordpress-org] websites into [Docker][docker-com] containers.

I encourage you to take a look at [Moving WordPress][moving-wordpress], especially if you are going to change you website's domain or URL.

Right now these scripts are mostly hardcoded. I may or may not improve that in the future.

Instructions
============

Start by exporting your WordPress database and files. See [here][export-database] and [here][wordpress-files] if you need help. Here's a reminder on how to use `mysqldump`:

    mysqldump -u username -p database_name > db_export.sql

Clone this repository. Edit the variables in `globals.sh`. Those are the names of the containers and named volumes that will be created. In there you also configure the password for the new MariaDB database.

Then run

    ./import-db.sh  /full/path/to/db_export.sql
    ./import-wp.sh  /full/path/to/wordpress-files-folder/

This will create the named volumes that will persist your WordPress files and database. It will also populate them with your data.

Take a look at the contents of `run.sh`. You may want to edit the `docker run` command for the WordPress container. Adding `-p $WP_PORT:80` to it will publish the WordPress's container port 80 to the port you define for the host. You don't need this if you use a reverse proxy container. Nonetheless, before you set up the proxy it might be a good idea to expose the port and test that the website is working by browsing `http://your-domain:8080`.

And that's about it!

But if you want to set up a reverse proxy configure `reverse-proxy/nginx.conf` and run `reverse-proxy.sh`. This allows you to set up a very simple proxy. If you need a more complex setup but don't want to figure it for yourself take a look at [jwilder/nginx-proxy][jwilder-proxy].

Also notice none of the `docker run` commands have a `--restart` policy set. When you go into production consider adding the flag [`--restart unless-stopped`][docker-restart-policy].

Contributing
============

If you like the scripts in this repository but think you can improve them (oh and they can be improved!) please submit a pull request!


[wordpress-org]: https://wordpress.org
[docker-com]: https://www.docker.com
[moving-wordpress]: https://codex.wordpress.org/Moving_WordPress
[export-database]: https://codex.wordpress.org/Backing_Up_Your_Database
[wordpress-files]: https://codex.wordpress.org/WordPress_Backups#Backing_Up_Your_WordPress_Site
[jwilder-proxy]: https://github.com/jwilder/nginx-proxy
[docker-restart-policy]: https://blog.codeship.com/ensuring-containers-are-always-running-with-dockers-restart-policy/
