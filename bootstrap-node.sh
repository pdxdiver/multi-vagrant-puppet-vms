#!/bin/sh

# Run on VM to bootstrap Puppet Agent nodes
# Author Dan Carr (ddcarr@gmail.com)
# Based on https://github.com/garystafford/multi-vagrant-puppet-vms.git

    wget https://apt.puppetlabs.com/puppetlabs-release-pc1-precise.deb
    sudo dpkg -i puppetlabs-release-pc1-precise.deb && \
    sudo apt-get update -yq && sudo apt-get upgrade -yq && \
    sudo apt-get install -yq puppet-agent

    sudo /opt/puppetlabs/bin/puppet resource cron puppet-agent ensure=present user=root minute=30 \
    command='/opt/puppetlabs/bin/puppet agent --onetime --no-daemonize --splay'

    sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

    # Configure /etc/hosts file
    echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "# Host config for Puppet Master and Agent Nodes" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.5    puppet.example.com  puppet" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.10   node01.example.com  node01" | sudo tee --append /etc/hosts 2> /dev/null && \

    # Add agent section to /etc/puppet/puppet.conf
    echo "" && echo "[agent]\nserver=puppet" | sudo tee --append /etc/puppetlabs/puppet/puppet.conf 2> /dev/null

    sudo /opt/puppetlabs/bin/puppet agent --enable
