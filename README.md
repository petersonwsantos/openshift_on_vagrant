# OpenShift Vagrant


## OpenShift Origin Version Support

Currently this project pre-configured and support 3 major versions of the OpenShift Origin, which are

- [OpenShift Origin 3.10 (default)](https://github.com/openshift/origin/releases/tag/v3.10.0)
- [OpenShift Origin 3.9](https://github.com/openshift/origin/releases/tag/v3.9.0)
- [OpenShift Origin 3.7](https://github.com/openshift/origin/releases/tag/v3.7.2)
- [OpenShift Origin 3.6](https://github.com/openshift/origin/releases/tag/v3.6.1)

But, it's very easy to customize the respected ansible hosts file in order to support other incoming major versions.

The `Vagrantfile` uses Origin `3.10` and openshift-ansible `release-3.10` branch by default. Feel free to adjust your versions by updating the following 2 variables in Vagrantfile:

1. `OPENSHIFT_RELEASE`
2. `OPENSHIFT_ANSIBLE_BRANCH`

The following table lists the corresponding version relationships between Origin and openshift-ansible:

| OpenShift Origin version | openshift-ansible branch |
| --- | --- |
| 3.10.x | release-3.10 |
| 3.9.x | release-3.9 |
| 3.7.x | release-3.7 |
| 3.6.x | release-3.6 |


### `oc-up.sh`

The above 3 steps have been grouped together as one script for you. To bring your cluster up, just use the following command:

```bash
$ vagrant plugin install vagrant-hostmanager
$ ./oc-up.sh
```

### Open Web Console

In browser of your host, open the following page: https://master.example.com:8443/ and you should see OpenShift Web Console login page. The default login account is **admin/handhand**
