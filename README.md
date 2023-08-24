# DiverCoin

DiverCoin is a web application that allows users to calculate and track their multiple crypto investments.

## Getting started

### Ruby and Ruby on Rails versions

#### Running locally

Add the following line to your `/etc/hosts` file:

```sh
$ echo '127.0.0.1   divercoin.local divercoin-postgres divercoin-redis' | sudo tee -a /etc/hosts
```

The project supports **SSL** and the PEM and key files are expected to be located at `./ssl`.

You can use `mkcert` to easily create a certificate:

```sh
$ mkcert -cert-file ./ssl/divercoin.local.pem -key-file ./ssl/divercoin.local.key divercoin.local '*.divercoin.local'
```

If you are using `rvm`, run `rvm use --create --install` to install Ruby 3.2.2 and create the gemset. You can use `.env.example` to define the database and Redis information depending on your installation.

#### Using Docker

The project contains the `docker-compose.yml` and `Dockerfile` required to run completely dockerized. If you already have installed `docker` and `docker-compose`, run the following to bring up the containers:

```sh
$ docker compose up --force-recreate --remove-orphans
```

Once the containers are up, go to [https://divercoin.local:3000](https://divercoin.local:3000) to access the application.

#### Running specs

To run the specs locally, the database should be accessible. Use the `.env.test` file to define the required variables and simply run:

```sh
$ ./bin/rspec
```

The specs can also be run on `docker`:

```sh
$ docker compose run --rm -it ./bin/rspec
```
