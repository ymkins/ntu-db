
      *** Sample project for LAB_2 ***

=============================================

## Usage

This project uses Docker to run the PostgreSQL database, to avoid installing
a bunch of packages on your machine and potentially running into different
platform and environment issues.

   to run the container use: ./_create.sh
   to run psql utility use: ./_psql.sh

=============================================

psql commands:

Listing databases:    \l
Switching Databases:  \c database
Listing Tables:       \dt
Quit:                 \q
Execute query:        \i /repo/sample_query_1.sql
List of roles:        \du

=============================================

INSERT INTO artists (name) VALUES ('DJ Okawari'), ('Steely Dan'), ('Missy Elliott');

INSERT INTO albums (artist_id, title, released) VALUES (3, 'Under Construction', '2002-11-12');
