import glob
import os
import json
import subprocess
from jinja2 import FileSystemLoader, Environment

def get_ssh_path(path):
    user = os.getenv('SSH_USER')
    host = os.getenv('SSH_HOST')
    folder = os.getenv('SSH_FOLDER_DOCKER')
    return user + '@' + host + ':' + folder + '/' + path

def download_remote_file(path):
    print("Downloading " + path)
    subprocess.run(["rsync", "-athv", get_ssh_path(path), path])

def get_version_from_file(path):
    with open(path, "r") as file:
        return file.read()

def import_env():
    print("Import env variables")
    download_remote_file("env.json")
    download_remote_file(".HA_VERSION")
    download_remote_file(".ESPHOME_VERSION")
    with open("env.json", "r") as input_file:
        data = json.load(input_file)
    data["hass_version"] = get_version_from_file(".HA_VERSION")
    data["esphome_version"] = get_version_from_file(".ESPHOME_VERSION")
    data["ssh_user"] = os.getenv('SSH_USER')
    os.remove("env.json")
    os.remove(".HA_VERSION")
    os.remove(".ESPHOME_VERSION")
    return data

def transform_deploy_scripts(variables):
    for source_path in glob.glob("**/deploy.jinja2.sh", recursive=True):
        print("Transforming: " + source_path)
        target_path = source_path.replace(".jinja2.", ".")
        env = Environment(loader=FileSystemLoader("."))
        template = env.get_template(source_path)
        with open(target_path, "w") as target_file:
            target_file.write(template.render(variables))
        os.remove(source_path)

def combine_deploy_scripts():
    with open("deploy.sh", "r") as source_file:
        lines = source_file.readlines()
    for path in glob.glob("projects/**/deploy.sh", recursive=True):
        with open(path, "r") as merge_file:
            lines.append(os.linesep)
            for line in merge_file.readlines():
                lines.append(line)
        os.remove(path)
    with open("deploy.sh", "w") as target_file:
        target_file.writelines(lines)

def transform_jinja_files(variables):
    for source_path in glob.glob("projects/**/*.jinja2.*", recursive=True):
        print("Transforming: " + source_path)
        target_path = source_path.replace(".jinja2.", ".")
        env = Environment(loader=FileSystemLoader("."))
        template = env.get_template(source_path)
        with open(target_path, "w") as target_file:
            target_file.write(template.render(variables))
        os.remove(source_path)

def combine_docker_compose():
    with open("docker-compose.yml", "r") as source_file:
        lines = source_file.readlines()
    for path in glob.glob("projects/**/*.yml", recursive=False):
        with open(path, "r") as merge_file:
            for line in merge_file.readlines():
                lines.append(line)
        os.remove(path)
    with open("docker-compose.yml", "w") as target_file:
        target_file.writelines(lines)

env_json = import_env()
transform_deploy_scripts(env_json)
combine_deploy_scripts()
transform_jinja_files(env_json)
combine_docker_compose()
