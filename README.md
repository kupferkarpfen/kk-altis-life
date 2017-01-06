# kk-altis-life
J4FG Altis Life public server &amp; clientfiles

# General stuff

This repository contains all client and server-side scripts that power the J4FG Altis Life server. Due to copyright reasons this repository does not contain any skins, images or sounds. This repository will not be used for development and gets updated from time to time, when a new version matured.

# Prerequisites

You require a recent ArmA dedicated server, MariaDB and extDB3. Additionally it is recommended to have a headless client to perform the database queries.

# Setup

- Import the schema.sql into your database to setup all required tables
- Import the seed.sql into your database to seed the basic configuration tables
- Provide the AltisLife.ini to extDB
- Create pbo's from the client and server files and place them at the appropiate locations
- Launch the server :)
