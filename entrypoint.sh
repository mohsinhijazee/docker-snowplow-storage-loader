#!/usr/bin/env bash

envtpl < /etc/snowplow/config.yml.tpl > /etc/snowplow/config.yml
/bin/bash -l -c "bundle exec bin/snowplow-storage-loader --config /etc/snowplow/config.yml --skip analyze"
