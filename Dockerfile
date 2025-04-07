FROM debian:12-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
    ca-certificates=20230311 \
    curl=7.88.* \
    gpg=2.2.* \
  ; \
  \
  curl -fsSL https://deb.goaccess.io/gnugpg.key | tee /usr/share/keyrings/goaccess.asc; \
  echo "deb [signed-by=/usr/share/keyrings/goaccess.asc] https://deb.goaccess.io/ bookworm main" | tee /etc/apt/sources.list.d/goaccess.list; \
  curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | bash; \
  \
	apt-get update; \
	apt-get install -y --no-install-recommends \
    goaccess=2:1.* \
    pipx=1.* \
	; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*

# Download geoip database.
RUN curl -fsSL https://mailfud.org/geoip-legacy/GeoIPCity.dat.gz -o /opt/GeoIPCity.dat.gz \
  && gunzip /opt/GeoIPCity.dat.gz

RUN pipx install --global pipenv

RUN addgroup goaccess && adduser --ingroup goaccess goaccess \
    && mkdir -p /app \
    && chown -R goaccess:goaccess /app

USER goaccess
WORKDIR /app

COPY Pipfile Pipfile.lock* .
RUN pipenv install --deploy --ignore-pipfile

COPY log-formats.yaml .
COPY src .

ENTRYPOINT ["pipenv", "run", "./main.py"]
