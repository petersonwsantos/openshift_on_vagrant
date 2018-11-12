Vagrant.configure(2) do |config|
	config.vm.define "openshift-box" do |openshift|
		openshift.vm.box = "centos/7"
    	openshift.vm.network "private_network", ip: "192.168.199.9"
		openshift.vm.network "forwarded_port", guest: 8443, host: 8443
		openshift.vm.hostname = "openshift.corp"
		openshift.hostsupdater.aliases = [ "console.openshift.corp", "hawkular-metrics.apps.openshift.corp","app1-test.apps.openshift.corp","app2-test.apps.openshift.corp","app3-test.apps.openshift.corp","app4-test.apps.openshift.corp","jenkins-test.apps.openshift.corp"]
		openshift.vm.provision "shell", path: "install-openshift.sh"
		openshift.vm.provider "virtualbox" do |v|
    		 v.memory = 10000
    		 v.cpus = 3
    	end
	end
end
