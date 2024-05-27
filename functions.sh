create_readme() {
    echo "${green}>>> Creating README.md${reset}"
    cp /tmp/django-ninja-boilerplate/_README.md README.md

    sed -i "s/{PYTHON_VERSION}/$PYTHON_VERSION/g" README.md
    sed -i "s/{DJANGO_VERSION}/$DJANGO_VERSION/g" README.md
    sed -i "s/{USERNAME}/$USERNAME/g" README.md
    sed -i "s/{PROJECT}/$PROJECT/g" README.md
}

create_virtualenv() {
    echo "${green}>>> Creating virtualenv${reset}"
    python -m venv .venv
    echo "${green}>>> .venv is created${reset}"

    # active
    sleep 2
    echo "${green}>>> activate the .venv${reset}"
    source .venv/bin/activate
    PS1="(`basename \"$VIRTUAL_ENV\"`)\e[1;34m:/\W\e[00m$ "
    sleep 2
}

install_django() {
    # Install Django
    echo "${green}>>> Installing the Django${reset}"
    pip install -U pip
    pip install django==$DJANGO_VERSION dj-database-url django-extensions django-localflavor django-widget-tweaks django-seed isort python-decouple faker ipdb psycopg2-binary
    echo Django==$DJANGO_VERSION > requirements.txt
    pip freeze | grep dj-database-url >> requirements.txt
    pip freeze | grep django-extensions >> requirements.txt
    pip freeze | grep django-localflavor >> requirements.txt
    pip freeze | grep django-seed >> requirements.txt
    pip freeze | grep django-widget-tweaks >> requirements.txt
    pip freeze | grep Faker >> requirements.txt
    pip freeze | grep isort >> requirements.txt
    pip freeze | grep python-decouple >> requirements.txt
    pip freeze | grep psycopg2-binary >> requirements.txt
    pip install ipython[notebook]
}

create_env_gen() {
    echo "${green}>>> Creating contrib/env_gen.py${reset}"
    cp -r /tmp/django-ninja-boilerplate/contrib/ .

    echo "${green}>>> Running contrib/env_gen.py${reset}"
    python contrib/env_gen.py
}

create_project() {
    # Create project
    echo "${green}>>> Creating the project '$PROJECT' ...${reset}"
    django-admin startproject $PROJECT .
    cd $PROJECT
    echo "${green}>>> Creating the app 'core' ...${reset}"
    python ../manage.py startapp core

    echo "${green}>>> Creating the app 'accounts' ...${reset}"
    python ../manage.py startapp accounts
    # up one level
    cd ..
}

edit_settings() {
    echo "${green}>>> Editing settings.py${reset}"
    cp /tmp/django-ninja-boilerplate/settings.py $PROJECT/

    # Substitui o nome do projeto.
    sed -i "s/{PROJECT}/$PROJECT/g" $PROJECT/settings.py
    sed -i "s/{DJANGO_VERSION}/$DJANGO_VERSION/g" $PROJECT/settings.py

    sed -i "s/{LINK_VERSION}/5.0/g" $PROJECT/settings.py
    sed -i "s/# SETTINGS_IMPORT/from pathlib import Path/g" $PROJECT/settings.py
    sed -i "s/{SETTINGS_BASE_DIR}/BASE_DIR = Path(__file__).resolve().parent.parent/g" $PROJECT/settings.py
    sed -i "s/{DEFAULT_DBURL}/default_dburl = 'sqlite:\/\/\/' + str(BASE_DIR \/ 'db.sqlite3')/g" $PROJECT/settings.py
    sed -i "s/{STATIC_ROOT}/STATIC_ROOT = BASE_DIR.joinpath('staticfiles')/g" $PROJECT/settings.py
}

edit_app_core() {
    sed -i "s/core/$PROJECT.core/g" $PROJECT/core/apps.py
}

edit_app_crm() {
    sed -i "s/crm/$PROJECT.crm/g" $PROJECT/crm/apps.py
}

edit_urls() {
    echo "${green}>>> Editing urls.py${reset}"
    cp /tmp/django-ninja-boilerplate/urls.py $PROJECT/
    sed -i "s/{PROJECT}/$PROJECT/g" $PROJECT/urls.py
}

create_utils() {
    echo "${green}>>> Editing utils.${reset}"
    mkdir -p $PROJECT/utils
    cp /tmp/django-ninja-boilerplate/utils/* $PROJECT/utils
    sed -i "s/{PROJECT}/$PROJECT/g" $PROJECT/core/management/commands/create_data.py
}

create_management_commands() {
    echo "${green}>>> Editing management/commands.${reset}"
    mkdir -p $PROJECT/core/management/commands
    cp /tmp/django-ninja-boilerplate/core/management/commands/* $PROJECT/core/management/commands
}

edit_crm_admin() {
    echo "${green}>>> Editing crm/admin.py${reset}"
    cp /tmp/django-ninja-boilerplate/crm/admin.py $PROJECT/crm
}

edit_crm_models() {
    echo "${green}>>> Editing crm/models.py${reset}"
    cp /tmp/django-ninja-boilerplate/crm/models.py $PROJECT/crm
    sed -i "s/{PROJECT}/$PROJECT/g" $PROJECT/crm/models.py
}

edit_crm_schemas() {
    echo "${green}>>> Editing crm/schemas.py${reset}"
    cp /tmp/django-ninja-boilerplate/crm/schemas.py $PROJECT/crm
    sed -i "s/{PROJECT}/$PROJECT/g" $PROJECT/crm/schemas.py
}

edit_crm_api() {
    echo "${green}>>> Editing crm/api.py${reset}"
    cp /tmp/django-ninja-boilerplate/crm/api.py $PROJECT/crm
    sed -i "s/{PROJECT}/$PROJECT/g" $PROJECT/crm/api.py
}

create_app_crm() {
    echo "${green}>>> Creating the app 'crm' ...${reset}"
    cd $PROJECT
    python ../manage.py startapp crm
    cd ..

    edit_crm_admin
    edit_crm_models
    edit_crm_schemas
    edit_crm_api
}

create_superuser() {
    echo "${green}>>> Creating a 'admin' user ...${reset}"
    echo "${green}>>> The password must contain at least 8 characters.${reset}"
    echo "${green}>>> Password suggestions: demodemo${reset}"
    python manage.py createsuperuser --username='admin' --email=''
}
