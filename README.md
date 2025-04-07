# Description

...

# Reports generator

## Installation

Ensure dependencies are installed.

For Debian/Ubuntu:

```
apt-get install pipx docker-buildx-plugin
pipx install pipenv
```

## Run local

```
pipenv install --deploy
pipenv run src/main.py --log-file=/path/to/logfile --log-format=acquia --report-file=reports/report.html
```

## Run via docker

```
./logs-parser /path/to/logfile combined
```
