# WAGO PFC-Firmware-SDK

This container is the installation of this [wago/prc-firmware-sdk](https://github.com/wago/prc-firmware-sdk) repository.

## Getting Started

These instructions will cover usage information and for the docker container.

### Prerequisities

In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

### Usage

#### Container Parameters

The image could be created and started by the following command.  

```shell
docker run -d bkhenloo/wago-pfc-sdk
```

By default the working directory should be mounted. 

```shell
docker run -d -v <path>:/home/wago:rw bkhenloo/wago-pfc-sdk
```

#### Environment Variables

#### Volumes

* `/home/wago` - WAGO PFC-Firmware-SDK working directory

#### Useful File Locations

* `/home/wago/ptxproj` 						- PFC Firmware
  * `./configs/wago-pfcXXX/ptxconfig_generic`	- PFC Firmware device selection
  * `./configs/wago-pfcXXX/platformconfig`		- PFC Firmware platform configuration
* `/opt/gcc-Toolchain-2019.12`				- Cross-Compiler Toolchain


## Find Us

* [GitHub](https://github.com/BKhenloo/wago-pfc-sdk)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the 
[tags on this repository](https://github.com/BKhenloo/holdingnuts_server/tags). 

## Authors

* **Briezh Khenloo** - *Initial work* - [B.Khenloo](https://github.com/BKhenloo)

See also the list of [contributors](https://github.com/BKhenloo/holdingnuts_server/contributors) who 
participated in this project.

## License

## Acknowledgments
