## Vagrant Multiple-VM Creation and Configuration
Automatically provision multiple VMs with Vagrant and VirtualBox. Automatically install, configure, and test
Puppet Master and Puppet Agents on those VMs. All instructions can be found in my blog post:
[http://wp.me/p1RD28-1kX](http://wp.me/p1RD28-1kX)


#### JSON Configuration File
The Vagrantfile retrieves multiple VM configurations from a separate `nodes.json` file. All VM configuration is
contained in the JSON file. You can add additional VMs to the JSON file, following the existing pattern. The
Vagrantfile will loop through all nodes (VMs) in the `nodes.json` file and create the VMs. You can easily swap
configuration files for alternate environments since the Vagrantfile is designed to be generic and portable.

#### Instructions
```
vagrant up # brings up all VMs
vagrant ssh puppet.example.com

sudo service puppetmaster status # test that puppet master was installed
sudo service puppetmaster stop
sudo puppet master --verbose --no-daemonize
# Ctrl+C to kill puppet master
sudo service puppetmaster start
sudo puppet cert list --all # check for 'puppet' cert

# Shift+Ctrl+T # new tab on host
vagrant ssh node01.example.com # ssh into agent node
sudo service puppet status # test that agent was installed
sudo puppet agent --test --waitforcert=60 # initiate certificate signing request (CSR)
```
Back on the Puppet Master server (puppet.example.com)
```
sudo puppet cert list # should see 'node01.example.com' cert waiting for signature
sudo puppet cert sign --all # sign the agent node(s) cert(s)
sudo puppet cert list --all # check for signed cert(s)
```
#### Forwarding Ports
Used by Vagrant and VirtualBox. To create additional forwarding ports, add them to the 'ports' array. For example:
 ```
 "ports": [
        {
          ":host": 1234,
          ":guest": 2234,
          ":id": "port-1"
        },
        {
          ":host": 5678,
          ":guest": 6789,
          ":id": "port-2"
        }
      ]
```

#### Sources of Inspiration
1. [Bootstrapping Puppet Master Multi-node](http://wp.me/p1RD28-1kX)
2. [Deploying nginix with Puppet](https://blog.serverdensity.com/deploying-nginx-with-puppet/)
#### Useful Multi-VM Commands
The use of the specific <machine> name is optional.
* `vagrant up <machine>`
* `vagrant reload <machine>`
* `vagrant destroy -f <machine> && vagrant up <machine>`
* `vagrant status <machine>`
* `vagrant ssh <machine>`
* `vagrant global-status`
* `facter`
* `sudo tail -50 /var/log/syslog`
* `sudo tail -50 /var/log/puppet/masterhttp.log`
* `tail -50 ~/VirtualBox\ VMs/postblog/<machine>/Logs/VBox.log'

### Instructions for executing the solution
```
vagrant up # brings up all VMs
vagrant ssh puppet.example.com

sudo service puppetmaster status # test that puppet master was installed
sudo service puppetmaster stop

sudo puppet master --verbose --no-daemonize

# Shift+Ctrl+T # new tab on host
vagrant ssh node01.example.com # ssh into agent node
sudo service puppet status # test that agent was installed
sudo puppet agent --test --waitforcert=60 # initiate certificate signing request (CSR)
```
Back on the Puppet Master server (puppet.example.com)
```
sudo puppet cert list # should see 'node01.example.com' cert waiting for signature
sudo puppet cert sign --all # sign the agent node(s) cert(s)
sudo puppet cert list --all # check for signed cert(s)
```


#### Questions
 1. Describe the most difficult/painful hurdle you had to overcome in implementing your solution.

 2. Describe which puppet related concept you think is the hardest for new users to grasp.

 3. Please comment on the concept embodied by the second requirement of the solution(ii)

 4. Where did you go to find information to help you in the build process?

 5. In a couple paragraphs explain what automation means to you and why it is important to an organization's infrastructure design strategy.
