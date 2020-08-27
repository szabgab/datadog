from datadog import initialize, statsd
import random
import time

# pip install datadog
# datatog.py would create a circular import
options = {
    'statsd_host':'127.0.0.1',
    'statsd_port':8125
}

initialize(**options)

start = time.time()
print(start)

while start + 60 >= time.time():
    sleep = random.random()
    print(f"sleep: {sleep}")
    statsd.gauge('python_demo.random', random.random())
    statsd.increment('python_demo.hit')
    time.sleep(sleep)

