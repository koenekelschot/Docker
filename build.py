import glob
import os
import json
import subprocess
from jinja2 import FileSystemLoader, Environment

def get_ssh_path(path: str) -> str:
    user = os.getenv('SSH_USER')
    host = os.getenv('SSH_HOST')
    folder = os.getenv('SSH_FOLDER_DOCKER')
    return user + '@' + host + ':' + folder + '/' + path

def download_remote_file(path: str) -> None:
    print("Downloading " + path)
    subprocess.run(["rsync", "-athv", get_ssh_path(path), path])

def get_version_from_file(path: str) -> str:
    with open(path, "r") as file:
        return file.read()

def merge_files(source_path: str, merge_paths: list[str], prefix_merged_lines: str = "") -> None:
    with open(source_path, "r") as source_file:
        lines = source_file.readlines()
    for path in merge_paths:
        with open(path, "r") as merge_file:
            lines.append(os.linesep)
            lines.append("# original file: " + path)
            lines.append(os.linesep)
            for line in merge_file.readlines():
                lines.append(prefix_merged_lines + line)
    with open(source_path, "w") as target_file:
        target_file.writelines(lines)

def remove_files(files: list[str]) -> None:
    for file in files:
        os.remove(file)

def import_env() -> dict:
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

def transform_deploy_scripts(variables: dict) -> None:
    for source_path in glob.glob("**/deploy.jinja2.sh", recursive=True):
        print("Transforming: " + source_path)
        target_path = source_path.replace(".jinja2.", ".")
        env = Environment(loader=FileSystemLoader("."))
        template = env.get_template(source_path)
        with open(target_path, "w") as target_file:
            target_file.write(template.render(variables))
        os.remove(source_path)

def merge_deploy_scripts() -> None:
    to_merge = glob.glob("projects/**/deploy.sh", recursive=True)
    merge_files("deploy.sh", to_merge)
    remove_files(to_merge)

def transform_jinja_files(variables: dict) -> None:
    for source_path in glob.glob("projects/**/*.jinja2.*", recursive=True):
        print("Transforming: " + source_path)
        target_path = source_path.replace(".jinja2.", ".")
        env = Environment(loader=FileSystemLoader("."))
        template = env.get_template(source_path)
        with open(target_path, "w") as target_file:
            target_file.write(template.render(variables))
        os.remove(source_path)

def merge_docker_compose() -> None:
    to_merge = glob.glob("projects/**/*.yml", recursive=False)
    merge_files("docker-compose.yml", to_merge, "  ")
    remove_files(to_merge)

def merge_post_deploy_scripts() -> None:
    to_merge = glob.glob("projects/**/post-deploy.sh", recursive=False)
    merge_files("post-deploy.sh", to_merge)
    remove_files(to_merge)

env_json = import_env()

transform_deploy_scripts(env_json)
merge_deploy_scripts()
merge_post_deploy_scripts()

transform_jinja_files(env_json)
merge_docker_compose()