# django-ninja-boilerplate

#### Boilerplate to create Django project.

This boilerplate creates a simple Django project with a core app and some pre-defined settings.

The project contains:

* Settings config
* App CORE
    * Abstract models
* App CRM
    * CRUD
    * API


## Packages

Packages used in conjunction with Django.

* [Python 3.11.7](https://www.python.org/downloads/)
* [Django 5.0.*](https://www.djangoproject.com/)
* [Django Ninja 1.1.*](https://django-ninja.dev/)
* [django-extensions](https://django-extensions.readthedocs.io/en/latest/installation_instructions.html)
* [django-localflavor](https://pypi.org/project/django-localflavor/)
* [isort](https://pypi.org/project/isort/)
* [python-decouple](https://pypi.org/project/python-decouple/)
* [django-seed](https://github.com/Brobin/django-seed)


## Usage

This script run in **Unix**.

```
git clone https://github.com/rg3915/django-ninja-boilerplate.git /tmp/django-ninja-boilerplate
# Copy this file to your actual folder.
cp /tmp/django-ninja-boilerplate/boilerplatesimple.sh .
```

Update USERNAME to your username.

Type the following command. You can change the project name.

```
source boilerplatesimple.sh myproject
```


### Alias

If yout want to use a alias.

```
alias djboilerplate='git clone https://github.com/rg3915/django-ninja-boilerplate.git /tmp/django-ninja-boilerplate;
cp /tmp/django-ninja-boilerplate/boilerplatesimple.sh .
printf "Type:\n`tput setaf 2`source boilerplatesimple.sh myproject\n"'
```

### App CRM

CRM example.

```
python manage.py create_data
python manage.py runserver
```




```python
# core/apps.py
# crm/apps.py
name = 'PROJECT.<app name>'
# example
name = 'myproject.core'
name = 'myproject.crm'
```

### django-seed

To populate database with fake data, use [django-seed](https://github.com/Brobin/django-seed) and type

```
python manage.py seed crm --number=15
```

### Base Models

The app core contains abstract models to use in other models.


### management commands

The app core contains a management commands example.

```
$ python manage.py create_data --help

usage: manage.py create_data [-h] ...

Create data.
```

### Graphic model Django with PyGraphViz

```
sudo apt-get install -y graphviz libgraphviz-dev pkg-config
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
pip install pygraphviz
pip install pydot
pip install django-extensions
```



The next command generate the graphic of model.

```
python manage.py graph_models -e -g -l dot -o core.png core  # only app core
python manage.py graph_models -a -g -o models.png  # all
```


### Folders

```
.
├── backend
│   ├── api.py
│   ├── asgi.py
│   ├── core
│   │   ├── api.py
│   │   ├── apps.py
│   │   ├── management
│   │   │   └── commands
│   │   │       ├── create_data.py
│   │   ├── models.py
│   │   └── tests
│   │       └── test_api.py
│   ├── crm
│   │   ├── admin.py
│   │   ├── api.py
│   │   ├── apps.py
│   │   ├── models.py
│   │   ├── schemas.py
│   │   └── tests
│   │       ├── conftest.py
│   │       └── test_api.py
│   ├── pytest.ini
│   ├── settings.py
│   ├── urls.py
│   ├── utils
│   │   ├── progress_bar.py
│   │   └── utils.py
│   └── wsgi.py
├── contrib
│   └── env_gen.py
├── manage.py
├── README.md
└── requirements.txt
```

## Read

https://github.com/rg3915/django-boilerplate

https://github.com/rg3915/django-auth-tutorial

https://github.com/rg3915/django-custom-login-email

https://github.com/rg3915/coreui-django-ninja-boilerplate-v2
