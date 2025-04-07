# Description

This project eases http logs parsing with the great [GoAccess](https://goaccess.io/) tool.

It is compound of:

  - A python script to massage arguments and invoke goaccess
  - A Dockerfile to package all dependencies together
  - A wrapper script (bash) to run via docker

It supports declaring custom log formats. See [log-formats.yaml](./log-formats.yaml).

## Run via docker

```
./logs-parser /path/to/logfile combined
```

## Run python script directly

Ensure dependencies are installed.

For Debian/Ubuntu:

```
apt-get install pipx docker-buildx-plugin
pipx install pipenv
```

```
pipenv install --deploy
pipenv run src/main.py --log-file=/path/to/logfile --log-format=acquia --report-file=reports/report.html
```
