import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_docker_sock_is_exist(host):
    dockersocket = host.file("/var/run/docker.sock")
    assert dockersocket.exists
    assert dockersocket.is_socket
    assert dockersocket.group == "docker"


def test_docker_is_running(host):
    docker = host.service('docker')
    assert docker.is_running
    assert docker.is_enabled
