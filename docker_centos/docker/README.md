Docker
=========

A role this install and set up docker

Requirements
------------

None

Role Variables
--------------

- docker_ce_name (default: docker-ce)
- docker_ce_version (default: 18.09.0)
- docker_ce_cli_name (default: docker-ce-cli)
- docker_ce_cli_version (default: 18.09.0)
- docker_containerd_name (default: containerd.io)
- docker_containerd_version (default: 1.2.5)

- docker_service_state: (default: started)
- docker_service_enabled: (default: yes)
- docker_restart_handler_state: (default: restarted)

- docker_socket_user: (default: the user that ansible use)
- docker_socket_group: (default: docker)
- docker_socket_mode: (default: 770)

- docker_yum_repository: (default: https://download.docker.com/linux/centos/7/x86_64/stable/)
- docker_yum_gpg_key_url: (default: "https://download.docker.com/linux/centos/gpg")

- epel_repo_url: (default: "http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm")


Dependencies
------------

none

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: docker }

Author Information
------------------

Andre Bergemann
andre.bergemann@flavia-it.de
