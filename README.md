# NOTICE

I was requested by the owners of 360radar.co.uk to take this down.

Accordingly, I've removed from docker hub but will leave the container source code here in case anyone feeding 360radar would like to build the container themselves.

# mikenye/360radar

[360Radar.co.uk](https://360radar.co.uk) is a browser-based aircraft tracking system designed to track all ADSB-equipped aircraft stretching across most of England, Wales and Scotland as well as Ireland.

This docker container will feed ADSB data into [360Radar](https://360radar.co.uk). Designed to work in tandem with [mikenye/readsb](https://github.com/mikenye/docker-readsb) or another BEAST provider. Builds and runs on x86_64, arm32v6, arm32v7 & arm64v8 (see below).

The container pulls ADS-B information from the [mikenye/readsb](https://github.com/mikenye/docker-readsb) container (or another host providing data in BEAST format) and feeds data to 360radar via `mlat-client`.

For more information on feeding 360radar, see here: [LFW Starting from Scratch](https://radar.lowflyingwales.co.uk). This container uses a modified version of the [Raspberry Pi installation instructions](https://radar.lowflyingwales.co.uk/raspberry-pi-installation-instructions/).

## Multi Architecture Support

Currently, this image should pull and run on the following architectures:

* ```amd64```: Linux x86-64
* ```arm32v6```: ARMv6 32-bit (Pi Zero)
* ```arm32v7```, ```armv7l```: ARMv7 32-bit (Odroid HC1/HC2/XU4, RPi 2/3/4)
* ```arm64v8```, ```aarch64```: ARMv8 64-bit (RPi 4)

## Configuring `mikenye/360radar` Container

If you're using this container with the `mikenye/readsb` container to provide ModeS/BEAST data, you'll need to ensure you've opened port 30005 into the `mikenye/readsb` container, so this container can connect to it.

The IP address or hostname of the docker host running the `mikenye/readsb` container should be passed to the `mikenye/360radar` container via the `BEASTHOST` environment variable shown below. The port can be changed from the default of 30005 with the optional `BEASTPORT` environment variable if required.

The latitude and longitude of your antenna must be passed via the `LAT` and `LONG` environment variables respectively.

The altitude of your antenna must be passed via the `ANT` environment variable respectively. Defaults to metres, but units may specified with a 'ft' or 'm' suffix.

You should specify a site name via the `SITENAME` environment variable. 360radar recommend the name of your village or town plus your initials in capitals – NO spaces!

Lastly, you need to specify your `REGION` (which determines which 360radar server you will feed into). `REGION` can be set to any one of the following:

* `eire`
* `midlands`
* `northern_england`
* `northern_ireland`
* `scotland`
* `se_england`
* `sw_england`
* `wales`

## Up-and-Running with `docker run`

```shell
docker run \
 -d \
 --rm \
 --name 360radar \
 -e TZ=YOUR_TIMEZONE \
 -e BEASTHOST=beasthost \
 -e LAT=-33.33333 \
 -e LONG=111.11111 \
 -e ALT=50m \
 -e SITENAME=SwanseaMN \
 -e REGION=wales \
 mikenye/360radar
```

## Up-and-Running with Docker Compose

```json
version: '2.0'

services:
  360radar:
    image: mikenye/360radar
    tty: true
    container_name: 360radar
    restart: always
    environment:
      - BEASTHOST=beasthost
      - TZ=Australia/Perth
      - LAT=-33.33333
      - LONG=111.11111
      - ALT=50m
      - SITENAME=SwanseaMN
      - REGION=wales
```

## Up-and-Running with Docker Compose, including `mikenye/readsb`

See [Guide to ADS-B Data Reception, Decoding & Sharing with RTLSDR & Docker](https://github.com/mikenye/docker-readsb/wiki/Guide-to-ADS-B-Data-Receiving,-Decoding-and-Sharing,-Leveraging-RTLSDR-and-Docker)

## Runtime Environment Variables

There are a series of available environment variables:

| Environment Variable | Purpose                                                                  | Default |
| -------------------- | ------------------------------------------------------------------------ | ------- |
| `BEASTHOST`          | Required. IP/Hostname of a Mode-S/BEAST provider (dump1090)              |         |
| `BEASTPORT`          | Optional. TCP port number of Mode-S/BEAST provider (dump1090)            | `30005`   |
| `LAT`                | Required. The latitude of the antenna                                    |         |
| `LONG`               | Required. The longitude of the antenna                                   |         |
| `ALT`                | Required. The altitude of the antenna above sea level. If positive (above sea level), must include either 'm' or 'ft' suffix to indicate metres or feet. If negative (below sea level), must have no suffix, and the value is interpreted in metres.  |         |
| `SITENAME`           | Required. The name of your village or town plus your initials in capitals – NO spaces! |         |
| `REGION`             | Required. One of `eire`, `midlands`, `northern_england`, `northern_ireland`, `scotland`, `se_england`, `sw_england`, `wales` | |
| `TZ`                 | Optional. Your local timezone                                            | `GMT`     |

## Logging

* All processes are logged to the container's stdout, and can be viewed with `docker logs [-f] container`.

## Getting help

Please feel free to [open an issue on the project's GitHub](https://github.com/mikenye/docker-360radar/issues).

I also have a [Discord channel](https://discord.gg/sTf9uYF), feel free to [join](https://discord.gg/sTf9uYF) and converse.

## Changelog

See the [commit history](https://github.com/mikenye/docker-360radar/commits/master) on GitHub.
