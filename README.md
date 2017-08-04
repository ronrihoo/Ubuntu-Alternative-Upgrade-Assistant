# Ubuntu Alternative Upgrade Assistant

For cases when Ubuntu fails to upgrade to a newer release, such as, currently, from Vivid (15.04) to Wily (15.10).

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


## Contributing

All pull requests are welcome.
