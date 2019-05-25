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


def test_docker_python(host):
    docker_py = host.pip_package.get_packages(pip_path='/usr/bin/pip')
    assert 'docker' in docker_py
    assert 'docker-compose' in docker_py


def test_docker_toolset(host):
    toolset_dir = host.file("/opt/docker-tools/")
    assert toolset_dir.exists
    assert toolset_dir.is_directory


def test_docker_daemon_config(host):
    docker_daemon = host.file("/etc/docker/daemon.json")
    assert docker_daemon.exists
