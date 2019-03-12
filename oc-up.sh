#!/bin/bash


# resolve links - $0 may be a softlink
PRG="$0"
RETCODE=0

mkdir -p assets

while [ -h "$PRG" ]; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`/"$link"
    fi
done

# Get standard environment variables
PRGDIR=`dirname "$PRG"`

readonly openshift_release=`cat Vagrantfile | grep '^OPENSHIFT_RELEASE' | awk -F'=' '{print $2}' | sed 's/^[[:blank:]\"]*//;s/[[:blank:]\"]*$//'`

. "$PRGDIR/common.sh"


vagrant up

vagrant provision --provision-with master-key,node01-key,node02-key

vagrant provision --provision-with tower-key,master-key,node01-key,node02-key

vagrant ssh master -c 'ansible-playbook -f 20 /home/vagrant/openshift-ansible/playbooks/prerequisites.yml'

vagrant ssh master -c 'ansible-playbook -f 20  /home/vagrant/openshift-ansible/playbooks/deploy_cluster.yml'

vagrant ssh master -c 'sudo bash /vagrant/master.sh'

vagrant ssh node01 -c 'sudo bash /vagrant/node.sh'

vagrant ssh node02 -c 'sudo bash /vagrant/node.sh'

vagrant ssh master -c 'oc create -f /vagrant/assets/'
