import datadog as dd
import random
import time

# pip install datadog
# datatog.py would create a circular import
options = {
    'statsd_host':'127.0.0.1',
    'statsd_port':8125
}

planets = ['Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', 'Saturn']

dd.initialize(**options)

start = time.time()
#print(start)

dd.statsd.gauge('python_demo.running', 1)

while start + 30 >= time.time():
    now = time.time()
    elapsed = now - start
    sleep = 3 * random.random()
    print(f"Elapsed {elapsed} sleep: {sleep}")
    time.sleep(sleep)

    dd.statsd.gauge('python_demo.random', random.random())
    dd.statsd.increment('python_demo.hit')
    planet = random.choice(planets)
    dd.statsd.set('python_demo.planet', planet)

dd.statsd.gauge('python_demo.running', 0)

