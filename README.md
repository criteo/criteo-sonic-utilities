# Criteo SONiC utilities

This repository contains scripts and patches required to run our [SONiC Saltstack modules](https://github.com/criteo/sonic-saltstack).

We aim to merge thes patches / utilities with the official repositories at some point.

## Supported versions

- 201911
- 202205

## SONiC patches

Location: [sonic-patches](sonic-patches)

It contains SONiC build image patches required to fully benefit from our Salt modules.

### FRR mounted configuration

**This patch has been merged upstream (see our commit [here](https://github.com/sonic-net/sonic-buildimage/commit/9d3814045bf950576bb274180ffec001abac1c32)).**

You only need to apply it manually if you are running a SONiC release which does not have the "split-unified" feature (SONiC < 202205).

<details>
This patch is about mounting FRR directory in the container, basically `-v /etc/frr/:/etc/sonic/frr/`.

This is required if you want to manage BGP configuration with our Salt modules.

Be careful, this patch changes the way the BGP configuration is provisioned. By default, SONiC computes the configuration from variables in the config_db.json and embedded template in the container. Meaning, any changes via VTYSH are not persistent.

There are two ways to apply it:
- build and install your own SONiC image with our patch (recommended)
- apply the patch in live on your devices:
  - ensure the docker is started with `-v /etc/sonic/frr:/etc/frr:rw` in `/usr/bin/bgp.sh)`
  - copy your FRR config on SONiC in `/etc/sonic/frr`
  - and restart the BGP container (be careful not to break your production!)
</details>

## Utilities

Location: [utilities](utilities)

Important note: this script is inspired or derived from official SONiC scripts ([SONiC utilities](https://github.com/sonic-net/sonic-utilities)).

It contains some custom tools we use in our Salt modules. These are either patches of existing scripts (to add JSON support for instance), or custom scripts to get more info at once.

You just need to install them on the devices in `/opt/salt/scripts/` directory. You can use a [Salt state](utilities/install.sls) to do that (or a simple scp).
