from http import HTTPStatus

import pytest

from {PROJECT}.crm.models import Person


@pytest.mark.django_db
def test_list_person(client, person):
    """
    Testa o endpoint de uma lista de pessoas.
    Testa se retorna status_code 200.
    Testa se retorna o json esperado.
    """
    Person.objects.create(**person)

    response = client.get('/api/v1/crm/persons')
    expected = {
        'items': [
            {
                'id': 1,
                'first_name': 'Pedrinho',
                'last_name': 'Silva',
                'email': 'pedrinho@email.com'
            }
        ],
        'count': 1
    }

    assert response.status_code == HTTPStatus.OK
    assert response.json() == expected


@pytest.mark.django_db
def test_get_person(client, person):
    """
    Testa o endpoint que retorna uma pessoa.
    Testa se retorna status_code 200.
    """
    Person.objects.create(**person)

    response = client.get('/api/v1/crm/persons/2')
    expected = {
        'id': 2,
        'first_name': 'Pedrinho',
        'last_name': 'Silva',
        'email': 'pedrinho@email.com'
    }

    assert response.status_code == HTTPStatus.OK
    assert response.json() == expected


@pytest.mark.django_db
def test_create_person(client, person):
    """
    Testa se o endpoint cria uma pessoa.
    Testa se retorna status_code 201.
    """
    response = client.post('/api/v1/crm/persons', person, content_type='application/json')

    expected = {
        'id': 3,
        'first_name': 'Pedrinho',
        'last_name': 'Silva',
        'email': 'pedrinho@email.com'
    }

    assert response.status_code == HTTPStatus.CREATED
    assert response.json() == expected


@pytest.mark.django_db
def test_update_person(client, person):
    """
    Testa se o endpoint edita uma pessoa.
    """
    Person.objects.create(**person)

    data = {
        'first_name': 'Pedro',
        'last_name': 'Santos',
        'email': 'pedro@email.com'
    }

    response = client.put('/api/v1/crm/persons/4', data, content_type='application/json')

    expected = {
        'id': 4,
        'first_name': 'Pedro',
        'last_name': 'Santos',
        'email': 'pedro@email.com'
    }

    assert response.status_code == HTTPStatus.OK
    assert response.json() == expected


@pytest.mark.django_db
def test_delete_person(client, person):
    """
    Testa se o endpoint deleta uma pessoa.
    """
    Person.objects.create(**person)

    response = client.delete('/api/v1/crm/persons/5')

    assert response.status_code == HTTPStatus.NO_CONTENT
