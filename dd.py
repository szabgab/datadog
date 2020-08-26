from datadog import initialize, statsd
import random

# pip install datadog
# datatog.py would create a circular import
options = {
    'statsd_host':'127.0.0.1',
    'statsd_port':8125
}

initialize(**options)

statsd.gauge('python_demo.random', random.random())

