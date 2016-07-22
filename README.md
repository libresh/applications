# IndieHosters applications

What is an application for IndieHosters?
It is a repo that must contain the following:
 - `docker-compose.yml`
 - an optionnal `scripts` folder with:
  - an `install` script
  - a `pre-backup` script to do databases dump for instance

## Docker-compose

The `docker-compose` must start a service called `web` that exposes a port 80.
Under the `web` service, it should have the `environment` variable ready to be populated:

```
...
  environment:
    - HOST
...
```

## Dockerfile

The docker-compose should use Docker official images.
If none are available, then make one, and try to pull request upstream and offer help to make it official.
If you need more than the bare image, base your Dockerfile on the official one, and try to pull request the official one. Other people might need your work.

## Environment

### Mail

If the application needs to send email pass the mail server configuration as environment variables:
```
MAIL_HOST
MAIL_PORT
MAIL_USER
MAIL_PASS
```

Your app should be able to understand them.

## Example

A good example is the [wordpress application](https://github.com/indiehosters/wordpress).
