# Shell script to create a Django project.

# Update USERNAME to your username.

# Usage:
# Type the following command, you can change the project name.

# source boilerplatesimple.sh myproject

# Colors
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

source /tmp/django-ninja-boilerplate/functions.sh

PROJECT=${1:-backend}

PYTHON_VERSION=3.11.7
DJANGO_VERSION=5.0.6
USERNAME="rg3915"

echo "${green}>>> Django: $DJANGO_VERSION.${reset}"

echo "${green}>>> The name of the project is '$PROJECT'.${reset}"

echo "${green}>>> LANGUAGE_CODE is pt-br.${reset}"

echo "${green}>>> Creating .gitignore${reset}"
cp /tmp/django-ninja-boilerplate/.gitignore .

create_readme
create_virtualenv
install_django
create_env_gen
create_project

edit_settings
create_api
edit_urls
create_management_commands
create_utils

echo "${green}>>> Editing core/models.py${reset}"
cp /tmp/django-ninja-boilerplate/core/models.py $PROJECT/core

edit_app_core
create_core_api

create_app_crm
edit_app_crm

add_tests

# Remove comments of settings.py
sed -i "s/# '$PROJECT.crm.apps.CrmConfig'/'$PROJECT.crm.apps.CrmConfig'/g" $PROJECT/settings.py

# migrate
python manage.py makemigrations
python manage.py migrate

# Confirm if create superuser.
create_superuser

echo "${red}>>> Important: Dont add .env in your public repository.${reset}"
echo "${red}>>> KEEP YOUR SECRET_KEY AND PASSWORDS IN SECRET!!!\n${reset}"
echo "${green}>>> [Optional] run python manage.py seed crm --number=15${reset}"
echo "${green}>>> Done${reset}"
# https://www.gnu.org/software/sed/manual/sed.html

# Remove arquivos não utilizados
remove_files

python manage.py clean_pyc

# Move this file to /tmp folder.
mv boilerplatesimple.sh /tmp
