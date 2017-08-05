# Ubuntu Alternative Upgrade Assistant

A last resort for upgrading Ubuntu in cases where normal procedures fail. As an example, attempting to upgrade from Vivid (15.04) to Wily (15.10) fails with regular procedures; however, this alternative Ubuntu upgrade tool carries out the upgrade successfully.

## Setup

```bash
$ chmod +x ./upgradeubuntu.sh
```

## Usage

Once having exhausted all regular upgrade options, one may try using this alternative upgrade tool. The system must restart for every upgrade.

As an example, to upgrade from Vivid (15.04) to Xenial (16.04), one must first upgrade from Vivid (15.04) to Wily (15.10), then from Wily to Xenial.

```bash
$ sudo ./upgradeubuntu.sh
```

## Qualification Check-List for Using This Alternative Tool

If all three of the following are true, then the system is qualified for upgrade with this alternative upgrade tool.

1. Late on upgrade.

   ![Image of Software Updater, on Ubuntu, stating, "Software updates are no longer provided for Ubuntu 15.04. To stay secure, you should upgrade to Ubuntu 16.04.2 LTS."](https://github.com/ronrihoo/ubuntu-alternative-upgrade-assistant/raw/master/img/Software_updates_are_no_longer_provided_for_Ubuntu_15.04.png "Software updates are no longer provided for Ubuntu 15.04")

2. Cannot normally upgrade to newer version.

   ![Image of error message, on Ubuntu, showing the error icon and stating, "Can not upgrade. An upgrade from 'vivid' to 'xenial' is not supported with this tool."](https://github.com/ronrihoo/ubuntu-alternative-upgrade-assistant/raw/master/img/An_upgrade_from_vivid_to_xenial_is_not_supported_with_this_tool.png "An upgrade from 'vivid' to 'xenial' is not supported with this tool")

3. `sudo do-release-upgrade -d` fails.


## Contributing

All pull requests are welcome.
